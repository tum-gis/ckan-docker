###############################################################################
# Build stage
###############################################################################
ARG CKAN_VERSION_BUILD_STAGE=2.9.7-dev
ARG CKAN_VERSION_BUILD_SPATIAL=2.9.7-focal
ARG CKAN_VERSION_RUNTIME_STAGE=2.9.7-focal

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

# ckanext-hierarchy ###########################################################
ARG CKANEXT_HIERARCHY_VERSION="v1.2.0"
ENV CKANEXT_HIERARCHY_VERSION=${CKANEXT_HIERARCHY_VERSION}

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git@${CKANEXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
  curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-grouphierarchy ######################################################
ARG CKANEXT_SDDI_VERSION="2.9-support"
ENV CKANEXT_SDDI_VERSION=${CKANEXT_SDDI_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-grouphierarchy-sddi.git@${CKANEXT_SDDI_VERSION}#egg=ckanext-grouphierarchy && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKANEXT_SDDI_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-grouphierarchy.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKANEXT_SDDI_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-relation ############################################################
ARG CKANEXT_RELATION_VERSION="1.0.0"
ENV CKANEXT_RELATION_VERSION=${CKANEXT_RELATION_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-relation-sddi.git@${CKANEXT_RELATION_VERSION}#egg=ckanext-relation && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-relation.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-scheming ############################################################
ARG CKANEXT_SCHEMING_VERSION="scheming_all_plugins"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext datesearch ##########################################################
ARG CKANEXT_DATESEARCH_VERSION="datesearch_and_spatial"
ENV CKANEXT_DATESEARCH_VERSION=${CKANEXT_DATESEARCH_VERSION}
ENV CKANEXT_DATESEARCH_VERSION_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-datesearch"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DATESEARCH_VERSION_GITHUB_URL}.git@${CKANEXT_DATESEARCH_VERSION}#egg=ckanext-datesearch

# ckanext-composite ###########################################################
ARG CKANEXT_COMPOSITE_VERSION="master"
ENV CKANEXT_COMPOSITE_VERSION=${CKANEXT_COMPOSITE_VERSION}
ENV CKANEXT_COMPOSITE_GITHUB_URL="https://github.com/EnviDat/ckanext-composite"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/EnviDat/ckanext-composite/${CKANEXT_COMPOSITE_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_COMPOSITE_GITHUB_URL}.git@${CKANEXT_COMPOSITE_VERSION}#egg=ckanext-composite

# ckanext-repeating ###########################################################
ARG CKANEXT_REPEATING_VERSION="master"
ENV CKANEXT_REPEATING_VERSION=${CKANEXT_REPEATING_VERSION}
ENV CKANEXT_REPEATING_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-repeating"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_REPEATING_GITHUB_URL}.git@${CKANEXT_REPEATING_VERSION}#egg=ckanext-repeating

# ckanext-spatial #############################################################
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION_BUILD_SPATIAL} as extbuild-spatial

ARG CKANEXT_SPATIAL_VERSION="scheming-spatial"
ENV CKANEXT_SPATIAL_VERSION=${CKANEXT_SPATIAL_VERSION}

USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
  python3-dev python3-pip libxml2-dev libxslt1-dev libgeos-c1v5 python-is-python3 && \
  mkdir -p /wheels && \
  pip install -U pip

RUN set -ex && \
  pip install -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-spatial.txt \
    https://raw.githubusercontent.com/MarijaKnezevic/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  pip install -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-postgis.txt && \
  curl -o /wheels/ckanext-spatial-postgis.txt \
    https://raw.githubusercontent.com/MarijaKnezevic/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-postgis.txt && \
    ls -lah /wheels

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/MarijaKnezevic/ckanext-spatial.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

###############################################################################
# Runtime stage
###############################################################################
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION_RUNTIME_STAGE} as runtime

ENV CKAN__PLUGINS "image_view text_view recline_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query datesearch repeating composite scheming_datasets \
  envvars"

# Extra env for compatibility with ckan/base Docker images for downstream k8s
ENV CKAN_INI=${APP_DIR}/production.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan
ENV TZ="UTC"

USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libxml2-dev libxslt1-dev libgeos-c1v5 && \
    pip install --no-cache-dir -U pip && \
    rm -rf /var/lib/apt/lists/*

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels
COPY --from=extbuild-spatial /wheels ${APP_DIR}/ext_wheels

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-hierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-hierarchy

# ckanext-grouphierarchy ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-grouphierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-grouphierarchy

# ckanext-relation ############################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-relation.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-spatial #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial.txt && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial-postgis.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-spatial

# ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-composite ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-composite

# ckanext-repeating ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-repeating

# Copy init scripts and additional files
COPY --chown=ckan:ckan initScripts/ ${APP_DIR}/docker-afterinit.d

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.repeating:presets.json ckanext.composite:presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  echo "${TZ}" > /etc/timezone && \
  mkdir -p ${CKAN_STORAGE_PATH} && \
  chown -R ckan:ckan ${APP_DIR} ${CKAN_STORAGE_PATH} && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
