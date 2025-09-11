DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='ckan')         THEN CREATE ROLE ckan         LOGIN PASSWORD 'changeMe'; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='datastore_rw') THEN CREATE ROLE datastore_rw LOGIN PASSWORD 'changeMe'; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='datastore_ro') THEN CREATE ROLE datastore_ro LOGIN PASSWORD 'changeMe'; END IF;
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname='datapusher')   THEN CREATE ROLE datapusher   LOGIN PASSWORD 'changeMe'; END IF;
END $$;