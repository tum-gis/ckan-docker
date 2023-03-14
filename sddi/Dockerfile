# #############################################################################
# # Build stage
# #############################################################################

ARG BASEIMAGE_VERSION=latest
ARG CKAN_VERSION_BUILD_STAGE=2.9.7-dev

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

# ckanext-dcat ################################################################
ARG CKANEXT_DCAT_VERSION="v1.4.0"
ENV CKANEXT_DCAT_VERSION=${CKANEXT_DCAT_VERSION}
ENV CKANEXT_DCAT_GITHUB_URL="https://github.com/ckan/ckanext-dcat"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r \
    https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/dev-requirements.txt && \
  curl -o /wheels/ckanext-dcat.txt \
    https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DCAT_GITHUB_URL}.git@${CKANEXT_DCAT_VERSION}#egg=ckanext-dcat

# #############################################################################
# # Runtime stage
# #############################################################################
FROM ghcr.io/tum-gis/ckan-sddi-base:${BASEIMAGE_VERSION} as runtime

USER root

ENV CKAN__PLUGINS "image_view text_view recline_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query datesearch repeating composite \
  resource_proxy geo_view geojson_view wmts_view shp_view \
  dcat dcat_json_interface structured_data \
  restricted scheming_datasets envvars"

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# ckanext-dcat ################################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-dcat.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-dcat


USER ckan
