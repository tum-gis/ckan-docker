ARG DATAPUSHER_VERSION=0.0.20
FROM ckan/ckan-base-datapusher:${DATAPUSHER_VERSION}

USER root

RUN set -ex && \
  apk add py3-psycopg2
  # pip3 install  --no-cache-dir psycopg2

USER ckan
