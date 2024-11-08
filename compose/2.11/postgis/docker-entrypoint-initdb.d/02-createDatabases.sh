#!/bin/bash
set -e

echo "Create databases..."

export PGPASSWORD="$POSTGRES_PASSWORD"

# CKAN database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
  "SELECT 1 FROM pg_database WHERE datname = '$CKAN_DB_NAME'" | grep -q 1 || \
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

  CREATE DATABASE "$CKAN_DB_NAME"
  OWNER "$CKAN_DB_USERNAME"
  ENCODING 'utf-8';

EOSQL

# Datastore database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
  "SELECT 1 FROM pg_database WHERE datname = '$DATASTORE_DB_NAME'" | grep -q 1 || \
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

  CREATE DATABASE "$DATASTORE_DB_NAME"
  OWNER "$DATASTORE_DB_RW_USERNAME"
  ENCODING 'utf-8';

EOSQL

# Datapusher jobs database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -tc \
  "SELECT 1 FROM pg_database WHERE datname = '$DATAPUSHER_DB_NAME'" | grep -q 1 || \
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

  CREATE DATABASE "$DATAPUSHER_DB_NAME"
  OWNER "$DATAPUSHER_DB_USERNAME"
  ENCODING 'utf-8';

EOSQL

echo "Create databases...done!"
