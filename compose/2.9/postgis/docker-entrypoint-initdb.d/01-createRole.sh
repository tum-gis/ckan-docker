#!/bin/bash
set -e

echo "Create roles..."

export PGPASSWORD="$POSTGRES_PASSWORD"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

-- CKAN role
DO
\$do\$
BEGIN
  IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$CKAN_DB_USERNAME') THEN

      RAISE NOTICE 'Role "$CKAN_DB_USERNAME" already exists. Skipping.';
  ELSE
    CREATE ROLE "$CKAN_DB_USERNAME"
      NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
      PASSWORD '$CKAN_DB_PASSWORD';
  END IF;
END
\$do\$;

-- Datastore RW
DO
\$do\$
BEGIN
  IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$DATASTORE_DB_RW_USERNAME') THEN

      RAISE NOTICE 'Role "$DATASTORE_DB_RW_USERNAME" already exists. Skipping.';
  ELSE
    CREATE ROLE "$DATASTORE_DB_RW_USERNAME"
      NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
      PASSWORD '$DATASTORE_DB_RW_PASSWORD';
  END IF;
END
\$do\$;

-- Datastore RO
DO
\$do\$
BEGIN
  IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$DATASTORE_DB_RO_USERNAME') THEN

      RAISE NOTICE 'Role "$DATASTORE_DB_RO_USERNAME" already exists. Skipping.';
  ELSE
    CREATE ROLE "$DATASTORE_DB_RO_USERNAME"
      NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
      PASSWORD '$DATASTORE_DB_RO_PASSWORD';
  END IF;
END
\$do\$;

-- Datapusher
DO
\$do\$
BEGIN
  IF EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = '$DATAPUSHER_DB_USERNAME') THEN

      RAISE NOTICE 'Role "$DATAPUSHER_DB_USERNAME" already exists. Skipping.';
  ELSE
    CREATE ROLE "$DATAPUSHER_DB_USERNAME"
      NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
      PASSWORD '$DATAPUSHER_DB_PASSWORD';
  END IF;
END
\$do\$;

EOSQL

echo "Create roles...done!"
