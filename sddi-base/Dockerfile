###############################################################################
# CKAN build stage
###############################################################################
FROM python:3.9-slim as ckanbuild

# Used by Github Actions to tag the image with
ENV IMAGE_TAG=2.11.0

# Set CKAN version to build
ENV GIT_URL=https://github.com/ckan/ckan.git
ENV GIT_BRANCH=ckan-2.11.0

# Set src dirs
ENV SRC_DIR=/srv/app/src
ENV PIP_SRC=${SRC_DIR}

WORKDIR ${SRC_DIR}

RUN apt-get update && apt-get install -y \
    git \
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

 # Cleanup to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Link python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Create the src directory
RUN mkdir -p ${SRC_DIR}

# Downgrade setuptools so that CKAN requirements can be built
RUN pip3 install setuptools==44.1.0

# Fetch and build CKAN and requirements
RUN pip3 install -e git+${GIT_URL}@${GIT_BRANCH}#egg=ckan

# Apply patches
RUN rm -rf /srv/app/src/ckan/.git

# Create a constraint file that limits the Cython version to a compatible one, see https://github.com/yaml/pyyaml/issues/736
RUN echo 'Cython < 3.0' > /tmp/constraint.txt
RUN pip3_CONSTRAINT=/tmp/constraint.txt pip3 wheel --wheel-dir=/wheels PyYAML==5.4.1

# RUN pip3-compile ckan/requirements.in
RUN pip3 wheel --wheel-dir=/wheels -r ckan/requirements.txt
RUN pip3 wheel --wheel-dir=/wheels uWSGI==2.0.21 gevent==22.10.2 greenlet==2.0.1

###############################################################################
# Extbuild stage
###############################################################################
FROM python:3.9-slim as extbuild

USER root

RUN apt-get update && apt-get install -y \
    git \
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

# Create a constraint file that limits the Cython version to a compatible one, see https://github.com/yaml/pyyaml/issues/736
RUN echo 'Cython < 3.0' > /tmp/constraint.txt
RUN pip3_CONSTRAINT=/tmp/constraint.txt pip3 wheel --wheel-dir=/wheels PyYAML==5.4.1

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

# ckanext-envvars
ENV ENVVARS_GIT_URL=https://github.com/ckan/ckanext-envvars/
ENV ENVVARS_GIT_BRANCH=v0.0.6

RUN set -ex && \
  pip3 wheel --wheel-dir=/wheels git+${ENVVARS_GIT_URL}@${ENVVARS_GIT_BRANCH}#egg=ckanext-envvars

# ckanext-relation ############################################################
ARG CKANEXT_RELATION_VERSION="1.1.0"
ENV CKANEXT_RELATION_VERSION=${CKANEXT_RELATION_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-relation-sddi.git@${CKANEXT_RELATION_VERSION}#egg=ckanext-relation && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-relation.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-relation-sddi/${CKANEXT_RELATION_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-scheming ############################################################
ARG CKANEXT_SCHEMING_VERSION="27035f4"
ENV CKANEXT_SCHEMING_VERSION=${CKANEXT_SCHEMING_VERSION}
ENV CKANEXT_SCHEMING_GITHUB_URL="https://github.com//ckan/ckanext-scheming"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEMING_GITHUB_URL}.git@${CKANEXT_SCHEMING_VERSION}#egg=ckanext-scheming

# ckanext datesearch ##########################################################
ARG CKANEXT_DATESEARCH_VERSION="1.1.0"
ENV CKANEXT_DATESEARCH_VERSION=${CKANEXT_DATESEARCH_VERSION}
ENV CKANEXT_DATESEARCH_VERSION_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-datesearch"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_DATESEARCH_VERSION_GITHUB_URL}.git@${CKANEXT_DATESEARCH_VERSION}#egg=ckanext-datesearch

# ckanext-harvest ###########################################################
ARG CKANEXT_HARVEST_VERSION="v1.6.0"
ENV CKANEXT_HARVEST_VERSION=${CKANEXT_HARVEST_VERSION}
ENV CKANEXT_HARVEST_GITHUB_URL="https://github.com/ckan/ckanext-harvest.git"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+https://github.com/ckan/ckanext-harvest.git@${CKANEXT_HARVEST_VERSION}#egg=ckanext-harvest && \
  curl -o /wheels/ckanext-harvest.txt https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-spatial #############################################################
ENV CKANEXT_SPATIAL_GITHUB_URL="https://github.com/ckan/ckanext-spatial"
ENV CKANEXT_SPATIAL_VERSION="8a00a2b"

RUN set -ex && \
  curl -o /wheels/ckanext-spatial-requirements.txt \
    https://raw.githubusercontent.com/ckan/ckanext-spatial/${CKANEXT_SPATIAL_VERSION}/requirements-py2.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SPATIAL_GITHUB_URL}.git@${CKANEXT_SPATIAL_VERSION}#egg=ckanext-spatial

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

# ckanext-scheme-sddi #############################################################
ARG CKANEXT_SCHEME_SDDI_VERSION="0.0.1"
ENV CKANEXT_SCHEME_SDDI_VERSION=${CKANEXT_SCHEME_SDDI_VERSION}
ENV CKANEXT_SCHEME_SDDI_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-scheme-sddi"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r ${CKANEXT_SCHEME_SDDI_GITHUB_URL}/raw/${CKANEXT_SCHEME_SDDI_VERSION}/dev-requirements.txt

RUN set -ex && \
  pip wheel --wheel-dir=/wheels -r ${CKANEXT_SCHEME_SDDI_GITHUB_URL}/raw/${CKANEXT_SCHEME_SDDI_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels git+${CKANEXT_SCHEME_SDDI_GITHUB_URL}.git@${CKANEXT_SCHEME_SDDI_VERSION}#egg=ckanext-scheme-sddi && \
  curl -o /wheels/ckanext-scheme-sddi.txt ${CKANEXT_SCHEME_SDDI_GITHUB_URL}/raw/${CKANEXT_SCHEME_SDDI_VERSION}/requirements.txt && \
  ls -lah /wheels

# ckanext-theme-sddi #############################################################
ARG CKANEXT_THEME_SDDI_VERSION="0.0.1"
ENV CKANEXT_THEME_SDDI_VERSION=${CKANEXT_THEME_SDDI_VERSION}
ENV CKANEXT_THEME_SDDI_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-theme-sddi"

RUN set -ex && \
    curl -o /wheels/ckanext-theme-sddi-dev-requirements.txt \
        ${CKANEXT_THEME_SDDI_GITHUB_URL}/raw/${CKANEXT_THEME_SDDI_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-theme-sddi-dev-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_THEME_SDDI_GITHUB_URL}.git@${CKANEXT_THEME_SDDI_VERSION}#egg=ckanext-theme-sddi

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

# ckanext-security ######################################################
ARG CKANEXT_SECURITY_VERSION="80dc1d6"
ENV CKANEXT_SECURITY_VERSION=${CKANEXT_SECURITY_VERSION}
ENV CKANEXT_SECURITY_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-security"
    
RUN set -ex && \
    curl -o /wheels/ckanext-security-requirements.txt \
        https://raw.githubusercontent.com/MarijaKnezevic/ckanext-security/${CKANEXT_SECURITY_VERSION}/requirements.txt && \
    pip install -r /wheels/ckanext-security-requirements.txt && \
    pip wheel --wheel-dir=/wheels \
        git+${CKANEXT_SECURITY_GITHUB_URL}.git@${CKANEXT_SECURITY_VERSION}#egg=ckanext-security

###############################################################################
# Runtime stage
###############################################################################
FROM python:3.9-slim

ENV APP_DIR=/srv/app
ENV SRC_DIR=/srv/app/src
ENV CKAN_DIR=${SRC_DIR}/ckan
ENV DATA_DIR=/srv/app/data
ENV PIP_SRC=${SRC_DIR}
ENV GIT_BRANCH=ckan-2.11.0

# Setting the locale
ENV LC_ALL="en_US.UTF-8"
RUN apt-get update && apt-get install --no-install-recommends -y locales
RUN sed -i "/$LC_ALL/s/^# //g" /etc/locale.gen
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=${LC_ALL}

# Set timezone
RUN echo "UTC" >  /etc/timezone
ENV CKAN_INI=${APP_DIR}/production.ini
ENV CKAN_STORAGE_PATH=/var/lib/ckan

# Update the package lists and install required packages
RUN apt-get update && apt-get install -y \
    bash \
    git \
    gettext \
    curl \
    wget \
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
    supervisor

# Cleanup to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install markupsafe==2.0.1 setuptools wheel sqlalchemy==1.4.41

# Create a constraint file that limits the Cython version to a compatible one, see https://github.com/yaml/pyyaml/issues/736
RUN echo 'Cython < 3.0' > /tmp/constraint.txt
RUN pip3_CONSTRAINT=/tmp/constraint.txt pip3 wheel --wheel-dir=/wheels PyYAML==5.4.1

# Create SRC_DIR
RUN mkdir -p ${SRC_DIR} && \
    # Link python to python3
    ln -s /usr/bin/python3 /usr/bin/python

# Get artifacts from build stages
COPY --from=ckanbuild /wheels ${APP_DIR}/wheels
COPY --from=extbuild /wheels ${APP_DIR}/ext_wheels
COPY --from=ckanbuild ${APP_DIR}/src/ckan ${CKAN_DIR}

# Additional install steps for build stages artifacts
RUN pip3 install --no-index --find-links=${APP_DIR}/wheels uWSGI==2.0.21 gevent==22.10.2 greenlet==2.0.1

# Create a local user and group to run the app
# Add a group with a specific GID (92)
RUN groupadd -g 92 ckan
# Add a user with a specific UID (92), home directory, and add to the ckan group
RUN useradd -u 92 -g ckan -M -d ${APP_DIR} -s /bin/bash ckan

WORKDIR ${CKAN_DIR}

# Install CKAN
RUN pip3 install -e ${APP_DIR}/src/ckan
RUN pip3 install --no-index --find-links=${APP_DIR}/wheels -r requirements.txt

# ckanext-harvest ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-harvest && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-harvest.txt

# ckanext-hierarchy ###########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-hierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-hierarchy

# ckanext-envvars ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-envvars

# ckanext-relation ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-relation

# ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-spatial #############################################################
RUN set -ex && \
  pip3 install -e 'git+https://github.com/ckan/ckanext-spatial.git#egg=ckanext-spatial' && \
  pip3 install -r 'https://raw.githubusercontent.com/ckan/ckanext-spatial/master/requirements.txt'

# ckanext-geoview #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-geoview

# ckanext-scheme-sddi #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheme-sddi

# ckanext-theme-sddi #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-theme-sddi

# ckanext-heroslideradmin #############################################################
RUN set -ex && \
  pip install -e "git+https://github.com/dathere/ckanext-heroslideradmin.git@4b60e00#egg=ckanext-heroslideradmin"

# ckanext-clamav #############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-clamav

# ckanext-fortify ##############################
RUN set -ex && \
  pip install -e "git+https://github.com/salsadigitalauorg/ckanext-fortify#egg=ckanext-fortify"

# ckanext-dcat ##########################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-dcat-requirements.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-dcat

# ckanext-security ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-security-requirements.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-security

ENV CKAN__PLUGINS "envvars image_view text_view webpage_view datastore \
  harvest ckan_harvester \
  hierarchy_display hierarchy_form \
  relation \
  spatial_metadata spatial_query \
  datesearch \
  scheme_sddi \
  theme_sddi \
  scheming_datasets \
  geo_view geojson_view wmts_view shp_view \
  fortify \
  security \
  heroslideradmin \
  dcat dcat_rdf_harvester dcat_json_harvester dcat_json_interface \
  clamav"

RUN set -ex && \
  ckan generate config ${APP_DIR}/production.ini

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.use_postgis_sorting = true" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.scheme_sddi:sddi_presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dathere_theme.column_count = 4" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.type = custom" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.custom.url = https://tile.openstreetmap.de/{z}/{x}/{y}.png" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.attribution = <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors." && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.lock_timeout = 900" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.login_max_count = 3" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.brute_force_key = user_name" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.disable_password_reset_override = true" && \
  ckan config-tool "${CKAN_INI}" "ckanext.security.enable_totp = false" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.enable_password_policy = True" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.password_policy.min_length = 12" && \
  ckan config-tool "${CKAN_INI}" "ckan.fortify.check_parent_org_allowed = True" && \
  ckan config-tool "${CKAN_INI}" "ckanext.dcat.enable_content_negotiation = True" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_scope = 0" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_level = debug" && \
  ckan config-tool "${CKAN_INI}" "ckan.harvest.log_timeframe = 10" && \
  ckan config-tool "${CKAN_INI}" "PERMANENT_SESSION_LIFETIME = 600" && \
  echo "${TZ}" > /etc/timezone && \
  mkdir -p ${CKAN_STORAGE_PATH} && \
  chown -R ckan:ckan ${APP_DIR} ${CKAN_STORAGE_PATH} && \
  # Remove wheels
  rm -rf ${APP_DIR}/ext_wheels

WORKDIR ${APP_DIR}

ENV UWSGI_HARAKIRI=50

# Create local storage folder
RUN mkdir -p ${CKAN_STORAGE_PATH} && \
    chown -R ckan:ckan ${CKAN_STORAGE_PATH}

# Copy local scripts
COPY setup/prerun.py ${APP_DIR}
COPY setup/start_ckan.sh ${APP_DIR}
ADD https://raw.githubusercontent.com/ckan/ckan/${GIT_BRANCH}/wsgi.py ${APP_DIR}
RUN chmod 644 ${APP_DIR}/wsgi.py

# Create entrypoint directory for children image scripts
ONBUILD RUN mkdir /docker-entrypoint.d

EXPOSE 5000

HEALTHCHECK --interval=60s --timeout=5s --retries=5 CMD curl --fail http://localhost:5000/api/3/action/status_show || exit CMD ["/srv/app/start_ckan.sh"]

CMD ["/srv/app/start_ckan.sh"]
