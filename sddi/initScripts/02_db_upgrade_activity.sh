
#!/usr/bin/env bash

echo "Upgrading database for activity plugin ..."
ckan -c "${CKAN_INI}" db upgrade -p activity || true
echo "Upgrading database for activity plugin ...done!"