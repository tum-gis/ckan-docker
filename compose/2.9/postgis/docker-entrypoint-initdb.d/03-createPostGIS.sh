    #!/bin/bash
    set -e

    echo "Create PostGIS..."

    export PGPASSWORD="$POSTGRES_PASSWORD"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
      --dbname {{ .Values.global.db.dbname | default .Values.db.dbname | quote }} <<-EOSQL

    CREATE EXTENSION postgis;
    ALTER VIEW geometry_columns OWNER TO {{ .Values.global.db.auth.username | default .Values.db.auth.username | quote }};
    ALTER TABLE spatial_ref_sys OWNER TO {{ .Values.global.db.auth.username | default .Values.db.auth.username | quote }};

    EOSQL

    echo "Create PostGIS...done!"
