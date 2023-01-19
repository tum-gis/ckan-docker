#!/usr/bin/env bash

REPO="reg.gitlab.brunowillenborg.de/ckan/sddi"
CKAN_VERSION=${1:-2.9.5}

# Build with verbose output
docker build . \
  --progress=plain \
  --build-arg CKAN_VERSION="$CKAN_VERSION" \
  -t "$REPO:$CKAN_VERSION"
