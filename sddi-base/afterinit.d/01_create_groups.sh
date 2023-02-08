#!/usr/bin/env bash

echo "Create SDDI categories, topics, groups, and organizations ..."
envsubst < "$APP_DIR/docker-afterinit.d/groups.jsonl" > "$APP_DIR/docker-afterinit.d/groups_subst.jsonl"
ckan -c "${APP_DIR}/production.ini" api batch -c "${APP_DIR}/production.ini" -I "$APP_DIR/docker-afterinit.d/groups_subst.jsonl"
echo "Create SDDI categories, topics, groups, and organizations ...done!"
