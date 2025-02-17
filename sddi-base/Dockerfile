###############################################################################
# Extbuild stage
###############################################################################
ARG CKAN_VERSION_BUILD_STAGE=2.11.1

FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as extbuild

USER root

RUN apt-get update && apt-get install -y \
    curl \
    libpq-dev \
    gcc \
    make \
    g++ \
    autoconf \
    automake \
    libtool \
    patch \
    musl-dev \
    libpcre3-dev \
    libpcre3 \
    libffi-dev \
    libxml2-dev \
    libxslt-dev

RUN pip install -U markupsafe==2.0.1 sqlalchemy==1.4.41

# ckanext-hierarchy ###########################################################
ARG CKANEXT_HIERARCHY_VERSION="abb4e2d"
ENV CKANEXT_HIERARCHY_VERSION=${CKANEXT_HIERARCHY_VERSION}

RUN set -ex && \
    mkdir -p /wheels && \
    pip install -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-hierarchy.git@${CKANEXT_HIERARCHY_VERSION}#egg=ckanext-hierarchy && \
  curl -o /wheels/ckanext-hierarchy.txt https://raw.githubusercontent.com/ckan/ckanext-hierarchy/${CKANEXT_HIERARCHY_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-envvars #############################################################
ARG CKANEXT_ENVVARS_VERSION="v0.0.6"
ENV CKANEXT_ENVVARS_VERSION=${CKANEXT_ENVVARS_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-envvars.git@${CKANEXT_ENVVARS_VERSION}#egg=ckanext-envvars

# ckanext-scheming ############################################################
ARG CKANEXT_SCHEMING_VERSION="27035f4"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com//ckan/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext-geoview #############################################################
ARG CKANEXT_GEOVIEW_VERSION="v0.2.2"
ENV CKANEXT_GEOVIEW_VERSION=${CKANEXT_GEOVIEW_VERSION}
ENV CKANEXT_GEOVIEW_GITHUB_URL="https://github.com/ckan/ckanext-geoview"

RUN set -ex && \
    curl -o /wheels/ckanext-geoview-dev-requirements.txt \
        ${CKANEXT_GEOVIEW_GITHUB_URL}/raw/${CKANEXT_GEOVIEW_VERSION}/dev-requirements.txt && \
    pip install -r /wheels/ckanext-geoview-dev-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_GEOVIEW_GITHUB_URL}.git@${CKANEXT_GEOVIEW_VERSION}#egg=ckanext-geoview

# ckanext-clamav #############################################################
ARG CKANEXT_CLAMAV_VERSION="a1d23ac"
ENV CKANEXT_CLAMAV_VERSION=${CKANEXT_CLAMAV_VERSION}
ENV CKANEXT_CLAMAV_GITHUB_URL="https://github.com/DataShades/ckanext-clamav"

RUN set -ex && \
    curl -o /wheels/ckanext-clamav-requirements.txt \
        ${CKANEXT_CLAMAV_GITHUB_URL}/raw/${CKANEXT_CLAMAV_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-clamav-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_CLAMAV_GITHUB_URL}.git@${CKANEXT_CLAMAV_VERSION}#egg=ckanext-clamav

# ckanext-dcat ##########################################################
ARG CKANEXT_DCAT_VERSION="v1.5.1"
ENV CKANEXT_DCAT_VERSION=${CKANEXT_DCAT_VERSION}
ENV CKANEXT_DCAT_GITHUB_URL="https://github.com/ckan/ckanext-dcat"

RUN set -ex && \
    curl -o /wheels/ckanext-dcat-requirements.txt \
        https://raw.githubusercontent.com/ckan/ckanext-dcat/${CKANEXT_DCAT_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-dcat-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_DCAT_GITHUB_URL}.git@${CKANEXT_DCAT_VERSION}#egg=ckanext-dcat

###############################################################################
# Runtime stage
###############################################################################
FROM ckan/ckan-base:${CKAN_VERSION_BUILD_STAGE} as runtime

ENV APP_DIR=/srv/app
ENV SRC_DIR=/srv/app/src
ENV CKAN_DIR=${SRC_DIR}/ckan
ENV DATA_DIR=/srv/app/data
ENV PIP_SRC=${SRC_DIR}
ENV CKAN_INI=${APP_DIR}/production.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan
ENV UWSGI_HARAKIRI=50

USER root

# Setting the locale
ENV LC_ALL="en_US.UTF-8"
RUN update-locale LANG=${LC_ALL}

# Update the package lists and install required packages
RUN apt-get update && apt-get install -y \
    bash \
    gettext \
    curl \
    unzip \
    postgresql-client \
    libmagic1 \
    libpcre3 \
    libxslt1.1 \
    libxml2 \
    tzdata \
    apache2-utils \
    musl-dev \
    libssl-dev \
    proj-bin \
    libproj-dev \
    proj-data \
    python3-cffi \
    uwsgi-plugin-python3 \
    supervisor \
    sudo

# Cleanup to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Link python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Get artifacts from build stages
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels

# Create local storage folder
RUN mkdir -p ${CKAN_STORAGE_PATH} && \
    chown -R ckan:ckan-sys ${CKAN_STORAGE_PATH} && \
    chown -R ckan:ckan-sys ${APP_DIR}

USER ckan

RUN set -ex pip install markupsafe==2.0.1 \
                        setuptools \
                        wheel \
                        sqlalchemy==1.4.41 \
                        gevent==22.10.2 \
                        greenlet==2.0.1

WORKDIR ${CKAN_DIR}

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-hierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-hierarchy

# ckanext-envvars ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-envvars

# ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-geoview #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-geoview

# ckanext-clamav #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-clamav

# ckanext-dcat ##########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-dcat-requirements.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-dcat

ENV CKAN__PLUGINS "envvars image_view text_view webpage_view datastore \
  tracking \
  activity \
  hierarchy_display hierarchy_form \
  scheming_datasets \
  geo_view geojson_view wmts_view shp_view \
  dcat dcat_json_interface \
  clamav"

RUN set -ex && \
  ckan generate config ${APP_DIR}/production.ini

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheme_sddi:sddi_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.scheme_sddi:sddi_presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dcat.enable_content_negotiation = True" && \
  ckan config-tool "${CKAN_INI}" "PERMANENT_SESSION_LIFETIME = 600"

# Remove wheels
RUN set -ex && \
  rm -rf ${APP_DIR}/ext_wheels

WORKDIR ${APP_DIR}

# Create entrypoint directory for children image scripts
ONBUILD RUN mkdir -p /docker-entrypoint.d

EXPOSE 5000

HEALTHCHECK --interval=60s --timeout=5s --retries=5 CMD curl --fail http://localhost:5000/api/3/action/status_show || exit CMD ["/srv/app/start_ckan.sh"]

CMD ["/srv/app/start_ckan.sh"]
