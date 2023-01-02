############
### MAIN ###
############
ARG CKAN_VERSION=2.9.5
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

# Switch to the root user
USER root


# Install and enable the custom extensions
RUN set -ex && \
  # Upgrade pip
  # pip install --no-cache-dir -U pip && \
  # Install additional pip packages for runtime
  pip install --no-cache-dir -U ckanapi
  # Install ckan extension wheels from build stage
  # pip install --no-index --find-links=/srv/app/ext_wheels ckanext-hierarchy ckanext-grouphierarchy ckanext-scheming && \
  # chown -R ckan:ckan /srv/app && \
  # rm -rf /srv/app/ext_wheels && \
  # ckan -c ${APP_DIR}/production.ini config-tool "ckan.plugins = ${CKAN__PLUGINS}" && \

# Setup SDDI CKAN styling
COPY --chown=ckan:ckan afterinit.d/ ${APP_DIR}/docker-afterinit.d/
COPY --chown=ckan:ckan webassets/ ${DATA_DIR}/webassets/

# Switch to the ckan user
USER ckan
