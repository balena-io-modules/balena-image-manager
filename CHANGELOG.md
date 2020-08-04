# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [5.0.0] - 2017-10-17

## 7.0.3 - 2020-08-04

* Add .versionbot/CHANGELOG.yml for nested changelogs [Pagan Gazzard]

## 7.0.2 - 2020-08-04


<details>
<summary> Update balena-sdk to 15.x [Pagan Gazzard] </summary>

> ### balena-sdk-15.2.1 - 2020-08-03
> 
> * Convert majority to async/await [Pagan Gazzard]
> 
> ### balena-sdk-15.2.0 - 2020-07-31
> 
> * device: add method to update target supervisor release [Matthew McGinn]
> 
> ### balena-sdk-15.1.1 - 2020-07-27
> 
> * Deduplicate device update methods [Pagan Gazzard]
> 
> ### balena-sdk-15.1.0 - 2020-07-27
> 
> 
> <details>
> <summary> Update balena-pine to add support for and make use of named keys [Pagan Gazzard] </summary>
> 
>> #### balena-pine-12.2.0 - 2020-07-22
>> 
>> 
>> <details>
>> <summary> Update pinejs-client-core [Pagan Gazzard] </summary>
>> 
>>> ##### pinejs-client-js-6.1.0 - 2020-07-21
>>> 
>>> * Add support for using named ids [Pagan Gazzard]
>>> 
>> </details>
>> 
>> 
>> #### balena-request-11.1.0 - 2020-07-16
>> 
>> * Add lazy loading for most modules [Pagan Gazzard]
>> 
> </details>
> 
> 
> ### balena-sdk-15.0.3 - 2020-07-27
> 
> * typings: Fix the PineWithSelect & related type helpers [Thodoris Greasidis]
> * typings: Use the native TypeScript Omit type helper [Thodoris Greasidis]
> 
> ### balena-sdk-15.0.2 - 2020-07-22
> 
> * Fix code snippet for initializing balena-sdk [Vipul Gupta (@vipulgupta2048)]
> 
> ### balena-sdk-15.0.1 - 2020-07-15
> 
> * Fix SupportTier/includes__SLA typing [Pagan Gazzard]
> 
> ### balena-sdk-15.0.0 - 2020-07-15
> 
> * **BREAKING** Export setSharedOptions & fromSharedOptions separately [Thodoris Greasidis]
> * **BREAKING** Export as an ES6 module [Thodoris Greasidis]
> 
> <details>
> <summary> Update dependencies and switch all returned promises to native promises [Pagan Gazzard] </summary>
> 
>> #### balena-auth-4.0.2 - 2020-07-13
>> 
>> * Add .versionbot/CHANGELOG.yml for nested changelogs [Pagan Gazzard]
>> 
>> #### balena-auth-4.0.1 - 2020-07-03
>> 
>> * Explicitly add tslib dependency [Pagan Gazzard]
>> 
>> #### balena-auth-4.0.0 - 2020-07-02
>> 
>> * Update to balena-settings-storage 6.x [Pagan Gazzard]
>> * Update target to es2015 [Pagan Gazzard]
>> * Switch to native promises [Pagan Gazzard]
>> * Enable strict type checking [Pagan Gazzard]
>> * Specify node 10+ [Pagan Gazzard]
>> 
>> #### balena-auth-3.1.1 - 2020-07-02
>> 
>> * Switch to @balena/lint for linting [Pagan Gazzard]
>> 
>> #### balena-pine-12.1.1 - 2020-07-13
>> 
>> * Add .versionbot/CHANGELOG.yml for nested changelogs [Pagan Gazzard]
>> 
>> #### balena-pine-12.1.0 - 2020-07-06
>> 
>> * Update balena-auth to 4.x and balena-request to 11.x [Pagan Gazzard]
>> 
>> #### balena-pine-12.0.1 - 2020-07-03
>> 
>> * Use typescript import helpers [Pagan Gazzard]
>> 
>> #### balena-pine-12.0.0 - 2020-06-26
>> 
>> * Stop actively supporting node 8 [Thodoris Greasidis]
>> * Convert to async await [Thodoris Greasidis]
>> * Add balenaCI repo.yml [Thodoris Greasidis]
>> * karma.conf.js: Combine declaration & assignment of karmaConfig [Thodoris Greasidis]
>> * Bump @balena/lint to v5 [Thodoris Greasidis]
>> * Drop getPine() in favor of an es6 export of the BalenaPine class [Thodoris Greasidis]
>> * Drop the API_PREFIX property in favor of the apiPrefix [Thodoris Greasidis]
>> * Bump to pinejs-client v6 which requires es2015 & drops Bluebird promises [Thodoris Greasidis]
>> 
>> #### balena-pine-11.2.1 - 2020-06-15
>> 
>> * Convert karma.conf to js [Thodoris Greasidis]
>> * Bump balena-config-karma to v3 [Thodoris Greasidis]
>> 
>> #### balena-register-device-7.1.0 - 2020-07-13
>> 
>> * Switch from randomstring to uuid for generating device uuids [Pagan Gazzard]
>> 
>> #### balena-register-device-7.0.1 - 2020-07-13
>> 
>> * Add .versionbot/CHANGELOG.yml for nested changelogs [Pagan Gazzard]
>> 
>> #### balena-register-device-7.0.0 - 2020-07-06
>> 
>> * Convert to type checked javascript [Pagan Gazzard]
>> * Drop callback interface in favor of promise interface [Pagan Gazzard]
>> * Switch to a named export [Pagan Gazzard]
>> * Convert to typescript [Pagan Gazzard]
>> * Update to typed-error 3.x [Pagan Gazzard]
>> * Switch to returning native promises [Pagan Gazzard]
>> * Update to balena-request 11.x [Pagan Gazzard]
>> * Use typescript import helpers [Pagan Gazzard]
>> 
>> #### balena-register-device-6.1.6 - 2020-05-26
>> 
>> * Export ApiError [Cameron Diver]
>> 
>> #### balena-register-device-6.1.5 - 2020-05-21
>> 
>> * Convert tests to js [Thodoris Greasidis]
>> 
>> #### balena-register-device-6.1.4 - 2020-05-21
>> 
>> * Install typed-error v2 [Cameron Diver]
>> 
>> #### balena-register-device-6.1.3 - 2020-05-20
>> 
>> * Extend API exception to include full response object [Miguel Casqueira]
>> 
>> #### balena-register-device-6.1.2 - 2020-05-20
>> 
>> * Update mocha to fix node v12 deprecation warning [Thodoris Greasidis]
>> 
>> #### balena-request-11.0.4 - 2020-07-14
>> 
>> * Fix body overwriting on nodejs [Pagan Gazzard]
>> 
>> #### balena-request-11.0.3 - 2020-07-13
>> 
>> * Add .versionbot/CHANGELOG.yml for nested changelogs [Pagan Gazzard]
>> 
>> #### balena-request-11.0.2 - 2020-07-06
>> 
>> * Fix tslib dependency [Pagan Gazzard]
>> 
>> #### balena-request-11.0.1 - 2020-07-03
>> 
>> * Fix passing baseUrl to refreshToken if the request uses an absolute url [Pagan Gazzard]
>> 
>> #### balena-request-11.0.0 - 2020-07-03
>> 
>> * Convert to type checked javascript [Pagan Gazzard]
>> * Switch to returning native promises [Pagan Gazzard]
>> * Drop support for nodejs < 10 [Pagan Gazzard]
>> * Update balena-auth to 4.x [Pagan Gazzard]
>> * Remove rindle dependency [Pagan Gazzard]
>> * Update fetch-ponyfill to 6.x [Pagan Gazzard]
>> * Remove proxy tests as global-tunnel-ng only supports nodejs < 10.16.0 [Pagan Gazzard]
>> * Switch to a named export [Pagan Gazzard]
>> * Use typescript import helpers [Pagan Gazzard]
>> * Bump balena-config-karma & convert karma.conf.coffee to js [Thodoris Greasidis]
>> * Change the browser request timeout error to be consistent with node [Thodoris Greasidis]
>> 
> </details>
> 
> * **BREAKING** billing: Make the organization parameter fist & required [Thodoris Greasidis]
> 
> ### balena-sdk-14.8.0 - 2020-07-15
> 
> * DeviceWithServiceDetails: preserve the image_install & gateway_downloads [Thodoris Greasidis]
> * typings: Deprecate DeviceWithImageInstalls in favor of the Device type [Thodoris Greasidis]
> 
> ### balena-sdk-14.7.1 - 2020-07-14
> 
> * Fix is_private typings for device type [Stevche Radevski]
> 
> ### balena-sdk-14.7.0 - 2020-07-14
> 
> * Add an organization parameter to all billing methods [Thodoris Greasidis]
> 
> ### balena-sdk-14.6.0 - 2020-07-13
> 
> * typings: Add ApplicationHostedOnApplication [Thodoris Greasidis]
> * typings Add RecoveryTwoFactor [Thodoris Greasidis]
> 
> ### balena-sdk-14.5.1 - 2020-07-10
> 
> * Tests: remove bluebird usage [Pagan Gazzard]
> 
> ### balena-sdk-14.5.0 - 2020-07-09
> 
> * tests/integration/setup: Convert to TypeScript [Thodoris Greasidis]
> * typings/ImageInstall: Deprecate the image field [Thodoris Greasidis]
> * typings/ImageInstall: Add the `installs__image` field [Thodoris Greasidis]
> * typings: Add typings for the ReleaseImage [Thodoris Greasidis]
> * typings/ImageInstall: Add the missing device property [Thodoris Greasidis]
> * Convert all remaining tests away from coffeescript [Pagan Gazzard]
> 
> ### balena-sdk-14.4.2 - 2020-07-09
> 
> * Tests: improve typing for access to private SDK os methods [Pagan Gazzard]
> * Tests: improve typing of tag helpers [Pagan Gazzard]
> * Tests: import BalenaSDK types directly [Pagan Gazzard]
> 
> ### balena-sdk-14.4.1 - 2020-07-08
> 
> * Tests: merge multiple application deletions into a single call [Pagan Gazzard]
> 
> ### balena-sdk-14.4.0 - 2020-07-08
> 
> * Improve typings for `sdk.pine.post` [Pagan Gazzard]
> * Improve typings for `sdk.request` [Pagan Gazzard]
> * Improve typings for `models.device.getOsVersion` [Pagan Gazzard]
> * Improve typings for `models.device.lastOnline` [Pagan Gazzard]
> * Fix typings for `models.device.getMACAddresses` [Pagan Gazzard]
> * Fix typings for `models.device.getLocalIPAddresses` [Pagan Gazzard]
> * Add typings for `models.application.getDashboardUrl` [Pagan Gazzard]
> * Device model: last_connectivity_event and os_version can be null [Pagan Gazzard]
> * Improve typings for `models.device.getLocalModeSupport` [Pagan Gazzard]
> 
> ### balena-sdk-14.3.3 - 2020-07-07
> 
> * Minimize bluebird sugar usage [Pagan Gazzard]
> 
> ### balena-sdk-14.3.2 - 2020-07-07
> 
> * Add type checking for tests [Pagan Gazzard]
> 
> ### balena-sdk-14.3.1 - 2020-07-07
> 
> * Tests: cache device type lookup [Pagan Gazzard]
> 
> ### balena-sdk-14.3.0 - 2020-07-07
> 
> * typings: Export pine variant w/ a mandatory $select on get requests [Thodoris Greasidis]
> 
> ### balena-sdk-14.2.9 - 2020-07-07
> 
> * Remove `this.skip` usage as a faster workaround to afterEach skipping [Pagan Gazzard]
> 
> ### balena-sdk-14.2.8 - 2020-07-06
> 
> * Improve internal typings by avoiding some `any` cases [Pagan Gazzard]
> 
> ### balena-sdk-14.2.7 - 2020-07-06
> 
> * Include typings for all lazy loaded requires [Pagan Gazzard]
> 
> ### balena-sdk-14.2.6 - 2020-07-06
> 
> * Simplify balena-request custom typings [Pagan Gazzard]
> * Use import type for declaration imports [Pagan Gazzard]
> * Simplify balena-pine custom typings [Pagan Gazzard]
> * Import balena-sdk type declarations via import type and not direct path [Pagan Gazzard]
> 
> ### balena-sdk-14.2.5 - 2020-07-06
> 
> * Use typescript import helpers [Pagan Gazzard]
> 
> ### balena-sdk-14.2.4 - 2020-07-03
> 
> * Drop dtslint in favor of plain @ts-expect-error [Thodoris Greasidis]
> * Enable strict checks for the typing tests [Thodoris Greasidis]
> 
> ### balena-sdk-14.2.3 - 2020-07-03
> 
> * Standardize bluebird naming as `Bluebird` [Pagan Gazzard]
> 
> ### balena-sdk-14.2.2 - 2020-07-03
> 
> * Avoid $ExpectType b/c of issues with TS 3.9.6 [Thodoris Greasidis]
> 
> ### balena-sdk-14.2.1 - 2020-07-01
> 
> * model: Add build_environment_variable [Rich Bayliss]
> 
> ### balena-sdk-14.2.0 - 2020-07-01
> 
> * Add typings for plans & subscriptions [Thodoris Greasidis]
> 
</details>

# v7.0.1
## (2020-06-30)

* Fix fs.promises reference [Pagan Gazzard]

# v7.0.0
## (2020-06-30)

* Switch to returning native promises [Pagan Gazzard]
* Update to balena-sdk 14.x [Pagan Gazzard]
* Update to generating es2018 [Pagan Gazzard]
* Convert to type-checked javascript [Pagan Gazzard]

## 6.1.2 - 2020-03-04

* Update dependencies [Pagan Gazzard]

## 6.1.1 - 2020-01-24

* Update dependencies and repo links [Pagan Gazzard]

## 6.1.0 - 2019-09-30

* .travis.yml: Limit testing up to node v10 since gulp doesn't work on v12 [Thodoris Greasidis]
* Bump balena-sdk to v12.12.0 to stop using image maker endpoints [Thodoris Greasidis]

## v6.0.0 - 2018-10-29

* Drop support for Node 4 [Tim Perry]
* Rename everything 'resin' to 'balena' [Tim Perry]

- Ensure that .get for a specific version always uses exactly that version,
  as long as exists, even if there are other equivalent options.
- *BREAKING*: Upgrade to resin-sdk using fromSharedOptions. Configuration should
  now be set using resinSdk.setSharedOptions, not using resin-settings.

## [4.1.2] - 2017-10-05

- Don't persist downloads to cache until they complete

## [4.1.1] - 2017-04-03

### Changed

- Add basic support for new ResinOS version format to fix `resin-cli` issues.

## [4.1.0] - 2017-03-23

### Changed

- Slightly improved docs
- Added support for OS versions (defaults to `latest` which is backward-compatible)

## [4.0.2] - 2017-01-25

### Changed

- Moved to [resin-sdk-preconfigured](https://github.com/resin-io-modules/resin-sdk-preconfigured)

## [4.0.1] - 2016-06-21

### Changed

- Upgrade `resin-sdk` to v5.3.3.

## [4.0.0] - 2016-01-26

### Changed

- Use `Last-Modified` header to manage cache expiration.

### Removed

- Remove `.pipeTemporal()`.

## [3.2.6] - 2016-01-21

### Changed

- Upgrade `resin-sdk` to v5.0.1.
- Change license to Apache 2.0.

## [3.2.5] - 2015-12-06

### Allow automatic minor patches upgrades of the Resin SDK.

## [3.2.4] - 2015-12-04

### Changed

- Omit tests from NPM package.

## [3.2.3] - 2015-11-24

### Changed

- Upgrade Resin SDK to v4.0.0.

## [3.2.2] - 2015-09-07

### Changed

- Upgrade Resin SDK to v2.7.2.

## [3.2.1] - 2015-09-04

### Changed

- Fix issue with image not being fetched from the cache.

## [3.2.0] - 2015-08-26

### Added

- Implement `manager.pipeTemporal()`

### Changed

- Preserve `mime` property when fetching image from the cache.

## [3.1.3] - 2015-08-26

### Changed

- Fix issue that prevented stream `mime` property to be propagated to the client.

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

[5.0.0]: https://github.com/resin-io/resin-image-manager/compare/v4.2.1...v5.0.0
[4.1.2]: https://github.com/resin-io/resin-image-manager/compare/v4.1.1...v4.1.2
[4.1.1]: https://github.com/resin-io/resin-image-manager/compare/v4.1.0...v4.1.1
[4.1.0]: https://github.com/resin-io/resin-image-manager/compare/v4.0.2...v4.1.0
[4.0.2]: https://github.com/resin-io/resin-image-manager/compare/v4.0.1...v4.0.2
[4.0.1]: https://github.com/resin-io/resin-image-manager/compare/v4.0.0...v4.0.1
[4.0.0]: https://github.com/resin-io/resin-image-manager/compare/v3.2.6...v4.0.0
[3.2.6]: https://github.com/resin-io/resin-image-manager/compare/v3.2.5...v3.2.6
[3.2.5]: https://github.com/resin-io/resin-image-manager/compare/v3.2.4...v3.2.5
[3.2.4]: https://github.com/resin-io/resin-image-manager/compare/v3.2.3...v3.2.4
[3.2.3]: https://github.com/resin-io/resin-image-manager/compare/v3.2.2...v3.2.3
[3.2.2]: https://github.com/resin-io/resin-image-manager/compare/v3.2.1...v3.2.2
[3.2.1]: https://github.com/resin-io/resin-image-manager/compare/v3.2.0...v3.2.1
[3.2.0]: https://github.com/resin-io/resin-image-manager/compare/v3.1.3...v3.2.0
[3.1.3]: https://github.com/resin-io/resin-image-manager/compare/v3.1.2...v3.1.3
[3.1.2]: https://github.com/resin-io/resin-image-manager/compare/v3.1.1...v3.1.2
[3.1.1]: https://github.com/resin-io/resin-image-manager/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/resin-io/resin-image-manager/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/resin-io/resin-image-manager/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/resin-io/resin-image-manager/compare/v1.1.0...v2.0.0
[1.1.0]: https://github.com/resin-io/resin-image-manager/compare/v1.0.0...v1.1.0
