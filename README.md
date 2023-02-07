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

## :inbox_tray: Components

* `sddi-base`: CKAN base image with all extensions required for SDDI styling. Default SDDI groups,
  topics, and base organizations are preinstalled. This image is used as base image for the other images.

  ```text
  ghcr.io/tum-gis/ckan-sddi-base
  ```

* `sddi`: `sddi-base` + all required CKAN extensions to support SDDI.

  ```text
  ghcr.io/tum-gis/ckan-sddi
  ```

* `sddi-social`: `sddi` + optional CKAN extension for social media features, that may require staff
  for moderation of social media content.

  ```text
  ghcr.io/tum-gis/ckan-sddi-social
  ```

## :eye_speech_bubble: Requirements

## :question: Getting started

## :grey_exclamation: Requirements

## :rocket: Usage

## :book: Documentation

### Extensions used for SDDI

The catalog platform uses several extensions to provide the functionality needed for
the SDDI. Below is a list of all the used extensions.

| Extension | Description |
|-----|-------------|
| [Scheming](https://github.com/MarijaKnezevic/ckanext-scheming) | This extension provides a way to configure and share CKAN schemas using a JSON schema description. Custom template snippets for editing and display are also supported.|
| [GroupHierarchy and Hierarchy](https://github.com/ckan/ckanext-hierarchy) | This extension enables tree hierarchyof a organizations and groups.|
| [Datesearch](https://github.com/MarijaKnezevic/ckanext-datesearch) | Provides the ability to search for datasets according to a given time frame. The search includes all datasets, in which the time of validity overlaps in at least one second with the search time frame. |
| [UserAutoAddGroup](https://github.com/tum-gis/ckanext-userautoaddgroup-sddi) | New users are added automatically to the parent groups, which allows them to create datasets linked to these groups. Alls children groups are inherited from the parent groups.|
| [GeoView](https://github.com/pduchesne/ckanext-geoview) | This extension contains view plugins to display geospatial files and services in CKAN.|
| [Composite](https://github.com/EnviDat/ckanext-composite) | The extension allows to store structured dataset metadata, single or multiple fields. Only one level of subfields is possible. The subfields can be basic text, date type o choice dropboxes. |
| [Restricted](https://github.com/MarijaKnezevic/ckanext-restricted) | CKAN extension to restrict the accessibility to the resources of a dataset. This way the package metadata is accesible but not the data itself (resource). The resource access restriction level can be individualy defined for every package.|
| [Spatial](https://github.com/ckan/ckanext-spatials) | Provides the ability to search for datasets according to a given spatial extent.|
| [Repeating](https://github.com/MarijaKnezevic/ckanext-repeating) | This extension provides a way to store repeating fields in CKAN datasets, resources, organizations and groups.|
| [Disqus](https://github.com/ckan/ckanext-disqus) | The Disqus extension allows site visitors to comment on individual packages using an AJAX-based commenting system. The downsides of this plugin are that comments are not stored locally and user information is not shared between CKAN and the commenting system.|

## :hammer_and_wrench: Contributing

Bug fixes, issue reports and contributions are greatly appreciated.

### Contributors

<a href="https://github.com/tum-gis/ckan-docker/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tum-gis/ckan-docker" />
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
