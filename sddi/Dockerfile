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

# ckanext-clamav ##############################################################
ARG CKANEXT_CALMAV_VERSION="master"
ENV CKANEXT_CALMAV_VERSION=${CKANEXT_CALMAV_VERSION}
ENV CKANEXT_CALMAV_GITHUB_URL="https://github.com/mutantsan/ckanext-clamav"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/mutantsan/ckanext-clamav/${CKANEXT_CALMAV_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-clamav.txt \
    https://raw.githubusercontent.com/mutantsan/ckanext-clamav/${CKANEXT_CALMAV_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_CALMAV_GITHUB_URL}.git@${CKANEXT_CALMAV_VERSION}#egg=ckanext-clamav
    
# #############################################################################
# # Runtime stage
# #############################################################################
FROM ${BASEIMAGE_REPOSITORY}:${BASEIMAGE_VERSION} as runtime

USER root

ENV CKAN__PLUGINS "image_view text_view recline_view webpage_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query datesearch repeating composite scheming_datasets \
  password_policy resource_proxy geo_view geojson_view wmts_view shp_view \
  dcat dcat_json_interface structured_data \
  restricted clamav \
  envvars"

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

# ckanext-clamav ##############################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-clamav.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-clamav
  
RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.ol_viewer.formats = wms kml" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.encoding = UTF-8" && \
  ckan config-tool "${CKAN_INI}" "who.timeout = 1800" && \
  ckan config-tool "${CKAN_INI}" "ckan.auth.public_user_details = False" && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
