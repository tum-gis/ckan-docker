<h1 align="center">SDDI CKAN Docker</h1>

<p align="center">
  <em>
  <a title="Smart District Data Infrastructure" href="https://www.asg.ed.tum.de/gis/projekte/sddi/">Smart District Data Infrastructure (SDDI)</a>
  enabled Docker images for
  <a title="ckan.org" href="https://ckan.org/">CKAN</a>
  </em>
  <br />
  <br />
  <a href="https://github.com/tum-gis/ckan-docker/issues/new/choose">Report Bug</a>
  ·
  <a href="https://github.com/tum-gis/ckan-docker/issues/new/choose">Request Feature</a>
  <br />
  <br />
  <a href="https://github.com/tum-gis/ckan-docker/releases" title="Latest release">
    <img src="https://img.shields.io/github/v/release/tum-gis/ckan-docker?sort=semver&logo=docker">
  </a>
  <br />
  </a>
  <a href="https://github.com/tum-gis/ckan-docker/actions/workflows/release.yml">
    <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/tum-gis/ckan-docker/release.yml?label=build: release">
  </a>
  <a href="https://github.com/tum-gis/ckan-docker/actions/workflows/edge.yml">
    <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/tum-gis/ckan-docker/edge.yml?label=build: edge">
  </a>
  </a>
  <a href="https://github.com/tum-gis/ckan-docker/actions/workflows/devel.yml">
    <img alt="GitHub Workflow Status" src="https://img.shields.io/github/actions/workflow/status/tum-gis/ckan-docker/devel.yml?label=build: devel">
  </a>
  <br />
  <a href="https://doi.org/10.5281/zenodo.7784078">
    <img src="https://zenodo.org/badge/DOI/10.5281/zenodo.7784078.svg" alt="DOI" />
  </a>
</p>

This repository provides [CKAN](https://github.com/ckan) Docker images for the
[`sddi-ckan-k8s`](https://github.com/tum-gis/sddi-ckan-k8s) Helm chart.
The images contain CKAN itself compiled with a set of CKAN extension to add functionality required for
the SDDI concept and beyond that.
All images are available form `ghcr.io/tum-gis` Github container registry.
See [packages](https://github.com/orgs/tum-gis/packages?repo_name=ckan-docker) for all image flavors and tags.

## :book: Table of content

- [:book: Table of content](#book-table-of-content)
- [:inbox\_tray: Image flavor overview](#inbox_tray-image-flavor-overview)
  - [`sddi-base`](#sddi-base)
  - [`sddi`](#sddi)
- [:1234: Image versioning](#1234-image-versioning)
  - [Development image versions](#development-image-versions)
  - [CKAN and CKAN extension versions](#ckan-and-ckan-extension-versions)
- [:rocket: Usage](#rocket-usage)
- [:book: Configuration an documentation](#book-configuration-an-documentation)
- [:hammer\_and\_wrench: Contributing](#hammer_and_wrench-contributing)
  - [Contributors](#contributors)
    - [Github contributors to this repo](#github-contributors-to-this-repo)
- [:mortar\_board: Research](#mortar_board-research)
  - [Publications](#publications)
  - [Cite this repository](#cite-this-repository)
- [:handshake: Thanks](#handshake-thanks)
- [:memo: License](#memo-license)

## :inbox_tray: Image flavor overview

The CKAN-SDDI Docker images are released in three flavors, that are described below.
For each flavor a one [package](https://github.com/orgs/tum-gis/packages?repo_name=ckan-docker)
exists in this repository, where the image can be pulled.

```bash
docker pull ghcr.io/tum-gis/ckan-sddi-base
docker pull ghcr.io/tum-gis/ckan-sddi

```

### `sddi-base`

CKAN base image with a minimal set of extensions required for SDDI.
Default SDDI groups and topics are preinstalled.
This image is used as base image for the other images. If you plan to extend the SDDI images,
use this as base image.

```text
ghcr.io/tum-gis/ckan-sddi-base
```

### `sddi`

`sddi-base` + commonly used CKAN extensions for e.g. extended data format and preview support.
This is the image most people will usually want.

```text
ghcr.io/tum-gis/ckan-sddi
```

## :1234: Image versioning

The images in this repo are versioned and tagged according to the
[releases](https://github.com/tum-gis/ckan-docker/releases) of this repository.
The `latest` tag points to the latest release number. The `edge` version is built from the
latest commit to the `main` branch of this repo.

All available tags are listed in the packages of each image:

- [`sddi-base`](https://github.com/tum-gis/ckan-docker/pkgs/container/ckan-sddi-base)
- [`sddi`](https://github.com/tum-gis/ckan-docker/pkgs/container/ckan-sddi)

### Development image versions

For development purposes the `devel` images, which are build from the latest commit to the `devel` branch are published.
The `devel` images are used for testing and may contain errors.
The CKAN and CKAN extension versions used for each image are listed in the table below.

For debugging we provide a *debug* version for each image version.
These images are indicated by the `-debug` suffix on the image tag, e.g. `latest-debug`, `0.0.6-debug`, `edge-debug` or `devel-debug`.
The debug images have the FLASK debug toolbar enabled and all required debugging dependencies installed.
Read more on CKAN's debug mode in the
[official docs](https://docs.ckan.org/en/latest/maintaining/configuration.html#debug).
Debug images are available starting from `v0.0.6`.

> **Warning**: The debug image versions should not be used in a production environment!
> With debug mode enabled, a visitor to your site could execute malicious commands.

Furthermore, for each commit to a [Pull request](https://github.com/tum-gis/ckan-docker/pulls) all image flavors are build.
These images are published in the
[`ckan-sddi-dev`](https://github.com/orgs/tum-gis/packages/container/package/ckan-sddi-dev)
package. Images are named following this pattern:

`ghcr.io/tum-gis/ckan-sddi-dev:<IMAGE FLAVOR>-pr-<PR NUMBER>-[-debug]`
`ghcr.io/tum-gis/ckan-sddi-dev:<IMAGE FLAVOR>-pr-<PR NUMBER>-<SHORT-SHA>[-debug]`

The image without the `SHORT-SHA` refer to the *latest* build of a pull request.

For instance, for commit 19a2e64 to PR tum-gis/ckan-docker#26 following images are build:

- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-base-pr-26`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-base-pr-26-debug`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-base-pr-26-19a2e64`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-base-pr-26-19a2e64-debug`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-pr-26`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-pr-26-debug`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-pr-26-19a2e64`
- `ghcr.io/tum-gis/ckan-sddi-dev:sddi-pr-26-19a2e64-debug`

This registry will be cleared periodically.

### CKAN and CKAN extension versions

CKAN version: `2.11.2`
CKAN base image: `ckan/ckan-base:2.11.2`

The CKAN catalog platform uses several extensions to provide the functionality
needed for the SDDI concept. The table below lists the included extensions with
the currently used version. Depending of the version of the upstream repository
of the individual extensions, the version refers either to a *release version*
or *commit hash*.

To ensure stable versioning for the images, the versions in the `Dockerfiles`
are alway pinned to a stable release number or commit hash.

> **Note:** Version pinning is only applied for release versions. The `edge`
> image may depend on upstream branches instead.

| Extension | Version | `sddi-base` |`sddi` | Description |
|---|---|:---:|:---:|:---|
| [`ckanext-hierarchy`](https://github.com/ckan/ckanext-hierarchy ) | `v1.2.2` | :heavy_check_mark: | :heavy_check_mark: | Allows to organize organizations and groups in a hierarchy tree (nested groups/orgs). |
| [`ckanext-scheming` ](https://github.com/ckan/ckanext-scheming ) | `27035f4` |:heavy_check_mark: | :heavy_check_mark: |  Configure and share CKAN dataset metadata forms. |
| [`ckanext-geoview` ](https://github.com/ckan/ckanext-geoview) | `v0.2.2` |:heavy_check_mark: |:heavy_check_mark: |  Configure and share CKAN dataset metadata forms. |
| [`ckanext-clamav` ](https://github.com/mutantsan/ckanext-clamav) | `a1d23ac` |:heavy_check_mark: | :heavy_check_mark: |CKAN extension that integrates ClamAV antivirus scanning to ensure the security of uploaded files by automatically checking them for malware.|
| [`ckanext-dcat` ](https://github.com/ckan/ckanext-dcat ) | `v1.5.1` |:heavy_check_mark: | :heavy_check_mark: |Allow CKAN to expose and consume metadata from other catalogs using RDF documents serialized using DCAT.|
| [`ckanext-relation-sddi`](https://github.com/tum-gis/ckanext-relation-sddi ) | `1.1.2` | | :heavy_check_mark: | Enables to create and visualize different types of relations (*realated_to*, *depends_on*, *part_of*) between catalog entries. |
| [`ckanext-datesearch`](https://github.com/MarijaKnezevic/ckanext-datesearch) | `1.1.0`|| :heavy_check_mark: | Provides the ability to search for datasets according to a given time frame. The search includes all datasets, in which the time of validity overlaps in at least one second with the search time frame. |
| [`ckanext-spatial`](https://github.com/ckan/ckanext-spatial) | `v2.3.0` | |:heavy_check_mark: | Enables geospatial capabilities to CKAN instance. |
| [`ckanext-scheme-sddi`](https://github.com/MarijaKnezevic/ckanext-scheme-sddi) | `0.0.1` || :heavy_check_mark: | This plugin is extending CKAN schema definition, validation, and custom field support accordingly to SDDI needs. |
| [`ckanext-theme-sddi`](https://github.com/MarijaKnezevic/ckanext-theme-sddi) | `0.0.4` | |:heavy_check_mark: | This plugin is customizing the look of SDDI CKAN instance with theme management capabilities for improved branding and user needs.|
| [`ckanext-security` ](https://github.com/MarijaKnezevic/ckanext-security) | `0.0.1` || :heavy_check_mark: | CKAN extension that enhances data access control. In the SDDI context, context is used to define the maximum number of failed logon attempts and to automatically log off after a period of inactivity.|
| [`ckanext-heroslideradmin` ](https://github.com/dathere/ckanext-heroslideradmin) | `4b60e00` | |:heavy_check_mark: |  CKAN extension that enables the management of a hero slider on your CKAN site, allowing for dynamic display of featured content and improved visual engagement.|

## :rocket: Usage

The images provided in this repo are designed for the
[`sddi-ckan-k8s`](https://github.com/tum-gis/sddi-ckan-k8s) Helm chart. Go to the Helm chart repository
to find examples an how to run the images.

## :book: Configuration an documentation

The configuration of the Docker images is mainly done using environment variables using the
naming convention of [`ckanext-envvars`](https://github.com/okfn/ckanext-envvars).
Refer to the documentation of [`ckan`](https://docs.ckan.org/en/latest/maintaining/configuration.html)
and the extensions listed below to find the available configuration options.

## :hammer_and_wrench: Contributing

Bug fixes, issue reports and contributions are greatly appreciated.

### Contributors

[Marija Knezevic](https://www.asg.ed.tum.de/en/gis/our-team/staff/marija-knezevic/) and
[Bruno Willenborg](https://www.asg.ed.tum.de/en/gis/our-team/staff/bruno-willenborg/)
at Technical University of Munich, Chair of Geoinformatics
realized the current SDDI CKAN [Docker images](https://github.com/tum-gis/ckan-docker)
and [Helm chart](https://github.com/tum-gis/sddi-ckan-k8s) and updated the
CKAN SDDI extensions ([ckanext-grouphierarchy](https://github.com/tum-gis/ckanext-grouphierarchy-sddi),
[ckanext-relation](https://github.com/tum-gis/ckanext-relation-sddi)) initially implemented by
[Mandana Moshrefzadeh](https://www.linkedin.com/in/mandana-moshrefzadeh-a4666454)
and [Wolfgang Deigele](https://www.linkedin.com/in/wolfgang-deigele-329673189).

The core concepts, documentation, and [initial implementation](https://github.com/tum-gis/SDDI-CKAN-Docker)
for SDDI were realized at Technical University of Munich, Chair of Geoinformatics by:

- [Mandana Moshrefzadeh](https://www.linkedin.com/in/mandana-moshrefzadeh-a4666454): Landeshauptstadt München, Kommunalreferat – GeodatenService
- [Prof. Thomas H. Kolbe](https://www.asg.ed.tum.de/gis/unser-team/lehrstuhlangehoerige/prof-thomas-h-kolbe/):
  Technical University of Munich, Chair of Geoinformatics
- [Dr. Andreas Donaubauer](https://www.asg.ed.tum.de/gis/unser-team/lehrstuhlangehoerige/dr-andreas-donaubauer/):
  Technical University of Munich, Chair of Geoinformatics
- [Marija Knezevic](https://www.asg.ed.tum.de/gis/unser-team/lehrstuhlangehoerige/marija-knezevic/):
  Technical University of Munich, Chair of Geoinformatics
- [Bruno Willenborg](https://www.asg.ed.tum.de/gis/unser-team/lehrstuhlangehoerige/bruno-willenborg/):
  Technical University of Munich, Chair of Geoinformatics
- [Kanishk Chaturvedi](https://www.linkedin.com/in/dr-kanishk-chaturvedi), Software AG
- [Son H. Nguyen](https://www.asg.ed.tum.de/en/gis/our-team/staff/son-h-nguyen/), Technical University of Munich, Chair of Geoinformatics
- [Wolfgang Deigele](https://www.linkedin.com/in/wolfgang-deigele-329673189), ESRI Deutschland

<p align="center" height="100" line-height="100">
  <a href="https://www.asg.ed.tum.de/gis/startseite/" target="_blank">
    <img src="https://github.com/tum-gis/ckan-docker/blob/main/docs/img/tum_logo_h50.png"
    alt="Technical University of Munich, Chair of Geoinformatics" height="50"/>
  </a>
</p>

#### Github contributors to this repo

<a href="https://github.com/tum-gis/ckan-docker/graphs/contributors">
  <img height="40" src="https://contrib.rocks/image?repo=tum-gis/ckan-docker" />
</a>

## :mortar_board: Research

An overview of the Smart District Data Infrastructure (SDDI) Project is available
at the Chair of Geoinformatics, Technical University of Munich
[homepage](https://www.asg.ed.tum.de/gis)
in [english](https://www.asg.ed.tum.de/en/gis/projects/smart-district-data-infrastructure/)
and [german](https://www.asg.ed.tum.de/gis/projekte/sddi/).

### Publications

The full list of SDDI related publications is available
[here](https://www.asg.ed.tum.de/gis/projekte/sddi/#c11942). Some key publications
are listed below:

- [**Knezevic et al. (2022)**](https://mediatum.ub.tum.de/node?id=1689713):
  *Managing Urban Digital Twins with an Extended Catalog Service*,
  Proceedings of the 7th International Smart Data and Smart Cities (SDSC) Conference 2022, ISPRS Annals of Photogrammetry, Remote Sensing and Spatial Information Sciences,
  [PDF download / DOI](https://doi.org/10.5194/isprs-annals-X-4-W3-2022-119-2022).

- [**Deigele, W. et al. (2021)**](https://mediatum.ub.tum.de/node?id=1684529):
  *Leitfaden – Geobasierter Digitaler Zwilling nach der SDDI-Methode*,
  Ed.: Bayern Innovativ, ZD.B – Themenplattform Smart Cities and Regions.

- [**Gackstetter, D. et al. (2021)**](https://mediatum.ub.tum.de/node?id=1636657):
  *Smart Rural Areas Data Infrastructure (SRADI) – an information logistics framework for digital agriculture based on open standards*,
  41. GIL-Jahrestagung 2021 - Fokus: Informations- und Kommunikationstechnologie in kritischen Zeiten, Gesellschaft für Informatik e.V. (GI), [PDF download / DOI](https://dl.gi.de/bitstream/handle/20.500.12116/35656/GIL2021_Gackstetter_109-114.pdf?sequence=1&isAllowed=y).

- [**Kolbe, T. H. et al. (2020)**](https://mediatum.ub.tum.de/node?id=1554725):
  *The Data Integration Challenge in Smart City Projects*,
  Chair of Geoinformatics, Technical University of Munich,
  [PDF download / DOI](https://mediatum.ub.tum.de/doc/1554725/671062.pdf).

- [**Moshrefzadeh, M. et al. (2020)**](https://mediatum.ub.tum.de/node?id=1540127):
  *Towards a Distributed Digital Twin of the Agricultural Landscape*,
  Journal of Digital Landscape Architecture (5),
  [PDF download / DOI](https://gispoint.de/fileadmin/user_upload/paper_gis_open/DLA_2020/537690019.pdf).

- [**Moshrefzadeh, M. et al. (2017)**](https://mediatum.ub.tum.de/node?id=1350813):
  *Integrating and Managing the Information for Smart Sustainable Districts - The Smart District Data Infrastructure (SDDI)*,
  In: Kolbe, Thomas H.; Bill, Ralf; Donaubauer, Andreas (Hrsg.): Geoinformationssysteme 2017 – Beiträge zur 4. Münchner GI-Runde. . Wichmann Verlag,
  [PDF download / DOI](https://mediatum.ub.tum.de/download/1350813/1350813.pdf).

- [**Moshrefzadeh, M. and T.H. Kolbe (2016)**](https://mediatum.ub.tum.de/node?id=1304877):
  *Smart Data Infrastructure for Smart and Sustainable Cities*,
  DDSS 2016,
  [PDF download / DOI](https://mediatum.ub.tum.de/doc/1304877/797209.pdf).

### Cite this repository

To cite this repository, please use the DOI provided by [Zenodo](https://zenodo.org).
If you want to reference a specific release version of the software, click the badge
and navigate to the desired version on the page.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7784078.svg?style=flat-square)](https://doi.org/10.5281/zenodo.7784078)

## :handshake: Thanks

We would like to thank following institutions and persons for their contributions
to the SDDI concepts, tools, documentations, education, and funding:

- [ZD.B-Themenplattform Smart Cities and Regions](https://www.bayern-innovativ.de/de/netzwerke-und-thinknet/uebersicht-digitalisierung/digitales-planen-und-bauen-smart-cities-and-regions/seite/zd-b-themenplattform-smart-cities-and-regions):
  Willi Steincke at [Bayern Innovativ GmbH](https://www.bayern-innovativ.de/de?gclid=Cj0KCQjwk7ugBhDIARIsAGuvgPZkLiU4AhX1Xz-07vLIt0vpixwjF1wCrHau3PkGEMyl2ZoU_pn1hPMaAnALEALw_wcB)
  und [Lutz Morich](https://www.linkedin.com/in/lutz-morich-in), for funding and supporting the SDDI development for several years.

- [Bayerisches Staatsministerium für Digitales](https://www.stmd.bayern.de/) for funding the
  [project TwinBy](https://twinby.bayern) and Stefan Bobinger for many contributions to SDDI concepts and documentation.

- [Digital Twin Munich / Digitaler Zwilling München](https://muenchen.digital/twin/),
  [Connected Urban Twins (CUT) research project](https://www.connectedurbantwins.de/en/),
  [SAVeNoW research project](https://savenow.de/en/),
  [eit Climate-KIC](https://www.climate-kic.org/) (SDDI research project)
  for funding the work on SDDI concepts and implementation.

- [Tome Petrovski](https://github.com/TomeCirun), [Konstantin Sivakov](https://github.com/tino097), [Ilche Bedelovski](https://github.com/ilchebedelovski) and [Aleksandra Lazoroska](https://github.com/aleksandralazoroska):raised_hands: for professional support with CKAN and CKAN extension development.

- [KEITARO](https://www.keitaro.com/) for their [CKAN Docker images](https://github.com/keitaroinc/docker-ckan)
  and [CKAN Helm chart](https://github.com/keitaroinc/ckan-helm) that inspired this work.

<p align="center" height="100" line-height="100">
  <a href="https://twinby.bayern" target="_blank">
    <img src="https://github.com/tum-gis/ckan-docker/blob/main/docs/img/twinBy_logo_h50.png"
    alt="TwinBy" height="50"/>
  </a>
  <br />
  <br />
  <a href="https://www.stmd.bayern.de" target="_blank">
    <img src="https://github.com/tum-gis/ckan-docker/blob/main/docs/img/bsd_logo_h50.png"
    alt="Bayerische Staatsministerium für Digitales" height="50" />
  </a>
  <br />
  <br />
  <a href="https://www.bayern-innovativ.de" target="_blank">
    <img src="https://github.com/tum-gis/ckan-docker/blob/main/docs/img/bayernInnovativ_logo_h50.png"
    alt="Bayern Innovativ GmbH" height="50"/>
  </a>
</p>

## :memo: License

This Helm chart is distributed under the Apache License 2.0. See [LICENSE](LICENSE) for more information.
