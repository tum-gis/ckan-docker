#!/usr/bin/env bash

echo "Create categories, and topics ..."
envsubst < "$APP_DIR/docker-afterinit.d/groups.jsonl" > "$APP_DIR/docker-afterinit.d/groups_subst.jsonl"
ckanapi batch -c "${APP_DIR}/production.ini" -I "$APP_DIR/docker-afterinit.d/groups_subst.jsonl"
echo "Create categories, and topics ...done!"
