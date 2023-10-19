#!/usr/bin/env bash

echo "Migrate ckanext-security DB ..."
ckan -c "${CKAN_INI}" security migrate
echo "Migrate ckanext-security DB ...done!"
