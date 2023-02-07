#!/usr/bin/env bash

REPO="ghcr.io/tum-gis/ckan-sddi-social"
CKAN_VERSION=${1:-2.9.5}

# Build with verbose output
docker build . \
  --progress=plain \
  --build-arg CKAN_VERSION="$CKAN_VERSION" \
  -t "$REPO:$CKAN_VERSION"

docker push "$REPO:$CKAN_VERSION"
