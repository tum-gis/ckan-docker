#!/usr/bin/env bash

IMAGE_REPOSITORY="${1:-ghcr.io/tum-gis}"
IMAGE_TAG="${2:-devel}"

printf "\n\nIMAGE_REPOSITORY=$IMAGE_REPOSITORY\nIMAGE_TAG=${IMAGE_TAG}\n\n"

# sddi-base ###################################################################
cd sddi-base

# sddi-base:TAG
docker build . \
  --no-cache \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}"

# sddi-base:TAG-debug
docker build . -f Dockerfile.debug \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}-debug"

printf "\n\n"

# sddi ########################################################################
cd ../sddi

# sddi:TAG
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}"

# sddi:TAG-debug
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}-debug"

printf "\n\n"
