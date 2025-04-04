#!/usr/bin/env bash

echo "Upgrading database for security plugin ..."
ckan -c "${CKAN_INI}" db upgrade -p security || true
echo "Upgrading database for security plugin ...done!"