#!/bin/bash

# Following script is taken from
# https://raw.githubusercontent.com/ckan/ckan/2.9/ckanext/datastore/set_permissions.sql

set -e

echo "Set datastore permissions..."

export PGPASSWORD="$POSTGRES_PASSWORD"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
    --dbname "$DATASTORE_DB_NAME" <<-EOSQL

    -- revoke permissions for the read-only user
    REVOKE CREATE ON SCHEMA public FROM PUBLIC;
    REVOKE USAGE ON SCHEMA public FROM PUBLIC;

    GRANT CREATE ON SCHEMA public TO "$CKAN_DB_USERNAME";
    GRANT USAGE ON SCHEMA public TO "$CKAN_DB_USERNAME";

    GRANT CREATE ON SCHEMA public TO "$DATASTORE_DB_RW_USERNAME";
    GRANT USAGE ON SCHEMA public TO "$DATASTORE_DB_RW_USERNAME";

    -- take connect permissions from main db
    REVOKE CONNECT ON DATABASE "$CKAN_DB_NAME" FROM "$DATASTORE_DB_RO_USERNAME";

    -- grant select permissions for read-only user
    GRANT CONNECT ON DATABASE "$DATASTORE_DB_NAME" TO "$DATASTORE_DB_RO_USERNAME";
    GRANT USAGE ON SCHEMA public TO "$DATASTORE_DB_RO_USERNAME";

    -- grant access to current tables and views to read-only user
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO "$DATASTORE_DB_RO_USERNAME";

    -- grant access to new tables and views by default
    ALTER DEFAULT PRIVILEGES FOR USER "$DATASTORE_DB_RW_USERNAME" IN SCHEMA public
    GRANT SELECT ON TABLES TO "$DATASTORE_DB_RO_USERNAME";

    -- a view for listing valid table (resource id) and view names
    CREATE OR REPLACE VIEW "_table_metadata" AS
        SELECT DISTINCT
            substr(md5(dependee.relname || COALESCE(dependent.relname, '')), 0, 17) AS "_id",
            dependee.relname AS name,
            dependee.oid AS oid,
            dependent.relname AS alias_of
        FROM
            pg_class AS dependee
            LEFT OUTER JOIN pg_rewrite AS r ON r.ev_class = dependee.oid
            LEFT OUTER JOIN pg_depend AS d ON d.objid = r.oid
            LEFT OUTER JOIN pg_class AS dependent ON d.refobjid = dependent.oid
        WHERE
            (dependee.oid != dependent.oid OR dependent.oid IS NULL) AND
            -- is a table (from pg_tables view definition)
            -- or is a view (from pg_views view definition)
            (dependee.relkind = 'r'::"char" OR dependee.relkind = 'v'::"char")
            AND dependee.relnamespace = (
                SELECT oid FROM pg_namespace WHERE nspname='public')
        ORDER BY dependee.oid DESC;
    ALTER VIEW "_table_metadata" OWNER TO "$DATASTORE_DB_RW_USERNAME";
    GRANT SELECT ON "_table_metadata" TO "$DATASTORE_DB_RO_USERNAME";

    -- _full_text fields are now updated by a trigger when set to NULL
    CREATE OR REPLACE FUNCTION populate_full_text_trigger() RETURNS trigger
    AS \$body\$
        BEGIN
            IF NEW._full_text IS NOT NULL THEN
                RETURN NEW;
            END IF;
            NEW._full_text := (
                SELECT to_tsvector(string_agg(value, ' '))
                FROM json_each_text(row_to_json(NEW.*))
                WHERE key NOT LIKE '\_%');
            RETURN NEW;
        END;
    \$body\$ LANGUAGE plpgsql;
    ALTER FUNCTION populate_full_text_trigger() OWNER TO "$DATASTORE_DB_RW_USERNAME";

    -- migrate existing tables that don't have full text trigger applied
    DO \$body\$
        BEGIN
            EXECUTE coalesce(
                (SELECT string_agg(
                    'CREATE TRIGGER zfulltext BEFORE INSERT OR UPDATE ON ' ||
                    quote_ident(relname) || ' FOR EACH ROW EXECUTE PROCEDURE ' ||
                    'populate_full_text_trigger();', ' ')
                FROM pg_class
                LEFT OUTER JOIN pg_trigger AS t
                    ON t.tgrelid = relname::regclass AND t.tgname = 'zfulltext'
                WHERE relkind = 'r'::"char" AND t.tgname IS NULL
                    AND relnamespace = (
                        SELECT oid FROM pg_namespace WHERE nspname='public')),
                'SELECT 1;');
        END;
    \$body\$;

EOSQL

echo "Set datastore permissions...done!"
