#!/usr/bin/env bash

echo "Creating  necessary tables in the database DB for Harvesting ..."
ckan -c "${CKAN_INI}" harvester initdb
echo "Creating  necessary tables in the database DB for Harvesting ...done!"
