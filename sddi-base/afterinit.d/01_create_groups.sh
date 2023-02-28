#!/usr/bin/env bash

echo "Create SDDI categories, topics, groups, and organizations ..."
ckan -c "${APP_DIR}/production.ini" grouphierarchy init_data
echo "Create SDDI categories, topics, groups, and organizations ...done!"
