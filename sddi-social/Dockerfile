# #############################################################################
# # Build stage
# #############################################################################
ARG BASEIMAGE_REPOSITORY=ghcr.io/tum-gis/ckan-sddi
ARG BASEIMAGE_VERSION=latest
ARG CKAN_VERSION_BUILD_STAGE=2.9.9-dev

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

# ckanext-disqus ##############################################################
ARG CKANEXT_DISQUS_VERSION="d3fcdb7"
ENV CKANEXT_DISQUS_VERSION=${CKANEXT_DISQUS_VERSION}
ENV CKANEXT_DISQUS_GITHUB_URL="https://github.com/ckan/ckanext-disqus"

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DISQUS_GITHUB_URL}.git@${CKANEXT_DISQUS_VERSION}#egg=disqus

# ###############################################################################
# # Runtime stage
# ###############################################################################
FROM ${BASEIMAGE_REPOSITORY}:${BASEIMAGE_VERSION} as runtime

USER root

ENV CKAN__PLUGINS "image_view text_view recline_view webpage_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query datesearch repeating composite scheming_datasets \
  password_policy resource_proxy geo_view geojson_view wmts_view shp_view \
  dcat dcat_json_interface structured_data \
  restricted clamav \
  disqus \
  envvars"

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# ckanext-dcat ################################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels disqus

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
