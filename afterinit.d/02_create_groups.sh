#!/usr/bin/env bash

echo "Create categories, and topics ..."
ckanapi batch -c "${APP_DIR}/production.ini" -I "$APP_DIR/docker-afterinit.d/groups.jsonl"
echo "Create categories, and topics ...done!"

# ckan -c ${APP_DIR}/production.ini api action group_create title='Hauptkategorien' name='main-categories'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Datensatz und Dokumente' name='dataset' image_url="$CKAN_SITE_URL/webassets/images/group_icons/dataset.jpg" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Online-Dienst' name='online-service' image_url="$CKAN_SITE_URL/webassets/images/group_icons/online_service.png" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Projekt' name='project' image_url="$CKAN_SITE_URL/webassets/images/group_icons/project.png" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Software' name='software' image_url="$CKAN_SITE_URL/webassets/images/group_icons/software.png" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Online-Anwendung' name='online-application' image_url="$CKAN_SITE_URL/webassets/images/group_icons/online_application.svg" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Methode' name='method' image_url="$CKAN_SITE_URL/webassets/images/group_icons/method.png" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Gerät / Ding' name='device' image_url="$CKAN_SITE_URL/webassets/images/group_icons/device.svg" groups:'[{"capacity":"public","name":"main-categories"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Geoobjekt' name='geoobject' image_url="$CKAN_SITE_URL/webassets/images/group_icons/geoobject.svg" groups:'[{"capacity":"public","name":"main-categories"}]'
#
# echo "Create themes ..."
# ckan -c ${APP_DIR}/production.ini api action group_create title='Themen' name='topics'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Verwaltung' name='administration' image_url="$CKAN_SITE_URL/webassets/images/group_icons/administration.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Stadtplanung' name='urban-planning' image_url="$CKAN_SITE_URL/webassets/images/group_icons/urban_planning.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Umwelt' name='environment' image_url="$CKAN_SITE_URL/webassets/images/group_icons/environment.png" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Gesundheit' name='health' image_url="$CKAN_SITE_URL/webassets/images/group_icons/health.png" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Energie' name='energy' image_url="$CKAN_SITE_URL/webassets/images/group_icons/energy.png" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Informations-Technologie' name='information-technology' image_url="$CKAN_SITE_URL/webassets/images/group_icons/it-technology.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Tourismus & Freizeit' name='tourism' image_url="$CKAN_SITE_URL/webassets/images/group_icons/tourism.png" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Wohnen' name='living' image_url="$CKAN_SITE_URL/webassets/images/group_icons/living.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Bildung' name='education' image_url="$CKAN_SITE_URL/webassets/images/group_icons/education.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Arbeiten' name='work' image_url="$CKAN_SITE_URL/webassets/images/group_icons/work.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Handel' name='trade' image_url="$CKAN_SITE_URL/webassets/images/group_icons/trade.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Bauen' name='construction' image_url="$CKAN_SITE_URL/webassets/images/group_icons/construction.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Kultur' name='culture' image_url="$CKAN_SITE_URL/webassets/images/group_icons/culture.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Mobilität' name='mobility' image_url="$CKAN_SITE_URL/webassets/images/group_icons/mobility.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Landwirtschaft' name='agriculture' image_url="$CKAN_SITE_URL/webassets/images/group_icons/agriculture.svg" groups:'[{"capacity":"public","name":"topics"}]'
# ckan -c ${APP_DIR}/production.ini api action group_create title='Gewerbe / Handwerk' name='craft' image_url="$CKAN_SITE_URL/webassets/images/group_icons/craft.svg" groups:'[{"capacity":"public","name":"topics"}]'
# echo "Create themes ...done!"
#
# ckan -c ${APP_DIR}/production.ini api batch
