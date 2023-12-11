# Do Build
# #############################################################################
# # Build stage
# #############################################################################
ARG BASEIMAGE_REPOSITORY=ghcr.io/tum-gis/ckan-sddi-base
ARG BASEIMAGE_VERSION=latest
ARG CKAN_VERSION_BUILD_STAGE=2.9.9-dev

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

# ckanext-geoview #############################################################
ARG CKANEXT_GEOVIEW_VERSION="v0.0.20"
ENV CKANEXT_GEOVIEW_VERSION=${CKANEXT_GEOVIEW_VERSION}
ENV CKANEXT_GEOVIEW_GITHUB_URL="https://github.com/ckan/ckanext-geoview"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-geoview/${CKANEXT_GEOVIEW_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_GEOVIEW_GITHUB_URL}.git@${CKANEXT_GEOVIEW_VERSION}#egg=ckanext-geoview

# ckanext-dcat ################################################################
ARG CKANEXT_DCAT_VERSION="v1.4.0"
ENV CKANEXT_DCAT_VERSION=${CKANEXT_DCAT_VERSION}
ENV CKANEXT_DCAT_GITHUB_URL="https://github.com/ckan/ckanext-dcat"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/dev-requirements.txt && \
  curl -o /wheels/ckanext-dcat.txt \
    https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DCAT_GITHUB_URL}.git@${CKANEXT_DCAT_VERSION}#egg=ckanext-dcat

# ckanext-restricted ##########################################################
ARG CKANEXT_RESTRICTED_VERSION="1.0.0"
ENV CKANEXT_RESTRICTED_VERSION=${CKANEXT_RESTRICTED_VERSION}
ENV CKANEXT_RESTRICTED_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-restricted"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/MarijaKnezevic/ckanext-restricted/${CKANEXT_RESTRICTED_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_RESTRICTED_GITHUB_URL}.git@${CKANEXT_RESTRICTED_VERSION}#egg=ckanext-restricted

# ckanext-resourcedictionary ##########################################################
ARG CKANEXT_RESOURCEDICTIONARY_VERSION="v1.0.0"
ENV CKANEXT_RESOURCEDICTIONARY_VERSION=${CKANEXT_RESOURCEDICTIONARY_VERSION}
ENV CKANEXT_RESOURCEDICTIONARY_GITHUB_URL="https://github.com/keitaroinc/ckanext-resourcedictionary"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/keitaroinc/ckanext-resourcedictionary/${CKANEXT_RESOURCEDICTIONARY_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-resourcedictionary.txt \
    https://raw.githubusercontent.com/keitaroinc/ckanext-resourcedictionary/${CKANEXT_RESOURCEDICTIONARY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_RESOURCEDICTIONARY_GITHUB_URL}.git@${CKANEXT_RESOURCEDICTIONARY_VERSION}#egg=ckanext-resourcedictionary

# ckanext-xloader ##########################################################
ARG CKANEXT_XLOADER_VERSION="1.0.1"
ENV CKANEXT_XLOADER_VERSION=${CKANEXT_XLOADER_VERSION}
ENV CKANEXT_XLOADER_GITHUB_URL="https://github.com/ckan/ckanext-xloader"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-xloader/${CKANEXT_XLOADER_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-xloader.txt \
    https://raw.githubusercontent.com/ckan/ckanext-xloader/${CKANEXT_XLOADER_VERSION}/requirements.txt && \
  pip install -U requests[security] && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_XLOADER_GITHUB_URL}.git@${CKANEXT_XLOADER_VERSION}#egg=ckanext-xloader

# ckanext-lhm ##########################################################
ARG CKANEXT_LHM_VERSION="1d4ddd8"
ENV CKANEXT_LHM_VERSION=${CKANEXT_LHM_VERSION}
ENV CKANEXT_LHM_GITHUB_URL="https://github.com/MandanaMoshref/ckanext-lhm"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/MandanaMoshref/ckanext-lhm/${CKANEXT_LHM_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-lhm.txt \
    https://raw.githubusercontent.com/MandanaMoshref/ckanext-lhm/${CKANEXT_LHM_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_LHM_GITHUB_URL}.git@${CKANEXT_LHM_VERSION}#egg=ckanext-lhm

# ckanext-harvest ##########################################################
ARG CKANEXT_HARVEST_VERSION="v1.5.6"
ENV CKANEXT_HARVEST_VERSION=${CKANEXT_HARVEST_VERSION}
ENV CKANEXT_HARVEST_GITHUB_URL="https://github.com/ckan/ckanext-harvest"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-harvest.txt \
    https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/dev-requirements.txt && \
  curl -o /wheels/ckanext-harvest-dev.txt \
    https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_HARVEST_GITHUB_URL}.git@${CKANEXT_HARVEST_VERSION}#egg=ckanext-harvest

# ckanext-scheming ##########################################################
ARG CKANEXT_SCHEMING_VERSION="master"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com/gislab-augsburg/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext-qgov ##########################################################
ARG CKANEXT_QGOV_VERSION="6.0.2"
ENV CKANEXT_QGOV_VERSION=${CKANEXT_QGOV_VERSION}
ENV CKANEXT_QGOV_GITHUB_URL="https://github.com/qld-gov-au/ckanext-qgov"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/qld-gov-au/ckanext-qgov/${CKANEXT_QGOV_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-qgov.txt \
    https://raw.githubusercontent.com/qld-gov-au/ckanext-qgov/${CKANEXT_QGOV_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_QGOV_GITHUB_URL}.git@${CKANEXT_QGOV_VERSION}#egg=ckanext-qgov


# #############################################################################
# # Runtime stage
# #############################################################################
FROM ${BASEIMAGE_REPOSITORY}:${BASEIMAGE_VERSION} as runtime

USER root

ENV CKAN__PLUGINS "image_view text_view recline_view webpage_view \
    scheming_datasets scheming_groups scheming_organizations \
    spatial_metadata spatial_query spatial_harvest_metadata_api \
    composite hierarchy_display hierarchy_form lhm lhm_theme \
    resourcedictionary datastore xloader hierarchy_group_form \
    password_policy resource_proxy geo_view geojson_view wmts_view shp_view \
    harvest ckan_harvester csw_harvester waf_harvester doc_harvester \
    qgovext envvars"

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# ckanext-geoview #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-geoview

# ckanext-dcat ################################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-dcat.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-dcat

# ckanext-restricted ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-restricted

# ckanext-resourcedictionary ##################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-resourcedictionary.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-resourcedictionary

# ckanext-xloader #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-xloader.txt && \
  pip install -U requests[security] && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-xloader
  
# ckanext-lhm #################################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-lhm.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-lhm

# ckanext-harvest #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-harvest.txt && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-harvest-dev.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-harvest

# ckanext-scheming #############################################################
# uninstall previous version from sddi-base
RUN yes | pip uninstall ckanext-scheming
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-qgov #############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-qgov.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-qgov


RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.ol_viewer.formats = wms kml" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.encoding = UTF-8" && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
