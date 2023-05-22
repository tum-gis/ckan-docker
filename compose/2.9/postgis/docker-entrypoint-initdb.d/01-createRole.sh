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
          WHERE  rolname = {{ .Values.global.datastore.auth.rw.username | default .Values.datastore.auth.rw.username | squote }}) THEN

          RAISE NOTICE 'Role {{ .Values.global.datastore.auth.rw.username | default .Values.datastore.auth.rw.username | quote }} already exists. Skipping.';
      ELSE
        CREATE ROLE {{ .Values.global.datastore.auth.rw.username | default .Values.datastore.auth.rw.username | quote }}
          NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
          PASSWORD {{ .Values.global.datastore.auth.rw.password | default .Values.datastore.auth.rw.password | squote }};
      END IF;
    END
    \$do\$;

    -- Datastore RO
    DO
    \$do\$
    BEGIN
      IF EXISTS (
          SELECT FROM pg_catalog.pg_roles
          WHERE  rolname = {{ .Values.global.datastore.auth.ro.username | default .Values.datastore.auth.ro.username | squote }}) THEN

          RAISE NOTICE 'Role {{ .Values.global.datastore.auth.ro.username | default .Values.datastore.auth.ro.username | quote }} already exists. Skipping.';
      ELSE
        CREATE ROLE {{ .Values.global.datastore.auth.ro.username | default .Values.datastore.auth.ro.username | quote }}
          NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
          PASSWORD {{ .Values.global.datastore.auth.ro.password | default .Values.datastore.auth.ro.password | squote }};
      END IF;
    END
    \$do\$;

    -- Datapusher
    DO
    \$do\$
    BEGIN
      IF EXISTS (
          SELECT FROM pg_catalog.pg_roles
          WHERE  rolname = {{ .Values.global.datapusher.db.auth.username | default .Values.datapusher.auth.username | squote }}) THEN

          RAISE NOTICE 'Role {{ .Values.global.datapusher.db.auth.username | default .Values.datapusher.auth.username  | quote }} already exists. Skipping.';
      ELSE
        CREATE ROLE {{ .Values.global.datapusher.db.auth.username | default .Values.datapusher.auth.username | quote }}
          NOSUPERUSER NOCREATEDB NOCREATEROLE LOGIN
          PASSWORD {{ .Values.global.datapusher.db.auth.password | default .Values.datapusher.auth.password  | squote }};
      END IF;
    END
    \$do\$;

    EOSQL

    echo "Create roles...done!"
