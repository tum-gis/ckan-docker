# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
For releases `< 1.0.0` minor version steps may indicate breaking changes too.

## [1.1.3] - 2023-08-03

### Fixed

-  upstream bugfix from [ckanext-grouphierarchy-sddi](https://github.com/tum-gis/ckanext-grouphierarchy-sddi) extension tum-gis/ckanext-grouphierarchy-sddi#17
    - Default filter "read" for searching datasets by Main Categories/Topics is removed.
-  [Extended licenses list](https://github.com/tum-gis/ckanext-grouphierarchy-sddi/blob/main/ckanext/grouphierarchy/licenses_SDDI.json) required for SDDI is added in upstream repo [ckanext-grouphierarchy-sddi](https://github.com/tum-gis/ckanext-grouphierarchy-sddi)

## [1.1.2] - 2023-07-24

### Added

- Bump tum-gis/ckanext-relation-sddi: `1.0.1` -> `1.0.2`
  - Option to remove an already created resource has been added. tum-gis/ckanext-relation-sddi#10

## [1.1.1] - 2023-07-06

### Fixed

- upstream bugfix from [ckanext-grouphierarchy-sddi](https://github.com/tum-gis/ckanext-grouphierarchy-sddi) extension. Fixed upload of images from from local source. tum-gis/ckanext-grouphierarchy-sddi#11
- upstream bugfix in [ckanext-relation-sddi](https://github.com/tum-gis/ckanext-relation-sddi) extension.
  Color labels of main categories synchronized with their graphic representation.
  tum-gis/ckanext-relation-sddi#7,
  tum-gis/ckanext-relation-sddi#8

## [1.1.0] - 2023-06-28

### Added

- Improvements in personalization via variables. Default groups and organizations have been added. See tum-gis/ckan-docker#23
- Via variables it is now possible to: *define Background image*, *define intro text*, *define text below intro text*
- The administrator can also change background image, intro text and text below intro text in the user interface in the "Systemadmin-settings" dialog in the running instance.

## Changed

- Update to CKAN `2.9.8`

### Fixed

- Fixed inconsistent base image and build image versions

## [1.0.1] - 2023-05-22

### Changed

- Various extension updates and German translation.

### Fixed

- Various extension updates and fixing of styling bugs mentioned in the #20 issue.

## [1.0.0] - 2023-04-28

### Added

- Added *debug* images with CKAN FLASK Debug Toolbar enabled, see
  [here](https://github.com/tum-gis/ckan-docker#1234-image-versioning)

- Added *devel* images built form latest commit to `devel` branch.
- Various docs additions.
- Added Zenodo DOI.

### Changed

- Various extension updates.

## [0.0.5] - 2023-03-30

**Note: This is a testing release that might contain errors. Do not use this
for production environments.**

### Added

- Added [`ckanext-dcat`](https://extensions.ckan.org/extension/dcat/)
- Added [`ckanext-spatial`](https://github.com/ckan/ckanext-spatial)
- Added `CKAN_INI` env var for CKAN config.ini file path for better compatibility with
  official CKAN images
- Set timezone using `TZ` env var
- Allow setting runtime base image with ` BASEIMAGE_REPOSITORY` build arg

### Changed

- Use official CKAN images for build stage
- Update Update OCI specs image labels
- Various docs updates

### Removed

- Dropped outdated build scripts

### Fixed

- Several smaller fixes
- Fixed CKAN extension loading order

### Security

### Deprecated

## [0.0.4] - 2023-03-02

### Changed

- Latest fixes from
  [tum-gis/ckanext-grouphierarchy-sddi](https://github.com/tum-gis/ckanext-grouphierarchy-sddi)
  and [tum-gis/ckanext-relation-sddi](https://github.com/tum-gis/ckanext-relation-sddi) included.

## [0.0.3] - 2023-03-02

### Added

- Workflow to build `edge` images from latest commit to `main` branch

### Changed

- Adapt `sddi-base` Dockerfile for new extensions

## [0.0.2] - 2023-02-09

### Fixed

- Fixed SDDI group installation, revert #dd043571b634e881689f0ad8d8dc86013016a3f6.

## [0.0.1] - 2023-02-08

- Initial release to initialize Github packages.
- **Images are not functional jet**!

## [Unreleased] - YYYY-MM-DD

### Added

### Changed

### Removed

### Fixed

### Security

### Deprecated

### Known issues

## [template] - YYYY-MM-DD

### Added

### Changed

### Removed

### Fixed

### Security

### Deprecated

### Known issues

[Unreleased]: https://github.com/tum-gis/ckan-docker/compare/1.1.2...HEAD
[1.1.3]: https://github.com/tum-gis/ckan-docker/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/tum-gis/ckan-docker/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/tum-gis/ckan-docker/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/tum-gis/ckan-docker/compare/1.0.1...1.1.0
[1.0.1]: https://github.com/tum-gis/ckan-docker/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/tum-gis/ckan-docker/compare/0.0.5...1.0.0
[0.0.5]: https://github.com/tum-gis/ckan-docker/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/tum-gis/ckan-docker/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/tum-gis/ckan-docker/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/tum-gis/ckan-docker/compare/0.0.1...0.0.2
[0.0.1]: https://github.com/tum-gis/ckan-docker/releases/tag/0.0.1
[template]: https://keepachangelog.com/en/1.0.0/
