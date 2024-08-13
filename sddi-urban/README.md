<h1 align="center">SDDI CKAN Docker, additional image sddi-urban</h1>

This directory provides an additional [CKAN](https://github.com/ckan) Docker image for the
[`sddi-ckan-k8s`](https://github.com/tum-gis/sddi-ckan-k8s) Helm chart.
The images contain CKAN itself compiled with a set of CKAN extension to add functionality required for
the SDDI concept and beyond that.

## :book: Table of content

- [:book: Table of content](#book-table-of-content)
- [:inbox\_tray: Image flavor overview](#inbox_tray-image-flavor-overview)
  - [`sddi-urban`](#sddi-urban)
- [:1234: Image versioning](#1234-image-versioning)
  - [CKAN and CKAN extension versions](#ckan-and-ckan-extension-versions)
- [:rocket: Usage](#rocket-usage)
- [:book: Configuration an documentation](#book-configuration-an-documentation)
- [:hammer\_and\_wrench: Contributing](#hammer_and_wrench-contributing)

## :inbox_tray: Image flavor overview

The CKAN-SDDI Docker images are originally released in different flavors, that are described in the 
[Readme](https://github.com/tum-gis/sddi-ckan-k8s). With `sddi-base`, another flavor is added. 
For each flavor a one [package](https://github.com/orgs/tum-gis/packages?repo_name=ckan-docker)
exists in this repository, where the image can be pulled.

```bash
docker pull ghcr.io/tum-gis/ckan-sddi-urban

```

### `sddi-urban`

`sddi-base` + some CKAN extensions for extended data and resource preview and description options,
extended import-/ export, harvesting, and security support. Some extensions from `sddi-base`
are installed but deactivated. These could be easily reactivated by including them into the
plugin list in ckan configuration.
This image also includes a slightly different set of preinstalled SDDI groups and topics as
well as the option of custom theming and custom metadata schemas, inspired by the requirements
of Landeshauptstadt München (LHM).

```text
ghcr.io/tum-gis/ckan-sddi-urban
```

## :1234: Image versioning

The images in this repo are versioned and tagged according to the
[releases](https://github.com/tum-gis/ckan-docker/releases) of this repository.
The `latest` tag points to the latest release number. The `edge` version is built from the
latest commit to the `main` branch of this repo.

All available tags are listed in the packages of each image:

- [`sddi-urban`](https://github.com/tum-gis/ckan-docker/pkgs/container/ckan-sddi-urban)

### CKAN and CKAN extension versions

CKAN version: `2.9.9`
CKAN base image: `ghcr.io/keitaroinc/ckan:2.9.9-focal`

The CKAN catalog platform uses several extensions to provide the functionality
needed for the SDDI concept. The table below lists the included extensions with
the currently used version. Depending of the version of the upstream repository
of the individual extensions, the version refers either to a *release version*
or *commit hash*.

To ensure stable versioning for the images, the versions in the `Dockerfiles`
are alway pinned to a stable release number or commit hash.

> **Note:** Version pinning is only applied for release versions. The `edge`
> image may depend on upstream branches instead.

| Extension | Version | `sddi-base` | `sddi` | `sddi-social` | `sddi-urban` | Description |
|---|---|:---:|:---:|:---:|:---:|---|
| [`scheming`](https://github.com/MarijaKnezevic/ckanext-scheming), [`scheming (sddi-urban)`](https://github.com/gislab-augsburg/ckanext-scheming) | `f98daec`, `a7fdd9c`| :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Configure and share CKAN dataset metadata forms. |
| [`hierarchy`](https://github.com/ckan/ckanext-hierarchy) | `v1.2.0` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Allows to organize organizations and groups in a hierarchy tree (nested groups/orgs). |
| [`grouphierarchysddi`](https://github.com/tum-gis/ckanext-grouphierarchy-sddi) |  `1.1.3` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  | Extends `hierarchy` with pre-defined groups and topics of the SDDI concept. |
| [`relation`](https://github.com/tum-gis/ckanext-relation-sddi) | `1.0.3` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  | Enables to create and visualize different types of relations (*realated_to*, *depends_on*, *part_of*) between catalog entries. |
| [`spatial`](https://github.com/MarijaKnezevic/ckanext-spatial) | `c2118b9` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | Provides the ability to search for datasets according to a given spatial extent. |
| [`datesearch`](https://github.com/MarijaKnezevic/ckanext-datesearch) | `1.0.2` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  | Provides the ability to search for datasets according to a given time frame. The search includes all datasets, in which the time of validity overlaps in at least one second with the search time frame. |
| [`repeating`](https://github.com/MarijaKnezevic/ckanext-repeating) | `1.0.0` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |  | This extension provides a way to store repeating fields in CKAN datasets, resources, organizations and groups. |
| [`composite`](https://github.com/EnviDat/ckanext-composite) | `1e6d7bb` | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | The extension allows to store structured dataset metadata, single or multiple fields. Only one level of subfields is possible. The subfields can be basic text, date type or dropboxes. |
| [`restricted`](https://github.com/MarijaKnezevic/ckanext-restricted) | `1.0.0` |  | :heavy_check_mark: | :heavy_check_mark: |  | CKAN extension to restrict the accessibility to the resources of a dataset. This way the package metadata is accesible but not the data itself (resource). The resource access restriction level can be individualy defined for every package. |
| [`dcat`](https://github.com/ckan/ckanext-dcat) | `v1.4.0` |  | :heavy_check_mark: | :heavy_check_mark: |  | Allow CKAN to expose and consume metadata from other catalogs using RDF documents serialized using DCAT. |
| [`geoview`](https://github.com/ckan/ckanext-geoview) | `v0.0.20` |  | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | This extension contains view plugins to display geospatial files and services in CKAN. |
| [`disqus`](https://github.com/ckan/ckanext-disqus) |  |  |  | :heavy_check_mark: |  | The Disqus extension allows site visitors to comment on individual packages using an AJAX-based commenting system. The downsides of this plugin are that comments are not stored locally and user information is not shared between CKAN and the commenting system. |
| [`password_policy`](https://github.com/keitaroinc/ckanext-password-policy) | `5618dc9`|:heavy_check_mark:  |:heavy_check_mark:| :heavy_check_mark: | :heavy_check_mark: | CKAN extension that adds password policy for all the users. |
| [`resourcedictionary`](https://github.com/keitaroinc/ckanext-resourcedictionary) | `v1.0.0` |  |  |  | :heavy_check_mark: | Extends the default CKAN Data Dictionary functionality by adding possibility to create data dictionary before actual data is uploaded to datastore.  |
| [`xloader`](https://github.com/ckan/ckanext-xloader) | `1.0.1` |  |  |  | :heavy_check_mark: | Provides a faster and more robust way to load data into CKAN's DataStore. |
| [`lhm`](https://github.com/MandanaMoshref/ckanext-lhm) | `d258e1f` |  |  |  | :heavy_check_mark: | Adds options for a custom metadata schema, custom theming and an adapted set of groups and topics, provided by Landeshauptstadt München (LHM).  |
| [`harvest`](https://github.com/ckan/ckanext-harvest) | `v1.5.6` |  |  |  | :heavy_check_mark: | Provides a framework and management tools for automatic harvesting of other metatdata catalogs. |
| [`glab`](https://github.com/gislab-augsburg/ckanext-glab/tree/gdpr) | `0612d22` |  |  |  | :heavy_check_mark: | Adds extended security and GDPR features. |
| [`iso`](https://github.com/gislab-augsburg/ckanext-iso) | `c4c28a8` |  |  |  | :heavy_check_mark: | Adapts csw harvester from ckanext-spatial to requirements for harvesting LHM Geoportal. |


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
