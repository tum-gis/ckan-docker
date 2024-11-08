#!/bin/bash
set -e

echo "Create PostGIS..."

export PGPASSWORD="$POSTGRES_PASSWORD"
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" \
  --dbname "$CKAN_DB_NAME" <<-EOSQL

CREATE EXTENSION postgis;
ALTER VIEW geometry_columns OWNER TO "$CKAN_DB_USERNAME";
ALTER TABLE spatial_ref_sys OWNER TO "$CKAN_DB_USERNAME";

EOSQL

echo "Create PostGIS...done!"
