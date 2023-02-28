# ###############################################################################
# # Build stage
# ###############################################################################
ARG CKAN_VERSION=2.9.7

FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as extbuild

# ckanext-hierarchy ###########################################################
ARG CKAN_EXT_HIERARCHY_VERSION=master
ENV CKAN_EXT_HIERARCHY_VERSION=${CKAN_EXT_HIERARCHY_VERSION}

USER root

RUN set -ex && \
  apk update && \
  apk add --no-cache --virtual .build-deps \
    python3-dev && \
    pip install --upgrade pip \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/dev-requirements.txt

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels git+https://github.com/davidread/ckanext-hierarchy.git@${CKAN_EXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKAN_EXT_HIERARCHY_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-hierarchy ###########################################################
ARG CKAN_EXT_SDDI_VERSION="2.9-support"
ENV CKAN_EXT_SDDI_VERSION=${CKAN_EXT_SDDI_VERSION}

RUN set -ex && \
  mkdir -p /wheels && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-grouphierarchy-sddi.git@${CKAN_EXT_SDDI_VERSION}#egg=ckanext-grouphierarchy && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKAN_EXT_SDDI_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-grouphierarchy.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKAN_EXT_SDDI_VERSION}/requirements.txt && \
  ls -lah /wheels

###############################################################################
# Runtime stage
###############################################################################
ARG CKAN_VERSION=2.9.7
FROM ghcr.io/keitaroinc/ckan:${CKAN_VERSION} as runtime

ENV CKAN__PLUGINS image_view text_view recline_view datastore datapusher envvars hierarchy_display hierarchy_form display_group

USER root

# Copy python wheels from build stage
ARG CKAN_EXT_SDDI_VERSION="2.9-support"
COPY --from=extbuild /wheels /srv/app/ext_wheels
COPY --chown=ckan:ckan afterinit.d/ ${APP_DIR}/docker-afterinit.d/
ADD https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKAN_EXT_SDDI_VERSION}/ckanext/grouphierarchy/init_data.json \
  /usr/lib/python3.8/site-packages/ckanext/grouphierarchy/init_data.json

# Install runtime dependencies
RUN set -ex && \
  pip install --no-cache-dir -U pip && \
  pip install --no-cache-dir -U ckanapi

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=/srv/app/ext_wheels ckanext-hierarchy && \
  pip install --no-index --find-links=/srv/app/ext_wheels -r /srv/app/ext_wheels/ckanext-hierarchy.txt

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=/srv/app/ext_wheels ckanext-grouphierarchy && \
  pip install --no-index --find-links=/srv/app/ext_wheels -r /srv/app/ext_wheels/ckanext-grouphierarchy.txt

RUN set -ex && \
  ckan config-tool "${APP_DIR}/production.ini" "ckan.plugins = ${CKAN__PLUGINS}" && \
  chown -R ckan:ckan /srv/app && \
  chown -Rv ckan:ckan /usr/lib/python3.8/site-packages/ckanext/grouphierarchy/init_data.json && \
  # Remove wheels
  rm -rf /srv/app/ext_wheels

USER ckan
