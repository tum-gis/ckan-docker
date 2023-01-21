###############################################################################
# Build stage
###############################################################################
ARG CKAN_VERSION=2.9.7
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as extbuild
# FROM ckan/ckan:${CKAN_VERSION} as extbuild

ARG CKAN_SPATIAL_VERSION=master
ENV CKAN_SPATIAL_VERSION=${CKAN_SPATIAL_VERSION}

# Switch to the root user
USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
  apt-get update && \
  apt-get install python3-dev libxml2-dev libxslt1-dev libgeos-c1v5 -y

 RUN set -ex && \
  pip install -U pip && \
  pip wheel --wheel-dir=/wheels \
  git+https://github.com/ckan/ckanext-spatial.git@${CKAN_SPATIAL_VERSION}#egg=ckanext-spatial && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKAN_SPATIAL_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-spatial.txt https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKAN_SPATIAL_VERSION}/requirements.txt

###############################################################################
# Runtime stage
###############################################################################
FROM reg.gitlab.brunowillenborg.de/ckan/sddi-base:${CKAN_VERSION} as runtime

# List all extensions here
ENV CKAN__PLUGINS envvars image_view text_view recline_view datastore datapusher spatial_metadata spatial_query

# Switch to the root user
USER root

# Copy python wheels from build stage
COPY --from=extbuild /wheels /srv/app/ext_wheels
COPY --chown=ckan:ckan template/ $CKAN_DIR/ckan/templates

# Install and enable the custom extensions, remove wheels
RUN set -ex && \
  pip install -U -r /srv/app/ext_wheels/ckanext-spatial.txt && \
  pip install --no-index --find-links=/srv/app/ext_wheels ckanext-spatial && \
  ckan config-tool "${APP_DIR}/production.ini" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${APP_DIR}/production.ini" "ckanext.spatial.use_postgis_sorting=true" && \
  ckan config-tool "${APP_DIR}/production.ini" "ckanext.spatial.search_backend = solr" && \
  ckan config-tool "${APP_DIR}/production.ini" "ckan.spatial.srid = 4326" && \
  chown -R ckan:ckan /srv/app && \
  rm -rf /srv/app/ext_wheels

# Switch to the ckan user
USER ckan
