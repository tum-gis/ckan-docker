############
### MAIN ###
############
ARG CKAN_VERSION=2.9.7
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

USER root

RUN set -ex && \
  pip install --no-cache-dir -U pip && \
  pip install --no-cache-dir -U ckanapi

# Copy webassets and init scripts
COPY --chown=ckan:ckan afterinit.d/ ${APP_DIR}/docker-afterinit.d/
COPY --chown=ckan:ckan webassets/ ${DATA_DIR}/webassets/

USER ckan
