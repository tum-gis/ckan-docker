<h1 align="center">SDDI CKAN Docker</h1>

<p align="center">
    <em>
    <a title="Smart District Data Infrastructure" href="https://www.asg.ed.tum.de/gis/projekte/sddi/">Smart District Data Infrastructure (SDDI)</a>
    enabled Docker images for
    <a title="ckan.org" href="https://ckan.org/">CKAN</a>
    </em>
    <br />
    <br />
    <a href="https://github.com/tum-gis/sddi-ckan-k8s/issues">Report Bug</a>
    ·
    <a href="https://github.com/tum-gis/sddi-ckan-k8s/issues">Request Feature</a>
    <br />
    <br />
    <a href="https://github.com/tum-gis/ckan-docker/releases" title="Latest release">
    <img src="https://img.shields.io/github/v/release/tum-gis/ckan-docker?logo=docker&sort=semver&style=for-the-badge">
  </a>
</p>

## :book: Table of content

- [:book: Table of content](#book-table-of-content)
- [:inbox\_tray: Images overview](#inbox_tray-images-overview)
- [:rocket: Usage](#rocket-usage)
- [:book: Configuration an documentation](#book-configuration-an-documentation)
  - [Extensions used for SDDI](#extensions-used-for-sddi)
- [:hammer\_and\_wrench: Contributing](#hammer_and_wrench-contributing)
  - [Contributors](#contributors)
- [:handshake: Thanks](#handshake-thanks)
- [:hammer\_and\_wrench: Build images](#hammer_and_wrench-build-images)

## :inbox_tray: Images overview

- `sddi-base`: CKAN base image with all extensions required for SDDI styling. Default SDDI groups,
  topics, and base organizations are preinstalled. This image is used as base image for the other images.

  ```text
  ghcr.io/tum-gis/ckan-sddi-base
  ```

- `sddi`: `sddi-base` + all required CKAN extensions to support SDDI.

  ```text
  ghcr.io/tum-gis/ckan-sddi
  ```

- `sddi-social`: `sddi` + optional CKAN extension for social media features, that may require staff
  for moderation of social media content.

  ```text
  ghcr.io/tum-gis/ckan-sddi-social
  ```

## :rocket: Usage

The images provided in this repo are designed for the
[`sddi-ckan-k8s`](https://github.com/tum-gis/sddi-ckan-k8s) Helm chart. Go to the Helm chart repository
to find examples an how to run the images.

## :book: Configuration an documentation

The configuration of the Docker images is mainly done using environment variables using the
naming convention of [`ckanext-envvars`](https://github.com/okfn/ckanext-envvars).
Refer to the documentation of [`ckan`](https://docs.ckan.org/en/latest/maintaining/configuration.html)
and the extensions listed below to find the available configuration options.

### Extensions used for SDDI

The catalog platform uses several extensions to provide the functionality needed for the SDDI concept.
The table below lists the extensions with the currently used version. The version refers either to a
*release version*, *commit hash* or *branch name* -> *commit hash*. Versions in the `Dockerfiles` are
alway pinned to a stable release or commit. The branch names are listed here for convenience.

| Extension                                                                      | Version                       |     `sddi-base`    |       `sddi`       |    `sddi-social`   | Description                                                                                                                                                                                                                                                         |
|--------------------------------------------------------------------------------|-------------------------------|:------------------:|:------------------:|:------------------:|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [`scheming`](https://github.com/ckan/ckanext-scheming)                         | `release-3.0.0`               | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Configure and share CKAN dataset metadata forms.                                                                                                                                                                                                                    |
| [`hierarchy`](https://github.com/ckan/ckanext-hierarchy)                       | `207e3d3`                     | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Allows to organize organizations and groups in a hierarchy tree (nested groups/orgs).                                                                                                                                                                               |
| [`grouphierarchysddi`](https://github.com/tum-gis/ckanext-grouphierarchy-sddi) | `spatial-search` -> `63289a8` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Extends `hierarchy` with pre-defined groups and topics of the SDDI concept.                                                                                                                                                                                         |
| [`relation`](https://github.com/tum-gis/ckanext-relation-sddi)                 | `ckan-2.9` -> `d62d814`       | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Enables to create and visualize different types of relations (*realated_to*, *depends_on*, *part_of*) between catalog entries.                                                                                                                                      |
| [`spatial`](https://github.com/ckan/ckanext-spatial)                           | `v2.0.0`                      | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Provides the ability to search for datasets according to a given spatial extent.                                                                                                                                                                                    |
| [`datesearch`](https://github.com/MarijaKnezevic/ckanext-datesearch)           |                               | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Provides the ability to search for datasets according to a given time frame. The search includes all datasets, in which the time of validity overlaps in at least one second with the search time frame.                                                            |
| [`dcat`](https://github.com/ckan/ckanext-dcat)                                 | `v1.4.0`                      |                    | :heavy_check_mark: | :heavy_check_mark: | Allow CKAN to expose and consume metadata from other catalogs using RDF documents serialized using DCAT.                                                                                                                                                            |
| [`geoview`](https://github.com/ckan/ckanext-geoview)                           | `v0.0.20`                     |                    |                    |                    | This extension contains view plugins to display geospatial files and services in CKAN.                                                                                                                                                                              |
| [`composite`](https://github.com/EnviDat/ckanext-composite)                    |                               |                    |                    |                    | The extension allows to store structured dataset metadata, single or multiple fields. Only one level of subfields is possible. The subfields can be basic text, date type or dropboxes.                                                                             |
| [`restricted`](https://github.com/MarijaKnezevic/ckanext-restricted)           |                               |                    |                    |                    | CKAN extension to restrict the accessibility to the resources of a dataset. This way the package metadata is accesible but not the data itself (resource). The resource access restriction level can be individualy defined for every package.                      |
| [`userautoaddgroup`](https://github.com/tum-gis/ckanext-userautoaddgroup-sddi) |                               |                    |                    |                    | New users are added automatically to the parent groups, which allows them to create datasets linked to these groups. Alls children groups are inherited from the parent groups.                                                                                     |
| [`repeating`](https://github.com/MarijaKnezevic/ckanext-repeating)             |                               |                    |                    |                    | This extension provides a way to store repeating fields in CKAN datasets, resources, organizations and groups.                                                                                                                                                      |
| [`disqus`](https://github.com/ckan/ckanext-disqus)                             |                               |                    |                    | :heavy_check_mark: | The Disqus extension allows site visitors to comment on individual packages using an AJAX-based commenting system. The downsides of this plugin are that comments are not stored locally and user information is not shared between CKAN and the commenting system. |

## :hammer_and_wrench: Contributing

Bug fixes, issue reports and contributions are greatly appreciated.

### Contributors

<a href="https://github.com/tum-gis/ckan-docker/graphs/contributors">
  <img height="40" src="https://contrib.rocks/image?repo=tum-gis/ckan-docker" />
</a>

## :handshake: Thanks

* This repo is based on the CKAN
  [Docker images](https://github.com/keitaroinc/docker-ckan) of
  [Keitaro](https://github.com/keitaroinc). Many thank's for your great work!

## :hammer_and_wrench: Build images

* Switch to the image folder, e.g. `cd sddi-base`
* Run `./build.sh` to the image. Run `./build.sh 2.9.7` to build* using
  a specific CKAN version.
* Use `./build-push.sh` to build and push the image.
