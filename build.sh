#!/usr/bin/env bash

IMAGE_REPOSITORY="${1:-ghcr.io/tum-gis}"
IMAGE_TAG="${2:-devel}"

printf "\n\nIMAGE_REPOSITORY=$IMAGE_REPOSITORY\nIMAGE_TAG=${IMAGE_TAG}\n\n"

# sddi-base ###################################################################
cd sddi-base

# sddi-base:TAG
docker build . \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}"

# sddi-base:TAG-debug
docker build . -f Dockerfile.debug \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}-debug"

printf "\n\n"

# sddi ########################################################################
cd ../sddi

# sddi:TAG
docker build . \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}"

# sddi:TAG-debug
docker build . \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG}-debug \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}-debug"

printf "\n\n"

# sddi-social #################################################################
cd ../sddi-social

# sddi-social:TAG
docker build . \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}"

# sddi-social:TAG-debug
docker build . \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG}-debug \
  -t "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}-debug"

cd ..
printf "\n\n"
