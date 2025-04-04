#!/usr/bin/env bash

echo "Upgrading database for heroslideradmin plugin ..."
ckan -c "${CKAN_INI}" db upgrade -p heroslideradmin || true
echo "Upgrading database for heroslideradmin plugin ...done!"