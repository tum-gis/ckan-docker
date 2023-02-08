###############################################################################
# Runtime stage
###############################################################################
ARG CKAN_VERSION=2.9.7
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

ENV CKAN__PLUGINS image_view text_view recline_view datastore datapusher envvars

USER root

# Copy webassets and init scripts
COPY --chown=ckan:ckan afterinit.d/ ${APP_DIR}/docker-afterinit.d/
COPY --chown=ckan:ckan webassets/ ${DATA_DIR}/webassets/

USER ckan
