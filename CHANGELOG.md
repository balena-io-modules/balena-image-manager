# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [3.1.2] - 2015-08-25

### Changed

- Upgrade Resin SDK to v2.6.1.

## [3.1.1] - 2015-08-24

### Changed

- Fix issue that caused the client to not receive any stream data if reading after a slight timeout.
- Fix issue that prevented stream `length` property to be propagated to the client.

## [3.1.0] - 2015-08-21

### Added

- Correctly mock os parameters for different device types.

### Changed

- Fix issue when piping the same stream to both the cache and the client .
- Upgrade Resin SDK to v2.4.1.
- Fix unit tests failing because of unmocked `GET /whoami` endpoint.

## [3.0.0] - 2015-07-01

### Added

- Implement `manager.cleanCache()`.
- Read settings from `resin-settings-client`.

### Changed

- Implement `manager.get()` using streams.
- Improve documentation

### Removed

- Remove `manager.configure()`.

## [2.0.0] - 2015-06-05

### Changed

- Upgrade resin-config-inject to v3.0.0, which reads/writes to FAT partitions.

## [1.1.0] - 2015-05-20

### Added

- Implement manager.configure().

[3.1.2]: https://github.com/resin-io/resin-image-manager/compare/v3.1.1...v3.1.2
[3.1.1]: https://github.com/resin-io/resin-image-manager/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/resin-io/resin-image-manager/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/resin-io/resin-image-manager/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/resin-io/resin-image-manager/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/resin-io/resin-image-manager/compare/v1.0.0...v1.1.0
