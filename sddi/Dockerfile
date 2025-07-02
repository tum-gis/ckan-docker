###############################################################################
# Extbuild stage
###############################################################################
ARG BASEIMAGE_REPOSITORY=ghcr.io/tum-gis/ckan-sddi-base
ARG BASEIMAGE_VERSION=latest
ARG CKAN_VERSION=2.11.2

FROM ckan/ckan-base:${CKAN_VERSION} AS extbuild

USER root

RUN apt-get update && apt-get install -y \
    curl \
    libpq-dev \
    autoconf \
    automake \
    libtool \
    patch \
    musl-dev \
    libpcre3-dev \
    libpcre3 \
    libffi-dev \
    libxml2-dev \
    libxslt-dev

RUN pip install -U markupsafe==2.0.1 sqlalchemy==1.4.41

# ckanext-relation ############################################################
ARG CKANEXT_RELATION_VERSION="1.1.2"
ENV CKANEXT_RELATION_VERSION=${CKANEXT_RELATION_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-relation-sddi.git@${CKANEXT_RELATION_VERSION}#egg=ckanext-relation && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-relation.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext datesearch ##########################################################
ARG CKANEXT_DATESEARCH_VERSION="1.1.1"
ENV CKANEXT_DATESEARCH_VERSION=${CKANEXT_DATESEARCH_VERSION}
ENV CKANEXT_DATESEARCH_VERSION_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-datesearch"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DATESEARCH_VERSION_GITHUB_URL}.git@${CKANEXT_DATESEARCH_VERSION}#egg=ckanext-datesearch

# ckanext-spatial #############################################################
ENV CKANEXT_SPATIAL_GITHUB_URL="https://github.com/ckan/ckanext-spatial"
ENV CKANEXT_SPATIAL_VERSION="v2.3.0"

RUN set -ex && \
  curl -o /wheels/ckanext-spatial-requirements.txt \
    https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-py2.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SPATIAL_GITHUB_URL}.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

# ckanext-theme-sddi #############################################################
ARG CKANEXT_THEME_SDDI_VERSION="0.0.4"
ENV CKANEXT_THEME_SDDI_VERSION=${CKANEXT_THEME_SDDI_VERSION}
ENV CKANEXT_THEME_SDDI_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-theme-sddi"

RUN set -ex && \
    curl -o /wheels/ckanext-theme-sddi-dev-requirements.txt \
        ${CKANEXT_THEME_SDDI_GITHUB_URL}/raw/${CKANEXT_THEME_SDDI_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-theme-sddi-dev-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_THEME_SDDI_GITHUB_URL}.git@${CKANEXT_THEME_SDDI_VERSION}#egg=ckanext-theme-sddi

# ckanext-security ######################################################
ARG CKANEXT_SECURITY_VERSION="0.0.1"
ENV CKANEXT_SECURITY_VERSION=${CKANEXT_SECURITY_VERSION}
ENV CKANEXT_SECURITY_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-security"

RUN set -ex && \
    curl -o /wheels/ckanext-security-requirements.txt \
        https://raw.githubusercontent.com/MarijaKnezevic/ckanext-security/${CKANEXT_SECURITY_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-security-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_SECURITY_GITHUB_URL}.git@${CKANEXT_SECURITY_VERSION}#egg=ckanext-security

###############################################################################
# Runtime stage
###############################################################################
FROM ${BASEIMAGE_REPOSITORY}:${BASEIMAGE_VERSION} AS runtime

ENV CKAN_DIR=${SRC_DIR}/ckan
ENV DATA_DIR=/srv/app/data
ENV UWSGI_HARAKIRI=50

USER root

# Setting the locale
ENV LC_ALL="en_US.UTF-8"
RUN update-locale LANG=${LC_ALL}

# Cleanup to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get artifacts from build stages
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

RUN chown -R ckan:ckan-sys ${APP_DIR}

USER ckan

WORKDIR ${CKAN_DIR}

# ckanext-relation ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-spatial #############################################################
RUN set -ex && \
  pip install -e 'git+https://github.com/ckan/ckanext-spatial.git#egg=ckanext-spatial' && \
  pip install -r 'https://raw.githubusercontent.com/ckan/ckanext-spatial/master/requirements.txt'

# ckanext-scheme-sddi ############################################################
RUN set -ex && \
  pip install -e "git+https://github.com/MarijaKnezevic/ckanext-scheme-sddi@0.0.2#egg=ckanext-scheme-sddi"

# ckanext-theme-sddi #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-theme-sddi

# ckanext-heroslideradmin #############################################################
RUN set -ex && \
  pip install -e "git+https://github.com/dathere/ckanext-heroslideradmin.git@4b60e00#egg=ckanext-heroslideradmin"

# ckanext-security ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-security-requirements.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-security

ENV CKAN__PLUGINS "envvars image_view text_view webpage_view datastore \
  tracking \
  activity \
  security \
  hierarchy_display hierarchy_form \
  relation \
  spatial_metadata spatial_query \
  datesearch \
  scheme_sddi \
  theme_sddi \
  scheming_datasets \
  geo_view geojson_view wmts_view shp_view \
  heroslideradmin \
  dcat dcat_json_interface \
  clamav"

RUN set -ex && \
  ckan generate config ${CKAN_INI}

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.use_postgis_sorting = true" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheme_sddi:sddi_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.scheme_sddi:sddi_presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dathere_theme.column_count = 4" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.type = custom" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.custom.url = https://tile.openstreetmap.de/{z}/{x}/{y}.png" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.attribution = <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors." && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.lock_timeout = 900" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.login_max_count = 3" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.brute_force_key = user_name" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.disable_password_reset_override = true" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.enable_totp = true" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dcat.enable_content_negotiation = true" && \
  ckan config-tool "${CKAN_INI}" "PERMANENT_SESSION_LIFETIME = 600"

# Remove wheels
RUN set -ex && \
  rm -rf ${APP_DIR}/ext_wheels

WORKDIR ${APP_DIR}

# Create entrypoint directory for children image scripts
ONBUILD RUN mkdir -p /docker-entrypoint.d

EXPOSE 5000
HEALTHCHECK --interval=60s --timeout=5s --retries=5 CMD curl --fail http://localhost:5000/api/3/action/status_show || exit CMD ["/srv/app/start_ckan.sh"]

CMD ["/srv/app/start_ckan.sh"]
