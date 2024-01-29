###############################################################################
# Build stage
###############################################################################
ARG CKAN_VERSION_BUILD_STAGE=2.10.1-dev
ARG CKAN_VERSION_BUILD_SPATIAL=2.9.9-focal
ARG CKAN_VERSION_RUNTIME_STAGE=2.10.1-focal

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

RUN apk add --no-cache \
    # python3 \
    # python3-dev \
    git \
    curl \
    postgresql-dev \
    linux-headers \
    gcc \
    make \
    g++ \
    zlib-dev \
    autoconf \
    automake \
    libtool \
    patch \
    musl-dev \
    pcre-dev \
    pcre \
    geos \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    openssl-dev \
    rust \
    cargo

ARG PYTHON_VERSION=3.9.9

# download and extract python sources
RUN cd /opt \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \                                              
    && tar xzf Python-${PYTHON_VERSION}.tgz

# build python and remove left-over sources
RUN cd /opt/Python-${PYTHON_VERSION} \ 
    && ./configure --prefix=/usr --enable-optimizations --with-ensurepip=install \
    && make install \
    && rm /opt/Python-${PYTHON_VERSION}.tgz /opt/Python-${PYTHON_VERSION} -rf

RUN set -ex && \
    pip install --no-cache-dir -U pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip install markupsafe==2.0.1 && \
    pip install wheel

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
ARG CKANEXT_SDDI_VERSION="1.1.3"
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
ARG CKANEXT_RELATION_VERSION="1.0.3"
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
ARG CKANEXT_SCHEMING_VERSION="f98daec"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext datesearch ##########################################################
ARG CKANEXT_DATESEARCH_VERSION="1.0.2"
ENV CKANEXT_DATESEARCH_VERSION=${CKANEXT_DATESEARCH_VERSION}
ENV CKANEXT_DATESEARCH_VERSION_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-datesearch"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DATESEARCH_VERSION_GITHUB_URL}.git@${CKANEXT_DATESEARCH_VERSION}#egg=ckanext-datesearch

# ckanext-composite ###########################################################
ARG CKANEXT_COMPOSITE_VERSION="1e6d7bb"
ENV CKANEXT_COMPOSITE_VERSION=${CKANEXT_COMPOSITE_VERSION}
ENV CKANEXT_COMPOSITE_GITHUB_URL="https://github.com/EnviDat/ckanext-composite"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/EnviDat/ckanext-composite/${CKANEXT_COMPOSITE_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_COMPOSITE_GITHUB_URL}.git@${CKANEXT_COMPOSITE_VERSION}#egg=ckanext-composite

# ckanext-repeating ###########################################################
ARG CKANEXT_REPEATING_VERSION="1.0.0"
ENV CKANEXT_REPEATING_VERSION=${CKANEXT_REPEATING_VERSION}
ENV CKANEXT_REPEATING_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-repeating"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_REPEATING_GITHUB_URL}.git@${CKANEXT_REPEATING_VERSION}#egg=ckanext-repeating

# ckanext-password-policy #####################################################
ARG CKANEXT_PASSWORD_POLICY_VERSION="5618dc9"
ENV CKANEXT_PASSWORD_POLICY_VERSION=${CKANEXT_PASSWORD_POLICY_VERSION}
ENV CKANEXT_PASSWORD_POLICY_GITHUB_URL="https://github.com/keitaroinc/ckanext-password-policy"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/keitaroinc/ckanext-password-policy/${CKANEXT_PASSWORD_POLICY_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-password-policy.txt \
    https://raw.githubusercontent.com/keitaroinc/ckanext-password-policy/${CKANEXT_PASSWORD_POLICY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_PASSWORD_POLICY_GITHUB_URL}.git@${CKANEXT_PASSWORD_POLICY_VERSION}#egg=ckanext-password-policy

# ckanext-harvest ###########################################################

ARG CKANEXT_HARVEST_VERSION="v1.5.6"
ENV CKANEXT_HARVEST_VERSION=${CKANEXT_HARVEST_VERSION}
ENV CKANEXT_HARVEST_GITHUB_URL="https://github.com/ckan/ckanext-harvest.git"

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-harvest.git@${CKANEXT_HARVEST_VERSION}#egg=ckanext-harvest && \
  curl -o /wheels/ckanext-harvest.txt https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  ls -lah /wheels

# # ckanext-spatial #############################################################
ENV CKANEXT_SPATIAL_GITHUB_URL="https://github.com/ckan/ckanext-spatial"
ENV CKANEXT_SPATIAL_VERSION="v2.1.1"

RUN set -ex && \
  # pip wheel --wheel-dir=/wheels -r \
  #   https://raw.githubusercontent.com/ckan/ckanext-spatial/v2.1.1/requirements.txt && \
  curl -o /wheels/ckanext-spatial-requirements.txt \
    https://raw.githubusercontent.com/ckan/ckanext-spatial/v2.1.1/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SPATIAL_GITHUB_URL}.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

###############################################################################
# Runtime stage
###############################################################################
FROM ckan/ckan-base:2.10 as runtime

# Extra env for compatibility with ckan/base Docker images for downstream k8s
ENV CKAN_INI=${APP_DIR}/production.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan
ENV TZ="UTC"

USER root

RUN apk add --no-cache \
    python3 \
    python3-dev \
    git \
    curl \
    postgresql-dev \
    linux-headers \
    gcc \
    make \
    g++ \
    zlib-dev \
    autoconf \
    automake \
    libtool \
    patch \
    musl-dev \
    pcre-dev \
    pcre \
    geos \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    openssl-dev \
    rust \
    cargo \
    proj-data

ENV CKAN__PLUGINS "image_view text_view recline_view webpage_view datastore \
  harvest ckan_harvester \
  hierarchy_display hierarchy_form \
  # datapusher Token required \
  display_group \
  # relation  ImportError: cannot import name 'Mapping' from 'collections' \
  spatial_metadata spatial_query \
  scheming_datasets \
  datesearch \
  composite \
  repeating \
  # password_policy No module named 'ckan.lib.repoze_plugins' \
  envvars"

RUN pip install markupsafe==2.0.1

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# ckanext-harvest ###########################################################
RUN pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-harvest && \
    pip install --no-index --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-harvest.txt

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-hierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-hierarchy

# ckanext-grouphierarchy ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-grouphierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-grouphierarchy

# ckanext-relation ############################################################
# RUN set -ex && \
#   pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-relation.txt && \
#   pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-spatial #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial-requirements.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-spatial

# # ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# # ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-composite ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-composite

# ckanext-repeating ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-repeating

# ckanext-password-policy #####################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-password-policy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-password-policy

# Copy init scripts and additional files
COPY --chown=ckan:ckan initScripts/ ${APP_DIR}/docker-afterinit.d
COPY --chown=ckan:ckan who.ini ${APP_DIR}/who.ini

RUN set -ex && \
  ckan generate config ${APP_DIR}/production.ini

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  # ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.repeating:presets.json ckanext.composite:presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "licenses_group_url = https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/main/ckanext/grouphierarchy/licenses_SDDI.json" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.password_policy.password_length = 12" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.password_policy.failed_logins = 3" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.password_policy.user_locked_time = 600" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.type = custom" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.custom.url = https://tile.openstreetmap.de/{z}/{x}/{y}.png" && \
  # ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.attribution = <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors." && \
  echo "${TZ}" > /etc/timezone && \
  mkdir -p ${CKAN_STORAGE_PATH} && \
  chown -R ckan:ckan ${APP_DIR} ${CKAN_STORAGE_PATH} && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
