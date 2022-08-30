###################
### Extensions ####
###################
ARG CKAN_VERSION=2.9.5
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as extbuild

# Switch to the root user
USER root

# Install any system packages necessary to build extensions
RUN set -ex && \
  apk add --no-cache --virtual .build-deps \
    python3-dev
    # && \
    # pip install --upgrade pip

# Fetch and build the custom CKAN extensions
# RUN pip wheel --wheel-dir=/wheels git+https://github.com/acmecorp/ckanext-acme@0.0.1#egg=ckanext-acme

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git#egg=ckanext-hierarchy

############
### MAIN ###
############
ARG CKAN_VERSION=2.9.5
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

# Add the custom extensions to the plugins list
ENV CKAN__PLUGINS hierarchy

# envvars image_view text_view recline_view datastore datapusher

# Switch to the root user
USER root

COPY --from=extbuild /wheels /srv/app/ext_wheels

# Install and enable the custom extensions
RUN set -ex 66 \
  pip install --no-index --find-links=/srv/app/ext_wheels ckanext-hierarchy && \
    chown -R ckan:ckan /srv/app

  # ckan -c ${APP_DIR}/production.ini config-tool "ckan.plugins = ${CKAN__PLUGINS}" && \

# Remove wheels
RUN rm -rf /srv/app/ext_wheels

# Switch to the ckan user
USER ckan
