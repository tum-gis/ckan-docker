#!/usr/bin/env bash

echo "Create organizations ..."
ckan -c ${APP_DIR}/production.ini api action organization_create title='Technische Universität München (TUM)' name='technische-universitat-munchen'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Lehrstuhl für Geoinformatik' name='lehrstuhl-fur-geoinformatik' groups:'[{"capacity":"public","name":"technische-universitat-munchen"}]'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Bayerische Vermessungsverwaltung' name='bayerische-vermessungsverwaltung'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Bayern Innovativ' name='bayern-innovativ'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Themenplattform Digitales Planen und Bauen' name='themenplattform-digitales-planen-und-bauen' groups:'[{"capacity":"public","name":"bayern-innovativ"}]'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Themenplattform Smarte Städte und Regionen' name='themenplattform-smarte-stadte-und-regionen' groups:'[{"capacity":"public","name":"bayern-innovativ"}]'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Firmen' name='firmen'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Technologieanbieter' name='technologieanbieter'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Softwareanbieter' name='softwareanbieter' groups:'[{"capacity":"public","name":"technologieanbieter"}]'
ckan -c ${APP_DIR}/production.ini api action organization_create title='Hardwareentwickler' name='hardwareentwickler' groups:'[{"capacity":"public","name":"technologieanbieter"}]'
echo "Create organizations ...done!"
