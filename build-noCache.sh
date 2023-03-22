#!/usr/bin/env bash

IMAGE_REPOSITORY="${1:-ghcr.io/tum-gis}"
IMAGE_TAG="${2:-edge}"

printf "\n\nIMAGE_REPOSITORY=$IMAGE_REPOSITORY\nIMAGE_TAG=${IMAGE_TAG}\n\n"

# sddi-base ###################################################################
cd sddi-base

# edge
docker build . \
  --no-cache \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}"

# edge-debug
docker build . -f Dockerfile.debug \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}-debug"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi-base:${IMAGE_TAG}-debug"
printf "\n\n"

# sddi ########################################################################
cd ../sddi

# edge
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}"

# edge-debug
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi-base" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG}-debug \
  -t "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}-debug"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi:${IMAGE_TAG}-debug"
printf "\n\n"

# sddi-social #################################################################
cd ../sddi-social

# edge
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG} \
  -t "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}"

# edge-debug
docker build . \
  --no-cache \
  --build-arg "BASEIMAGE_REPOSITORY=$IMAGE_REPOSITORY/ckan-sddi" \
  --build-arg BASEIMAGE_VERSION=${IMAGE_TAG}-debug \
  -t "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}-debug"

docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_REPOSITORY/ckan-sddi-social:${IMAGE_TAG}-debug"

cd ..
printf "\n\n"

# Image digests ###############################################################
# printf "\n################## Image digests ##################\n"
#
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi-base:${IMAGE_TAG}"
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi-base:${IMAGE_TAG}-debug"
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi:${IMAGE_TAG}"
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi:${IMAGE_TAG}-debug"
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi-social:${IMAGE_TAG}"
# docker inspect --format='{{index .RepoDigests 0}}' "${IMAGE_REPOSITORY}/ckan-sddi-social:${IMAGE_TAG}-debug"
