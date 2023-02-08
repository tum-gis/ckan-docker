# ###############################################################################
# # Build stage
# ###############################################################################
# ARG CKAN_VERSION=2.9.7
# ARG BASEIMAGE_VERSION=latest
# FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as extbuild

# ARG CKAN_EXT_HIERARCHY_VERSION=master
# ENV CKAN_EXT_HIERARCHY_VERSION=${CKAN_EXT_HIERARCHY_VERSION}

# ARG CKAN_EXT_REPEATING_VERSION=master
# ENV CKAN_EXT_REPEATING_VERSION=${CKAN_EXT_REPEATING_VERSION}

# ARG CKAN_EXT_COMPOSITE_VERSION=master
# ENV CKAN_EXT_COMPOSITE_VERSION=${CKAN_EXT_COMPOSITE_VERSION}

# ARG CKAN_EXT_RESTRICTED_VERSION=master
# ENV CKAN_EXT_RESTRICTED_VERSION=${CKAN_EXT_RESTRICTED_VERSION}

# ARG CKAN_EXT_SCHEMING_VERSION=0.3-(without_composite_und_repeating)
# ENV CKAN_EXT_SCHEMING_VERSION=${CKAN_EXT_SCHEMING_VERSION}

# ARG CKAN_EXT_GEOVIEW_VERSION=master
# ENV CKAN_EXT_GEOVIEW_VERSION=${CKAN_EXT_GEOVIEW_VERSION}

# # Switch to the root user
# USER root

# # Install any system packages necessary to build extensions
# ############################## hierarchy ##############################
# RUN set -ex && \
#   apk add --no-cache --virtual .build-deps \
#     python3-dev && \
#     pip install --upgrade pip \
#     pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/dev-requirements.txt

# RUN set -ex && \
#   mkdir -p /wheels && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/davidread/ckanext-hierarchy.git@${CKAN_EXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
#   pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
#   curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
#   ls -lah /wheels  && \

# ############################## repeating ##############################
#   pip wheel --wheel-dir=/wheels git+https://github.com/MarijaKnezevic/ckanext-repeating.git@${CKAN_EXT_REPEATING_VERSION}#egg=ckanext-repeating

# ############################## composite ##############################
# RUN pip install -r https://raw.githubusercontent.com/EnviDat/ckanext-composite/${CKAN_EXT_COMPOSITE_VERSION}/dev-requirements.txt

# RUN set -ex && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/EnviDat/ckanext-composite.git@${CKAN_EXT_COMPOSITE_VERSION}#egg=ckanext-composite

# ############################## restricted ##############################
# RUN pip install -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-restricted/${CKAN_EXT_RESTRICTED_VERSION}/dev-requirements.txt

# RUN set -ex && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/MarijaKnezevic/ckanext-restricted.git@${CKAN_EXT_RESTRICTED_VERSION}#egg=ckanext-restricted

# ############################## scheming ##############################
# RUN pip wheel --wheel-dir=/wheels git+https://github.com/MarijaKnezevic/ckanext-scheming.git@${CKAN_EXT_SCHEMING_VERSION}#egg=ckanext-scheming
# RUN pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheming/${CKAN_EXT_SCHEMING_VERSION}/test-requirements.txt
# RUN curl -o /wheels/ckanext-scheming.txt https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheming/${CKAN_EXT_SCHEMING_VERSION}/test-requirements.txt
# RUN pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheming/${CKAN_EXT_SCHEMING_VERSION}/test-requirements-py2.txt
# RUN curl -o /wheels/ckanext-scheming.txt https://raw.githubusercontent.com/MarijaKnezevic/ckanext-scheming/${CKAN_EXT_SCHEMING_VERSION}/test-requirements-py2.txt

# ############################## geoview ##############################
# RUN pip install -r https://raw.githubusercontent.com/ckan/ckanext-geoview/${CKAN_EXT_GEOVIEW_VERSION}/dev-requirements.txt

# RUN pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-geoview.git@${CKAN_EXT_GEOVIEW_VERSION}#egg=ckanext-geoview


# ###############################################################################
# # Runtime stage
# ###############################################################################
# ARG CKAN_VERSION=2.9.7
# FROM ghcr.io/tum-gis/ckan-sddi-base:${BASEIMAGE_VERSION} as runtime

# # List all extensions here
# ENV CKAN__PLUGINS envvars image_view text_view recline_view datastore datapusher scheming_datasets hierarchy_display hierarchy_form hierarchy_group_form  repeating composite restricted geo_view geojson_view wmts_view shp_view

# # Switch to the root user
# USER root

# # Copy python wheels from build stage
# COPY --from=extbuild /wheels /srv/app/ext_wheels

# # Install and enable the custom extensions, remove wheels

# ############################## hierarchy ##############################
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-hierarchy && \
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels -r /srv/app/ext_wheels/ckanext-hierarchy.txt && \

# ############################## repeating ##############################
# RUN set -ex && \
#   pip install --no-cache-dir -U ckanapi
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-repeating  && \

# ############################## composite ##############################
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-composite  && \

# ############################## restricted ##############################
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-restricted  && \

# ############################## scheming ##############################
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-scheming && \
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels -r /srv/app/ext_wheels/ckanext-scheming.txt && \
#   ckan config-tool "${APP_DIR}/production.ini" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
#   ckan config-tool "${APP_DIR}/production.ini" "scheming.presets = ckanext.scheming:presets.json" && \
#   ckan config-tool "${APP_DIR}/production.ini" "scheming.dataset_fallback = false" && \

# ############################## geoview ##############################
# RUN set -ex && \
#   pip install --no-index --find-links=/srv/app/ext_wheels ckanext-geoview && \
#   ckan config-tool "${APP_DIR}/production.ini" "ckan.views.default_views = geo_view geojson_view wmts_view shp_view" && \
#   ckan config-tool "${APP_DIR}/production.ini" "ckanext.geoview.ol_viewer.formats = wms kml" && \
#   ckan config-tool "${APP_DIR}/production.ini" "ckanext.geoview.shp_viewer.srid = 4326" && \
#   ckan config-tool "${APP_DIR}/production.ini" "ckanext.geoview.shp_viewer.encoding = UTF-8" && \

#   ckan config-tool "${APP_DIR}/production.ini" "ckan.plugins = ${CKAN__PLUGINS}" && \
#   chown -R ckan:ckan /srv/app && \
#   rm -rf /srv/app/ext_wheels

# # Switch to the ckan user
# USER ckan
