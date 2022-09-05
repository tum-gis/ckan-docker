###################
### Extensions ####
###################
ARG CKAN_VERSION=2.9.5
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as extbuild

# Switch to the root user
USER root

# Install common build tools and upgrade pip
RUN set -ex && \
  apk add --no-cache --virtual .build-deps-common \
    python3-dev && \
    pip install -U pip

# Example extension build #####################################################

# Install build deps
RUN set -ex && \
   mkdir -p /wheels
#    && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git#egg=ckanext-hierarchy && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/tum-gis/ckanext-grouphierarchy-sddi.git#egg=ckanext-grouphierarchy && \
#   pip wheel --wheel-dir=/wheels git+https://github.com/tum-gis/ckanext-scheming-sddi.git#egg=ckanext-scheming && \
#   ls -lah /wheels


############
### MAIN ###
############
ARG CKAN_VERSION=2.9.5
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

# Add the custom extensions to the plugins list
ENV CKAN__PLUGINS envvars image_view text_view recline_view datastore datapusher

# Switch to the root user
USER root

COPY --from=extbuild /wheels /srv/app/ext_wheels

# Install and enable the custom extensions
RUN set -ex && \
  # Upgrade pip
  pip install --no-cache-dir -U pip && \
  # Install additional pip packages for runtime
  pip install --no-cache-dir -U ckanapi
  # Install ckan extension wheels from build stage
  # pip install --no-index --find-links=/srv/app/ext_wheels ckanext-hierarchy ckanext-grouphierarchy ckanext-scheming && \
  # chown -R ckan:ckan /srv/app && \
  # rm -rf /srv/app/ext_wheels && \
  # ckan -c ${APP_DIR}/production.ini config-tool "ckan.plugins = ${CKAN__PLUGINS}" && \

# Setup SDDI CKAN styling
COPY --chown=ckan:ckan afterinit.d/02_create_groups.sh ${APP_DIR}/docker-afterinit.d/
COPY --chown=ckan:ckan webassets/ ${DATA_DIR}/webassets/

# Switch to the ckan user
USER ckan
