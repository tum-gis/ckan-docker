-- 02-databases.sql (connected to DB "postgres" as superuser)
CREATE EXTENSION IF NOT EXISTS dblink;

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'ckan') THEN
    PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE ckan');
    EXECUTE 'ALTER DATABASE ckan OWNER TO ckan';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datastore') THEN
    PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE datastore');
    EXECUTE 'ALTER DATABASE datastore OWNER TO ckan';
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'datapusher') THEN
    PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE datapusher');
    EXECUTE 'ALTER DATABASE datapusher OWNER TO datapusher';
  END IF;
END $$;
