## :open_book: Table of content

This folder contains installation of SDDI CKAN with Docker Compose.

## :gear: Installation Instructions

To create the images, open the “Compose” folder, navigate to the relevant version and start the build process with ```docker compose up --d```

This start the following containers:

```
CONTAINER ID   IMAGE                               COMMAND                  CREATED         STATUS                     PORTS                    NAMES
ba43fed64815   sddi:1.0.0                          "/srv/app/start_ckan…"   5 minutes ago   Up 5 minutes (healthy)     0.0.0.0:5000->5000/tcp   ckan-sddi-ckan-1
6874ac3c5762   ckan/ckan-base-datapusher:0.0.20    "sh -c 'uwsgi --plug…"   5 minutes ago   Up 5 minutes (unhealthy)   8800/tcp                 datapusher
d1a0fa647d7a   sddi:1.0.0                          "/srv/app/start_ckan…"   5 minutes ago   Up 5 minutes (unhealthy)   5000/tcp                 ckan-sddi-sddi-1
0170a182863f   postgis/postgis:14-3.3-alpine       "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes (healthy)     0.0.0.0:5432->5432/tcp   db
b4e00abc75bc   ckan/ckan-solr:2.10-solr9-spatial   "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes (healthy)     8983/tcp                 solr
1feb1922e737   redis:6                             "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes (healthy)     6379/tcp                 redis
de45d9f92af7   sddi-base:1.0.0                     "/srv/app/start_ckan…"   5 minutes ago   Up 5 minutes (unhealthy)   5000/tcp                 ckan-sddi-sddi-base-1
```

CKAN should be running at `CKAN_SITE_URL=` [http://localhost:5000/](http://localhost:5000/).s
