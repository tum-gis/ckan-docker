   #!/bin/bash
    set -e

    echo "Create databases..."

    export PGPASSWORD="$POSTGRES_PASSWORD"

    # CKAN database
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
      "SELECT 1 FROM pg_database WHERE datname = {{ .Values.global.db.dbname | default .Values.db.dbname | squote }}" | grep -q 1 || \
      psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

      CREATE DATABASE {{ .Values.global.db.dbname | default .Values.db.dbname | quote }}
      OWNER {{ .Values.global.db.auth.username | default .Values.db.auth.username | quote }}
      ENCODING 'utf-8';

    EOSQL

    # Datastore database
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
      "SELECT 1 FROM pg_database WHERE datname = {{ .Values.global.datastore.dbname | default .Values.datastore.dbname | squote }}" | grep -q 1 || \
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

      CREATE DATABASE {{ .Values.global.datastore.dbname | default .Values.datastore.dbname | quote }}
      OWNER {{ .Values.global.datastore.auth.rw.username | default .Values.datastore.auth.rw.username | quote }}
      ENCODING 'utf-8';

    EOSQL

    # Datapusher jobs database
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
      "SELECT 1 FROM pg_database WHERE datname = {{ .Values.global.datapusher.db.dbname | default .Values.datapusher.dbname | squote }}" | grep -q 1 || \
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

      CREATE DATABASE {{ .Values.global.datapusher.db.dbname | default .Values.datapusher.dbname | quote }}
      OWNER {{ .Values.global.datapusher.db.auth.username | default .Values.datapusher.auth.username  | quote }}
      ENCODING 'utf-8';

    EOSQL

    echo "Create databases...done!"
