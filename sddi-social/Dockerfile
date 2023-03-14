# #############################################################################
# # Build stage
# #############################################################################
ARG BASEIMAGE_REPOSITORY=ghcr.io/tum-gis/ckan-sddi
ARG BASEIMAGE_VERSION=latest
ARG CKAN_VERSION_BUILD_STAGE=2.9.7-dev

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

ENV CKAN__PLUGINS "image_view text_view recline_view datastore datapusher \
  hierarchy_display hierarchy_form display_group relation \
  spatial_metadata spatial_query datesearch repeating composite scheming_datasets \
  resource_proxy geo_view geojson_view wmts_view shp_view \
  dcat dcat_json_interface structured_data \
  restricted \
  disqus \
  envvars"

# Copy python wheels from build stage
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# ckanext-dcat ################################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels disqus

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.repeating:presets.json ckanext.composite:presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.ol_viewer.formats = wms kml" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.geoview.shp_viewer.encoding = UTF-8" && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

USER ckan
