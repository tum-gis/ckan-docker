#!/usr/bin/env bash

REPO="ghcr.io/tum-gis/ckan-sddi-base"
CKAN_VERSION=${1:-2.9.7}

# Build with verbose output
docker build . \
  --progress=plain \
  --build-arg CKAN_VERSION="$CKAN_VERSION" \
  -t "$REPO:$CKAN_VERSION"
