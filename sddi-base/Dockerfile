###############################################################################
# Build stage
###############################################################################
ARG CKAN_VERSION_BUILD_STAGE=2.11.0
ARG CKAN_VERSION_BUILD_SPATIAL=2.11.0
ARG CKAN_VERSION_RUNTIME_STAGE=2.11.0

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

# Install curl
RUN apt-get update && apt-get install -y --no-install-recommends curl

# ckanext-hierarchy ###########################################################
ARG CKANEXT_HIERARCHY_VERSION="abb4e2d"
ENV CKANEXT_HIERARCHY_VERSION=${CKANEXT_HIERARCHY_VERSION}

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git@${CKANEXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
  curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-envvars
ENV ENVVARS_GIT_URL=https://github.com/ckan/ckanext-envvars/
ENV ENVVARS_GIT_BRANCH=v0.0.6

RUN set -ex && \
  pip3 wheel --wheel-dir=/wheels git+${ENVVARS_GIT_URL}@${ENVVARS_GIT_BRANCH}#egg=ckanext-envvars

# ckanext-relation ############################################################
ARG CKANEXT_RELATION_VERSION="1.1.0"
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
ARG CKANEXT_SCHEMING_VERSION="27035f4"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com/ckan/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming
  
# ckanext datesearch ##########################################################
ARG CKANEXT_DATESEARCH_VERSION="1.1.0"
ENV CKANEXT_DATESEARCH_VERSION=${CKANEXT_DATESEARCH_VERSION}
ENV CKANEXT_DATESEARCH_VERSION_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-datesearch"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DATESEARCH_VERSION_GITHUB_URL}.git@${CKANEXT_DATESEARCH_VERSION}#egg=ckanext-datesearch

# ckanext-harvest ###########################################################
ARG CKANEXT_HARVEST_VERSION="v1.6.0"
ENV CKANEXT_HARVEST_VERSION=${CKANEXT_HARVEST_VERSION}
ENV CKANEXT_HARVEST_GITHUB_URL="https://github.com/ckan/ckanext-harvest.git"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-harvest.git@${CKANEXT_HARVEST_VERSION}#egg=ckanext-harvest && \
  curl -o /wheels/ckanext-harvest.txt https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-geoview #############################################################
ARG CKANEXT_GEOVIEW_VERSION="v0.2.2"
ENV CKANEXT_GEOVIEW_VERSION=${CKANEXT_GEOVIEW_VERSION}
ENV CKANEXT_GEOVIEW_GITHUB_URL="https://github.com/ckan/ckanext-geoview"

RUN set -ex && \
    curl -o /wheels/ckanext-geoview-dev-requirements.txt \
        ${CKANEXT_GEOVIEW_GITHUB_URL}/raw/${CKANEXT_GEOVIEW_VERSION}/dev-requirements.txt && \
    pip install -r /wheels/ckanext-geoview-dev-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_GEOVIEW_GITHUB_URL}.git@${CKANEXT_GEOVIEW_VERSION}#egg=ckanext-geoview

# ckanext-scheme-sddi ##########################################################
ARG CKANEXT_SCHEME_SDDI_VERSION="1.1.0"
ENV CKANEXT_SCHEME_SDDI_VERSION=${CKANEXT_SCHEME_SDDI_VERSION}

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheme-sddi/main/dev-requirements.txt

    RUN set -ex && \
    pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheme-sddi/main/requirements.txt && \
    pip wheel --wheel-dir=/wheels git+https://github.com/MarijaKnezevic/ckanext-scheme-sddi.git@main#egg=ckanext-scheme-sddi && \
    curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheme-sddi/main/requirements.txt && \
    ls -lah /wheels

# ckanext-theme-sddi ##########################################################
ARG CKANEXT_THEME_SDDI_VERSION="1.1.0"
ENV CKANEXT_THEME_SDDI_VERSION=${CKANEXT_THEME_SDDI_VERSION}

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-theme-sddi/main/dev-requirements.txt

    RUN set -ex && \
    pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-theme-sddi/main/requirements.txt && \
    pip wheel --wheel-dir=/wheels git+https://github.com/MarijaKnezevic/ckanext-theme-sddi.git@main#egg=ckanext-theme-sddi && \
    curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/MarijaKnezevic/ckanext-theme-sddi/main/requirements.txt && \
    ls -lah /wheels

# ckanext-clamav #############################################################
ARG CKANEXT_CLAMAV_VERSION="a1d23ac"
ENV CKANEXT_CLAMAV_VERSION=${CKANEXT_CLAMAV_VERSION}
ENV CKANEXT_CLAMAV_GITHUB_URL="https://github.com/DataShades/ckanext-clamav"

RUN set -ex && \
    curl -o /wheels/ckanext-clamav-requirements.txt \
        ${CKANEXT_CLAMAV_GITHUB_URL}/raw/${CKANEXT_CLAMAV_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-clamav-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_CLAMAV_GITHUB_URL}.git@${CKANEXT_CLAMAV_VERSION}#egg=ckanext-clamav

# ckanext-dcat ##########################################################
ARG CKANEXT_DCAT_VERSION="v1.5.1"
ENV CKANEXT_DCAT_VERSION=${CKANEXT_DCAT_VERSION}
ENV CKANEXT_DCAT_GITHUB_URL="https://github.com/ckan/ckanext-dcat"

RUN set -ex && \
    curl -o /wheels/ckanext-dcat-requirements.txt \
        https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-dcat-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_DCAT_GITHUB_URL}.git@${CKANEXT_DCAT_VERSION}#egg=ckanext-dcat

# ckanext-security ######################################################
ARG CKANEXT_SECURITY_VERSION="80dc1d6"
ENV CKANEXT_SECURITY_VERSION=${CKANEXT_SECURITY_VERSION}
ENV CKANEXT_SECURITY_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-security"
    
RUN set -ex && \
    curl -o /wheels/ckanext-security-requirements.txt \
        https://raw.githubusercontent.com/MarijaKnezevic/ckanext-security/${CKANEXT_SECURITY_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-security-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_SECURITY_GITHUB_URL}.git@${CKANEXT_SECURITY_VERSION}#egg=ckanext-security

# ckanext-spatial #############################################################
FROM ckan/ckan-base:${CKAN_VERSION_BUILD_SPATIAL} as extbuild-spatial

ARG CKANEXT_SPATIAL_VERSION="8a00a2b"
ENV CKANEXT_SPATIAL_VERSION=${CKANEXT_SPATIAL_VERSION}

USER root

RUN set -ex && \
 apt-get update && \
 apt-get install -y --no-install-recommends \
  curl python3-dev python3-pip libxml2-dev libxslt1-dev libgeos-c1v5 python-is-python3 && \
  mkdir -p /wheels && \
  pip install -U pip

RUN set -ex && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-spatial.txt https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-spatial.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

###############################################################################
# Runtime stage
###############################################################################
FROM ckan/ckan-base:${CKAN_VERSION_RUNTIME_STAGE} as runtime

ENV CKAN__PLUGINS "envvars image_view text_view webpage_view datastore \
  harvest ckan_harvester \
  hierarchy_display hierarchy_form \
  relation \
  spatial_metadata spatial_query \
  datesearch \
  scheme_sddi \
  theme_sddi \
  fortify \
  scheming_datasets \
  geo_view geojson_view wmts_view shp_view \
  security \
  heroslideradmin \
  dcat dcat_rdf_harvester dcat_json_harvester dcat_json_interface \
  clamav"

# Extra env for compatibility with ckan/base Docker images for downstream k8s
ENV CKAN_INI=${APP_DIR}/ckan.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan
ENV TZ="UTC"

USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    clamav \
    clamav-daemon \
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

  # ckanext-harvest ###########################################################
RUN set -ex && \
pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-harvest && \
pip install --no-index --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-harvest.txt

# ckanext-envvars ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-envvars

# ckanext-relation ############################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-relation.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-spatial #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-spatial.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-spatial

# ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-geoview #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-geoview

# ckanext-scheme-sddi ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheme-sddi

# ckanext-clamav #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-clamav

# ckanext-fortify ##############################
RUN set -ex && \
pip install -e "git+https://github.com/salsadigitalauorg/ckanext-fortify#egg=ckanext-fortify"

# ckanext-heroslideradmin #############################################################
RUN set -ex && \
  pip install -e "git+https://github.com/dathere/ckanext-heroslideradmin.git@4b60e00#egg=ckanext-heroslideradmin"

# ckanext-dcat ##########################################################
RUN set -ex && \
pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-dcat-requirements.txt && \
pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-dcat

# ckanext-security ######################################################
RUN set -ex && \
pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-security-requirements.txt && \
pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-security

# ckanext-theme-sddi ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-theme-sddi

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.use_postgis_sorting = true" && \
 # ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheme_sddi:sddi_dataset.yaml" && \
 # ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.scheme_sddi:sddi_presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dathere_theme.column_count = 4" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.type = custom" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.custom.url = https://tile.openstreetmap.de/{z}/{x}/{y}.png" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.attribution = <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors." && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.lock_timeout = 900" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.login_max_count = 3" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.brute_force_key = user_name" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.disable_password_reset_override = true" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.enable_totp = false" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.enable_password_policy = True" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.password_policy.min_length = 12" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.check_parent_org_allowed = True" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dcat.enable_content_negotiation = True" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_scope = 0" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_level = debug" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_timeframe = 10" && \
  ckan config-tool "${CKAN_INI}" "PERMANENT_SESSION_LIFETIME = 600" && \
  echo "${TZ}" > /etc/timezone && \
  mkdir -p ${CKAN_STORAGE_PATH} && \
  chown -R ckan:ckan ${APP_DIR} ${CKAN_STORAGE_PATH} && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
