#!/usr/bin/env bash

echo "Create SDDI categories, topics, groups, and organizations ..."
ckan -c "${CKAN_INI}" theme-sddi init_data
echo "Create SDDI categories, topics, groups, and organizations ...done!"