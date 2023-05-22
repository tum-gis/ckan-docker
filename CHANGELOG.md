# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
For releases `< 1.0.0` minor version steps may indicate breaking changes too.

## [1.0.1] - 2023-05-22

### Changed

- Various extension updates and German translation.

### Fixed

- Various extension updates and fixing of styling bugs mentioned in the [Styling bugs](https://github.com/tum-gis/ckan-docker/issues/20) issue.

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

## [template] - YYYY-MM-DD

### Added

### Changed

### Removed

### Fixed

### Security

### Deprecated

### Known issues

## [Unreleased] - YYYY-MM-DD

### Added

### Changed

### Removed

### Fixed

### Security

### Deprecated

### Known issues

[Unreleased]: https://github.com/tum-gis/ckan-docker/compare/0.0.5...HEAD
[1.0.1]: https://github.com/tum-gis/ckan-docker/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/tum-gis/ckan-docker/compare/0.0.5...1.0.0
[0.0.5]: https://github.com/tum-gis/ckan-docker/compare/0.0.4...0.0.5
[0.0.4]: https://github.com/tum-gis/ckan-docker/compare/0.0.3...0.0.4
[0.0.3]: https://github.com/tum-gis/ckan-docker/compare/0.0.2...0.0.3
[0.0.2]: https://github.com/tum-gis/ckan-docker/compare/0.0.1...0.0.2
[0.0.1]: https://github.com/tum-gis/ckan-docker/releases/tag/0.0.1
[template]: https://keepachangelog.com/en/1.0.0/
