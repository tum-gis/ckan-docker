#!/usr/bin/env bash

echo "Setting CKAN site URL in ckan.ini ..."
sed -i 's|^ckan\.site_url *= *.*|ckan.site_url = '"${CKAN_SITE_URL}"'|' ckan.ini
echo "CKAN site URL updated to ${CKAN_SITE_URL}"