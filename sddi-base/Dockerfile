###############################################################################
# Build stage
###############################################################################
ARG CKAN_VERSION_BUILD_STAGE=2.9.7-dev
ARG CKAN_VERSION_BUILD_SPATIAL=2.9.7-focal
ARG CKAN_VERSION_RUNTIME_STAGE=2.9.7-focal

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

# ckanext-hierarchy ###########################################################
ARG CKAN_EXT_HIERARCHY_VERSION=master
ENV CKAN_EXT_HIERARCHY_VERSION=${CKAN_EXT_HIERARCHY_VERSION}

USER root

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git@${CKAN_EXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
  curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-grouphierarchy ######################################################
ARG CKAN_EXT_SDDI_VERSION="2.9-support"
ENV CKAN_EXT_SDDI_VERSION=${CKAN_EXT_SDDI_VERSION}

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-grouphierarchy-sddi.git@${CKAN_EXT_SDDI_VERSION}#egg=ckanext-grouphierarchy && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKAN_EXT_SDDI_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-grouphierarchy.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKAN_EXT_SDDI_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-relation ############################################################
ARG CKAN_EXT_RELATION_VERSION="ckan-2.9"
ENV CKAN_EXT_RELATION_VERSION=${CKAN_EXT_RELATION_VERSION}

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-relation-sddi.git@${CKAN_EXT_RELATION_VERSION}#egg=ckanext-relation && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKAN_EXT_RELATION_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-relation.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKAN_EXT_RELATION_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-scheming ############################################################
ARG CKAN_EXT_SCHEMING_VERSION="release-3.0.0"
ENV CKAN_EXT_SCHEMING_VERSION=${CKAN_EXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com/ckan/ckanext-scheming"

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKAN_EXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext-spatial #############################################################
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION_BUILD_SPATIAL} as extbuild-spatial

ARG CKANEXT_SPATIAL_VERSION="v2.0.0"
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
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-spatial.txt \
    https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-postgis.txt && \
  curl -o /wheels/ckanext-spatial-postgis.txt \
    https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-postgis.txt && \
    ls -lah /wheels

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/ckan/ckanext-spatial.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

###############################################################################
# Runtime stage
###############################################################################
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION_RUNTIME_STAGE} as runtime

ENV CKAN__PLUGINS "image_view text_view recline_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query scheming_datasets envvars"

# Extra env for compatibility with ckan/base Docker images for downstream k8s
ENV CKAN_INI=${APP_DIR}/production.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan
ENV TZ="UTC"

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels
COPY --from=extbuild-spatial /wheels ${APP_DIR}/ext_wheels
COPY --chown=ckan:ckan /docker-entrypoint.d /docker-entrypoint.d

USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libxml2-dev libxslt1-dev libgeos-c1v5 && \
    pip install --no-cache-dir -U pip && \
    rm -rf /var/lib/apt/lists/*

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-hierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-hierarchy

# ckanext-grouphierarchy ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-grouphierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-grouphierarchy

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-relation.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-spatial #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial.txt && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial-postgis.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-spatial

# ckanext-scheming #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${APP_DIR}/production.ini" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
  ckan config-tool "${APP_DIR}/production.ini" "scheming.presets = ckanext.scheming:presets.json" && \
  ckan config-tool "${APP_DIR}/production.ini" "scheming.dataset_fallback = false" && \
  echo "${TZ}" >  /etc/timezone && \
  chown -R ckan:ckan ${APP_DIR} && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
