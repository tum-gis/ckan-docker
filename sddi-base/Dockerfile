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
RUN pip3 wheel --wheel-dir=/wheels uWSGI==2.0.20 gevent==21.12.0 greenlet==1.1.3

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

RUN pip install -U markupsafe==2.0.1

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
ENV ENVVARS_GIT_URL=https://github.com/okfn/ckanext-envvars
ENV ENVVARS_GIT_BRANCH=0.0.2

RUN set -ex && \
  pip3 wheel --wheel-dir=/wheels git+${ENVVARS_GIT_URL}@${ENVVARS_GIT_BRANCH}#egg=ckanext-envvars

# ckanext-grouphierarchy ######################################################
ARG CKANEXT_SDDI_VERSION="1.1.3"
ENV CKANEXT_SDDI_VERSION=${CKANEXT_SDDI_VERSION}

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+https://github.com/tum-gis/ckanext-grouphierarchy-sddi.git@${CKANEXT_SDDI_VERSION}#egg=ckanext-grouphierarchy && \
  pip wheel --wheel-dir=/wheels -r \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKANEXT_SDDI_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-grouphierarchy.txt \
    https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/${CKANEXT_SDDI_VERSION}/requirements.txt && \
  ls -lah /wheels

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

# ckanext-composite ###########################################################
ARG CKANEXT_COMPOSITE_VERSION="1e6d7bb"
ENV CKANEXT_COMPOSITE_VERSION=${CKANEXT_COMPOSITE_VERSION}
ENV CKANEXT_COMPOSITE_GITHUB_URL="https://github.com/EnviDat/ckanext-composite"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/EnviDat/ckanext-composite/${CKANEXT_COMPOSITE_VERSION}/dev-requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_COMPOSITE_GITHUB_URL}.git@${CKANEXT_COMPOSITE_VERSION}#egg=ckanext-composite

# ckanext-repeating ###########################################################
ARG CKANEXT_REPEATING_VERSION="1.0.0"
ENV CKANEXT_REPEATING_VERSION=${CKANEXT_REPEATING_VERSION}
ENV CKANEXT_REPEATING_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-repeating"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_REPEATING_GITHUB_URL}.git@${CKANEXT_REPEATING_VERSION}#egg=ckanext-repeating

# ckanext-password-policy #####################################################
ARG CKANEXT_PASSWORD_POLICY_VERSION="5618dc9"
ENV CKANEXT_PASSWORD_POLICY_VERSION=${CKANEXT_PASSWORD_POLICY_VERSION}
ENV CKANEXT_PASSWORD_POLICY_GITHUB_URL="https://github.com/keitaroinc/ckanext-password-policy"

RUN set -ex && \
  pip install -r \
    https://raw.githubusercontent.com/keitaroinc/ckanext-password-policy/${CKANEXT_PASSWORD_POLICY_VERSION}/requirements.txt && \
  curl -o /wheels/ckanext-password-policy.txt \
    https://raw.githubusercontent.com/keitaroinc/ckanext-password-policy/${CKANEXT_PASSWORD_POLICY_VERSION}/requirements.txt && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_PASSWORD_POLICY_GITHUB_URL}.git@${CKANEXT_PASSWORD_POLICY_VERSION}#egg=ckanext-password-policy

# ckanext-harvest ###########################################################
ARG CKANEXT_HARVEST_VERSION="v1.5.6"
ENV CKANEXT_HARVEST_VERSION=${CKANEXT_HARVEST_VERSION}
ENV CKANEXT_HARVEST_GITHUB_URL="https://github.com/ckan/ckanext-harvest.git"

RUN set -ex && \
  mkdir -p /wheels && \
  pip install -r https://raw.githubusercontent.com/ckan/ckanext-harvest/${CKANEXT_HARVEST_VERSION}/dev-requirements.txt

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
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_GEOVIEW_GITHUB_URL}.git@${CKANEXT_GEOVIEW_VERSION}#egg=ckanext-geoview

# ckanext-scheme-sddi #############################################################
ARG CKANEXT_SCHEME_SDDI_VERSION="v0.0.1"
ENV CKANEXT_SCHEME_SDDI_VERSION=${CKANEXT_SCHEME_SDDI_VERSION}
ENV CKANEXT_SCHEME_SDDI_GITHUB_URL="https://github.com/MarijaKnezevic/ckanext-scheme-sddi"

RUN set -ex && \
  pip wheel --wheel-dir=/wheels \
    git+${CKANEXT_SCHEME_SDDI_GITHUB_URL}.git@${CKANEXT_SCHEME_SDDI_VERSION}#egg=ckanext-scheme-sddi

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
    supervisor

# Cleanup to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install markupsafe==2.0.1 setuptools wheel

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
RUN pip3 install --no-index --find-links=${APP_DIR}/wheels uWSGI==2.0.20 gevent==21.12.0

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

# ckanext-grouphierarchy ######################################################
RUN set -ex && \
  pip install --find-links=${APP_DIR}/ext_wheels -r ${APP_DIR}/ext_wheels/ckanext-grouphierarchy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-grouphierarchy

# ckanext-envvars ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-envvars

# ckanext-scheming ############################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-scheming

# ckanext-datesearch ##########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-datesearch

# ckanext-composite ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-composite

# ckanext-repeating ###########################################################
RUN set -ex && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-repeating

# ckanext-password-policy #####################################################
RUN set -ex && \
  pip install -r ${APP_DIR}/ext_wheels/ckanext-password-policy.txt && \
  pip install --no-index --find-links=${APP_DIR}/ext_wheels ckanext-password-policy

# ckanext-spatial #############################################################
RUN set -ex && \
  pip3 install -e 'git+https://github.com/ckan/ckanext-spatial.git#egg=ckanext-spatial' && \
  pip3 install -r 'https://raw.githubusercontent.com/ckan/ckanext-spatial/master/requirements.txt'


ENV CKAN__PLUGINS "envvars image_view text_view recline_view webpage_view datastore \
  harvest ckan_harvester \
  hierarchy_display hierarchy_form \
  # datapusher Token required \
  # display_group ValueError: Cannot determine url for /usr/local/lib/python3.9/site-packages/ckanext/grouphierarchy/fanstatic/hierarchy_theme.css \
  # relation  ImportError: cannot import name 'Mapping' from 'collections' \
  spatial_metadata spatial_query \
  scheming_datasets \
  datesearch \
  composite \
  repeating"
  # password_policy No module named 'ckan.lib.repoze_plugins' \

RUN set -ex && \
  ckan generate config ${APP_DIR}/production.ini

RUN set -ex && \
  ckan config-tool "${CKAN_INI}" "ckan.plugins = ${CKAN__PLUGINS}" && \
  ckan config-tool "${CKAN_INI}" "ckan.spatial.srid = 4326" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.search_backend = solr-bbox" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_schemas = ckanext.scheming:ckan_dataset.yaml" && \
  ckan config-tool "${CKAN_INI}" "scheming.presets = ckanext.scheming:presets.json ckanext.repeating:presets.json ckanext.composite:presets.json" && \
  ckan config-tool "${CKAN_INI}" "scheming.dataset_fallback = false" && \
  ckan config-tool "${CKAN_INI}" "licenses_group_url = https://raw.githubusercontent.com/tum-gis/ckanext-grouphierarchy-sddi/main/ckanext/grouphierarchy/licenses_SDDI.json" && \
  ckan config-tool "${CKAN_INI}" "ckanext.password_policy.password_length = 12" && \
  ckan config-tool "${CKAN_INI}" "ckanext.password_policy.failed_logins = 3" && \
  ckan config-tool "${CKAN_INI}" "ckanext.password_policy.user_locked_time = 600" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.type = custom" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.custom.url = https://tile.openstreetmap.de/{z}/{x}/{y}.png" && \
  ckan config-tool "${CKAN_INI}" "ckanext.spatial.common_map.attribution = <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors." && \
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
