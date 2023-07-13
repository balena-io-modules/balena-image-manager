# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [5.0.0] - 2017-10-17

## 9.0.1 - 2023-07-13

* patch: Update flowzone.yml [Kyle Harding]

## 9.0.0 - 2023-05-23

* Drop .hound.yml [Thodoris Greasidis]
* Update dependencies [Thodoris Greasidis]
* Update README.md [Thodoris Greasidis]
* Update to balena-sdk 17.0.0 [Thodoris Greasidis]
* Convert to typescript an emit type declarations [Thodoris Greasidis]
* Require es2019 capable runtime [Thodoris Greasidis]
* Drop support for Node.js v12 & v14 [Thodoris Greasidis]

## 8.0.3 - 2022-09-26

* Delete redundant .resinci.yml [Thodoris Greasidis]

## 8.0.2 - 2022-09-22

* Drop the .travis.yml [Thodoris Greasidis]
* Replace balenaCI with flowzone [Thodoris Greasidis]

## 8.0.1 - 2022-07-13

* Update typescript to fix the tests [Thodoris Greasidis]
* Update README part for linting [Thodoris Greasidis]

## 8.0.0 - 2021-12-23

* manager.get: Add 'options' to allow selection of OS development variant [Paulo Castro]
* resolveVersion: Use SDK v16 capability of sorting/filtering ESR versions [Paulo Castro]

<details>
<summary> Drop support for Node.js v10 and update balena-sdk to v16.8.0 [Paulo Castro] </summary>

> ### balena-sdk-16.8.0 - 2021-12-22
> 
> * os.getConfig: Accept additional developmentMode configuration option [Thodoris Greasidis]
> 
> ### balena-sdk-16.7.0 - 2021-12-22
> 
> * os.download: Fix the inferred method typings [Thodoris Greasidis]
> * os.download: Accept additional configuration options [Thodoris Greasidis]
> 
> ### balena-sdk-16.6.0 - 2021-12-22
> 
> * models.os: Use the native hostApp OS release version if it is set [Thodoris Greasidis]
> * models.os: Deprecate OsVersion.rawVersion in favor or raw_version [Thodoris Greasidis]
> 
> ### balena-sdk-16.5.0 - 2021-12-22
> 
> * os.getAllOsVersions: Add support for invariant OS releases [Thodoris Greasidis]
> 
> ### balena-sdk-16.4.1 - 2021-12-21
> 
> * os.getMaxSatisfyingVersion: Add ">" semver range tests [Thodoris Greasidis]
> 
> ### balena-sdk-16.4.0 - 2021-12-21
> 
> * os.getMaxSatisfyingVersion: Add support for ESR releases [Thodoris Greasidis]
> 
> ### balena-sdk-16.3.0 - 2021-12-21
> 
> * application.getAppByName: Add 'directly_accessible' convenience filter [Thodoris Greasidis]
> 
> ### balena-sdk-16.2.3 - 2021-12-17
> 
> * FIx the return type of config.getConfigVarSchema() [Thodoris Greasidis]
> 
> ### balena-sdk-16.2.2 - 2021-12-17
> 
> * os.getAvailableOsVersions: Exclude draft and non-successful releases [Thodoris Greasidis]
> * os.getAllOsVersions: Deprecate OsVersion.isRecommended [Thodoris Greasidis]
> * os.getAllOsVersions: Deprecate OsVersion.formattedVersion [Thodoris Greasidis]
> 
> ### balena-sdk-16.2.1 - 2021-12-17
> 
> * Drop require-npm4-to-publish [Thodoris Greasidis]
> 
> ### balena-sdk-16.2.0 - 2021-12-17
> 
> * minor: Add Configuration Variables Schema method [Vipul Gupta (@vipulgupta2048)]
> 
> ### balena-sdk-16.1.0 - 2021-12-08
> 
> * Add description field to generateProvisioningKey for apps. [Nitish Agarwal]
> 
> ### balena-sdk-16.0.0 - 2021-11-28
> 
> * **BREAKING**: Merge the hostApp model into the OS model [Thodoris Greasidis]
> * **BREAKING** Drop os.getSupportedVersions() method in favor of hostapp.getAvailableOsVersions() [Thodoris Greasidis]
> * os.getMaxSatisfyingVersion: Add optional param to choose OS line type [Thodoris Greasidis]
> * os.getMaxSatisfyingVersion: Include ESR versions [Thodoris Greasidis]
> * os.getMaxSatisfyingVersion: Switch to use hostApps [Thodoris Greasidis]
> * hostapp.getAvailableOsVersions: Add single device type argument overload [Thodoris Greasidis]
> * hostapp.getAllOsVersions: Add single device type argument overload [Thodoris Greasidis]
> * models.hostapp: Add a getAvailableOsVersions() convenience method [Thodoris Greasidis]
> * Support optional extra PineOptions in hostapp.getAllOsVersions() [Thodoris Greasidis]
> * **BREAKING** Include invalidated versions in hostapp.getAllOsVersions() [Thodoris Greasidis]
> * models/application: Add getDirectlyAccessible & getAllDirectlyAccessible [Thodoris Greasidis]
> * application.get: Add 'directly_accessible' convenience filter param [Thodoris Greasidis]
> * application.getAll: Add 'directly_accessible' convenience filter param [Thodoris Greasidis]
> * **BREAKING** Change application.getAll to include public apps [Thodoris Greasidis]
> * **BREAKING** Drop targeting/retrieving apps by name in favor of slugs [Thodoris Greasidis]
> * Bump minimum supported Typescript to v4.5.2 [Thodoris Greasidis]
> * **BREAKING**: Stop actively supporting node 10 [Thodoris Greasidis]
> * **BREAKING** Drop application.getAllWithDeviceServiceDetails() [Thodoris Greasidis]
> * **BREAKING** Change apiKey.getAll() to return all key variants [Thodoris Greasidis]
> * types: Drop is_in_local_mode from the Device model [Thodoris Greasidis]
> * types: Drop user__is_member_of__application in favor of the term form [Thodoris Greasidis]
> * typings: Drop Subscription's discounts__plan_addon property [Thodoris Greasidis]
> * typings: Stop extending the JWTUser type in the User model [Thodoris Greasidis]
> * models/config: Change the BETA device type state to NEW [Thodoris Greasidis]
> * typings: Drop the PineWithSelectOnGet type [Thodoris Greasidis]
> * Remove my_application from the supported resources [Thodoris Greasidis]
> * typings: Properly type some Device properties [Thodoris Greasidis]
> * typings: Drop the DeviceWithImageInstalls type [Thodoris Greasidis]
> 
> ### balena-sdk-15.59.2 - 2021-11-28
> 
> 
> <details>
> <summary> Update balena-request to 11.5.0 [Thodoris Greasidis] </summary>
> 
>> #### balena-request-11.5.0 - 2021-11-28
>> 
>> * Convert tests to JavaScript and drop coffeescript [Thodoris Greasidis]
>> * Fix the jsdoc generation [Thodoris Greasidis]
>> * Convert to typescript and publish typings [Thodoris Greasidis]
>> 
> </details>
> 
> 
> ### balena-sdk-15.59.1 - 2021-11-28
> 
> * Fix the typings of the Image contract field [Thodoris Greasidis]
> * Fix the typings for the Release contract field [Thodoris Greasidis]
> 
> ### balena-sdk-15.59.0 - 2021-11-24
> 
> * Add release setIsInvalidated function [Matthew Yarmolinsky]
> 
> ### balena-sdk-15.58.1 - 2021-11-17
> 
> * Update typescript to 4.5.2 [Thodoris Greasidis]
> 
> ### balena-sdk-15.58.0 - 2021-11-16
> 
> * models/release: Add note() method [Thodoris Greasidis]
> * typings: Add the release.invalidation_reason property [Thodoris Greasidis]
> * typings: Add the release.note property [Thodoris Greasidis]
> 
> ### balena-sdk-15.57.2 - 2021-11-15
> 
> * tests/logs: Increase the wait time for retrieving the subscribed logs [Thodoris Greasidis]
> * tests/logs: Refactor to async-await [Thodoris Greasidis]
> 
> ### balena-sdk-15.57.1 - 2021-11-11
> 
> * typings: Fix $filters for resources with non numeric ids [Thodoris Greasidis]
> * typings: Add application.can_use__application_as_host ReverseNavigation [Thodoris Greasidis]
> * Add missing apiKey.getDeviceApiKeysByDevice docs [Thodoris Greasidis]
> 
> ### balena-sdk-15.57.0 - 2021-11-05
> 
> * models/api-key: Change update() & revoke() to work with all key variants [Thodoris Greasidis]
> 
> ### balena-sdk-15.56.0 - 2021-11-04
> 
> * models/apiKey: Add getDeviceApiKeysByDevice() method [Thodoris Greasidis]
> 
> ### balena-sdk-15.55.0 - 2021-11-01
> 
> * typings: Add the release.raw_version property [Thodoris Greasidis]
> 
> ### balena-sdk-15.54.2 - 2021-10-25
> 
> * application/create: Rely on the hostApps for detecting discontinued DTs [Thodoris Greasidis]
> 
> ### balena-sdk-15.54.1 - 2021-10-22
> 
> * tests/device: Async-await conversions & abstraction on multi-field tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.54.0 - 2021-10-20
> 
> * tests: Register devices in chunks of 10 to avoid uuid conflicts in node [Thodoris Greasidis]
> * Add known issue check on release isReccomanded logic [JSReds]
> * Add known_issue_list to hostApp.getOsVersions() [JSReds]
> 
> ### balena-sdk-15.53.0 - 2021-10-07
> 
> * Add support for batch device supervisor updates [Thodoris Greasidis]
> 
> ### balena-sdk-15.52.0 - 2021-10-06
> 
> * Add support for batch device pinning to release [Thodoris Greasidis]
> 
> ### balena-sdk-15.51.4 - 2021-09-28
> 
> * auth.isLoggedIn: Treat BalenaExpiredToken errors as logged out indicator [Thodoris Greasidis]
> 
> ### balena-sdk-15.51.3 - 2021-09-28
> 
> * Convert application spec to TypeScript [Thodoris Greasidis]
> 
> ### balena-sdk-15.51.2 - 2021-09-28
> 
> * application.trackLatestRelease: Fix using draft/invalidated releases [Thodoris Greasidis]
> * application.isTrackingLatestRelease: Exclude draft&invalidated releases [Thodoris Greasidis]
> 
> ### balena-sdk-15.51.1 - 2021-09-20
> 
> 
> <details>
> <summary> Update balena-request to v11.4.2 [Kyle Harding] </summary>
> 
>> #### balena-request-11.4.2 - 2021-09-20
>> 
>> * Allow overriding the default zlib flush setting [Kyle Harding]
>> 
> </details>
> 
> 
> ### balena-sdk-15.51.0 - 2021-09-16
> 
> * os.getConfig: Add typings for the provisioningKeyName option [Nitish Agarwal]
> 
> ### balena-sdk-15.50.1 - 2021-09-13
> 
> * models/os: Always first normalize the device type slug [Thodoris Greasidis]
> 
> ### balena-sdk-15.50.0 - 2021-09-10
> 
> * Add release.finalize to promote draft releases to final [toochevere]
> 
> ### balena-sdk-15.49.1 - 2021-09-10
> 
> * typings: Drop the v5-model-only application_type.is_host_os [Thodoris Greasidis]
> 
> ### balena-sdk-15.49.0 - 2021-09-06
> 
> * os.getSupportedOsUpdateVersions: Use the hostApp releases [Thodoris Greasidis]
> * os.download: Use the hostApp for finding the latest release [Thodoris Greasidis]
> 
> ### balena-sdk-15.48.3 - 2021-08-27
> 
> 
> <details>
> <summary> Update balena-request to 11.4.1 [Kyle Harding] </summary>
> 
>> #### balena-request-11.4.1 - 2021-08-27
>> 
>> * Allow more lenient gzip decompression [Kyle Harding]
>> 
> </details>
> 
> 
> ### balena-sdk-15.48.2 - 2021-08-27
> 
> * Improve hostapp.getAllOsVersions performance & reduce fetched data [Thodoris Greasidis]
> 
> ### balena-sdk-15.48.1 - 2021-08-27
> 
> * Update typescript to 4.4.2 [Thodoris Greasidis]
> 
> ### balena-sdk-15.48.0 - 2021-08-15
> 
> * Deprecate the release.release_version property [Thodoris Greasidis]
> * typings: Add the release versioning properties [Thodoris Greasidis]
> 
> ### balena-sdk-15.47.1 - 2021-08-10
> 
> * Run browser tests using the minified browser bundle [Thodoris Greasidis]
> * Move to uglify-js to fix const assignment bug in minified build [Thodoris Greasidis]
> 
> ### balena-sdk-15.47.0 - 2021-08-09
> 
> * typings: Add the release.is_final & is_finalized_at__date properties [Thodoris Greasidis]
> 
> ### balena-sdk-15.46.1 - 2021-07-28
> 
> * apiKey.getAll: Return only NamedUserApiKeys for backwards compatibility [Thodoris Greasidis]
> 
> ### balena-sdk-15.46.0 - 2021-07-27
> 
> * Add email verification & email request methods [Nitish Agarwal]
> 
> ### balena-sdk-15.45.0 - 2021-07-26
> 
> * Update generateProvisioningKey to include keyName [Nitish Agarwal]
> 
> ### balena-sdk-15.44.0 - 2021-07-15
> 
> * typings: Add the subscription.is_active computed term [Thodoris Greasidis]
> 
> ### balena-sdk-15.43.0 - 2021-07-14
> 
> * typings: Add the organization_memebership.effective_seat_role field [Thodoris Greasidis]
> 
> ### balena-sdk-15.42.2 - 2021-07-14
> 
> * tests: Reduce the number of organizations created [Thodoris Greasidis]
> 
> ### balena-sdk-15.42.1 - 2021-07-13
> 
> * tests/api-key: Fix a race condition in the apiKey.create() tests [Thodoris Greasidis]
> * Convert the apiKey tests to async-await [Thodoris Greasidis]
> 
> ### balena-sdk-15.42.0 - 2021-07-13
> 
> * models/apiKey: Add getProvisioningApiKeysByApplication() method [Nitish Agarwal]
> 
> ### balena-sdk-15.41.1 - 2021-06-30
> 
> * Delete CODEOWNERS [Thodoris Greasidis]
> 
> ### balena-sdk-15.41.0 - 2021-06-21
> 
> * Add organization__has_private_access_to__device_type typings [Thodoris Greasidis]
> * typings: Add organization.has_past_due_invoice_since__date [Thodoris Greasidis]
> 
> ### balena-sdk-15.40.0 - 2021-06-09
> 
> * Add getAllNamedUserApiKeys() in the apiKey model [Thodoris Greasidis]
> 
> ### balena-sdk-15.39.4 - 2021-06-08
> 
> * Add missing modified_at in device type [JSReds]
> 
> ### balena-sdk-15.39.3 - 2021-06-08
> 
> * Fix lint with new linter version [JSReds]
> 
> ### balena-sdk-15.39.2 - 2021-05-27
> 
> * Update TypeScript to v4.3.2 [Thodoris Greasidis]
> 
> ### balena-sdk-15.39.1 - 2021-05-24
> 
> * Update balena-lint to v6 [Thodoris Greasidis]
> 
> ### balena-sdk-15.39.0 - 2021-05-24
> 
> * Add public device types [Tomás Migone]
> 
> ### balena-sdk-15.38.0 - 2021-05-20
> 
> * models/billing: Add changePlan method [Thodoris Greasidis]
> * Update DOCUMENTATION about getAllWithDeviceServiceDetails deprecation [Thodoris Greasidis]
> 
> ### balena-sdk-15.37.0 - 2021-05-17
> 
> * Add public organization types [JSReds]
> 
> ### balena-sdk-15.36.0 - 2021-05-13
> 
> * Add is_of__class in application model [JSReds]
> 
> ### balena-sdk-15.35.2 - 2021-05-13
> 
> * Fix lint after prittier update [JSReds]
> 
> ### balena-sdk-15.35.1 - 2021-05-06
> 
> * Add missing types for the Service & Image resources [Thodoris Greasidis]
> * release.getLatestByApplication: Fix the return type to be optional [Thodoris Greasidis]
> 
> ### balena-sdk-15.35.0 - 2021-05-05
> 
> * Deprecate application.getAllWithDeviceServiceDetails() [Thodoris Greasidis]
> * Deprecate targeting/retrieving apps by name in all models [Thodoris Greasidis]
> * Add application.getAppByName method [Thodoris Greasidis]
> 
> ### balena-sdk-15.34.2 - 2021-05-05
> 
> * Abstract & update device os info that are used in tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.34.1 - 2021-04-14
> 
> * types: Deprecate Device is_in_local_mode property [Thodoris Greasidis]
> 
> ### balena-sdk-15.34.0 - 2021-04-13
> 
> * Deprecate user__is_member_of__application in favor of the term form [Thodoris Greasidis]
> * types/models: Add `user_application_membership` to the User & Team [Thodoris Greasidis]
> 
> ### balena-sdk-15.33.0 - 2021-04-12
> 
> * types/modes: Deprecate Subscription's discounts__plan_addon property [Thodoris Greasidis]
> * types/models: Add `subscription_addon_discount` to the Subscription [Thodoris Greasidis]
> 
> ### balena-sdk-15.32.0 - 2021-04-08
> 
> * Add the auth.getUserActorId() method [Thodoris Greasidis]
> 
> ### balena-sdk-15.31.2 - 2021-04-08
> 
> * models/application: Fix examples incorrectly showing a short device uuid [Thodoris Greasidis]
> * Add application.get example using the application slug [Thodoris Greasidis]
> 
> ### balena-sdk-15.31.1 - 2021-04-07
> 
> * Refactor the resource get by field tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.31.0 - 2021-04-07
> 
> * Manage lock overrides using the config variables instead of the endpoint [Thodoris Greasidis]
> * Abstract the device lock override tests by id/uuid [Thodoris Greasidis]
> 
> ### balena-sdk-15.30.2 - 2021-03-31
> 
> * Fix type of contract fields that should be anyObject instead of object [Micah Halter]
> 
> ### balena-sdk-15.30.1 - 2021-03-18
> 
> * Update ndjson to 2.x [Pagan Gazzard]
> 
> ### balena-sdk-15.30.0 - 2021-03-12
> 
> * Update balena-request to 11.4.0 [Thodoris Greasidis]
> 
> ### balena-sdk-15.29.0 - 2021-03-10
> 
> * Added contract field to device type model [Micah Halter]
> 
> ### balena-sdk-15.28.1 - 2021-03-08
> 
> * Encapsulate the supervisor api methods into a partial [Thodoris Greasidis]
> 
> ### balena-sdk-15.28.0 - 2021-03-05
> 
> * Add device type model [JSReds]
> 
> ### balena-sdk-15.27.1 - 2021-02-24
> 
> * Bump typescript to 4.2 [Thodoris Greasidis]
> 
> ### balena-sdk-15.27.0 - 2021-02-15
> 
> * application.getAll: Use the new user__has_direct_access_to__application [Thodoris Greasidis]
> 
> ### balena-sdk-15.26.0 - 2021-02-15
> 
> * Support unique keys in organization.membership.changeRole() & remove() [Thodoris Greasidis]
> * Support unique keys in application.membership.changeRole() & remove() [Thodoris Greasidis]
> 
> ### balena-sdk-15.25.2 - 2021-02-10
> 
> * tests: Remove all m.chai.expect repetitions [Thodoris Greasidis]
> 
> ### balena-sdk-15.25.1 - 2021-02-10
> 
> * Cleanup application.getAllWithDeviceServiceDetails tests [Thodoris Greasidis]
> * tests: Refactor application.isTrackingLatestRelease to async await [Thodoris Greasidis]
> * tests: Refactor application.willTrackNewReleases to async await [Thodoris Greasidis]
> 
> ### balena-sdk-15.25.0 - 2021-02-10
> 
> * types/models: Add the application uuid property [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.7 - 2021-02-10
> 
> * tests/setup: Fix bug caused by setting bad release timestamps [Thodoris Greasidis]
> * tests: Fix application.willTrackNewReleases missing tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.6 - 2021-02-04
> 
> * Add application membership methods [JSReds]
> 
> ### balena-sdk-15.24.5 - 2021-02-04
> 
> * tests: Cleanup orgs & org memberships when resetting the user [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.4 - 2021-02-03
> 
> * Remove the workaround for failing cascade deletes on deployFromUrl tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.3 - 2021-02-02
> 
> * Refactor release.createFromUrl tests to async-await [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.2 - 2021-02-02
> 
> * Run write release.createFromUrl() tests one by one [Thodoris Greasidis]
> * tests: Workaround the failing  cascade deletes for release.deployFromUrl [Thodoris Greasidis]
> 
> ### balena-sdk-15.24.1 - 2021-01-29
> 
> * Device: add public_address property [JSReds]
> 
> ### balena-sdk-15.24.0 - 2021-01-26
> 
> * Add methods for managing organization memberships [Thodoris Greasidis]
> 
> ### balena-sdk-15.23.2 - 2021-01-26
> 
> * tests: require an email appendage to avoid accidentally deleting accounts [Matthew McGinn]
> 
> ### balena-sdk-15.23.1 - 2021-01-26
> 
> * typings: Fix $filter errors for $any with the `1: 1` expression [Thodoris Greasidis]
> 
> ### balena-sdk-15.23.0 - 2021-01-22
> 
> * Fix bugs that custom typings were hiding [Thodoris Greasidis]
> * Type all model method results [Thodoris Greasidis]
> * Autogenerate typings [Thodoris Greasidis]
> 
> ### balena-sdk-15.22.2 - 2021-01-22
> 
> * typings: Reorganize the pinejs-client re-exports [Thodoris Greasidis]
> * typings/pinejs-client: Provide the resource map as a generic argument [Thodoris Greasidis]
> 
> ### balena-sdk-15.22.1 - 2021-01-21
> 
> * tests: Simplify the setup helpers [Thodoris Greasidis]
> 
> ### balena-sdk-15.22.0 - 2021-01-21
> 
> * typings: Mark the my_application resource as deprecated [Thodoris Greasidis]
> * typings: Add the `user has direct access to application` resource [Thodoris Greasidis]
> 
> ### balena-sdk-15.21.5 - 2021-01-20
> 
> * Refactor device.setSupervisorRelease tests to reduce the created devices [Thodoris Greasidis]
> * supervisor-upgrades: limit to devices that support multicontainer [Matthew McGinn]
> 
> ### balena-sdk-15.21.4 - 2021-01-18
> 
> * typings: add missing `release_version` [Matthew McGinn]
> 
> ### balena-sdk-15.21.3 - 2021-01-14
> 
> * Add note about the test:fast npm script variant [Thodoris Greasidis]
> 
> ### balena-sdk-15.21.2 - 2021-01-08
> 
> * Properly throw Supervisor locked errors in all methods that should do so [Thodoris Greasidis]
> 
> ### balena-sdk-15.21.1 - 2020-12-29
> 
> * Fix device type typings and add to resource mapping [Stevche Radevski]
> 
> ### balena-sdk-15.21.0 - 2020-12-29
> 
> * Add missing typings for device type [Stevche Radevski]
> 
> ### balena-sdk-15.20.0 - 2020-12-04
> 
> * device: Add deactivate method [Marios Balamatsias]
> 
> ### balena-sdk-15.19.0 - 2020-12-02
> 
> * Add missing application and release typings [Stevche Radevski]
> 
> ### balena-sdk-15.18.1 - 2020-11-20
> 
> * Bump typescript to 4.1 [Thodoris Greasidis]
> 
> ### balena-sdk-15.18.0 - 2020-11-19
> 
> * typings: Deprecate PineWithSelectOnGet variant in favor of PineStrict [Thodoris Greasidis]
> 
> <details>
> <summary> Update balena-auth from 4.0.2 to 4.1.0 [josecoelho] </summary>
> 
>> #### balena-request-11.2.0 - 2020-11-12
>> 
>> * Update balena-auth from 4.0.0 to 4.1.0 [josecoelho]
>> 
> </details>
> 
> 
> ### balena-sdk-15.17.0 - 2020-10-27
> 
> * Add missing reverse navigation relations to User typings [Thodoris Greasidis]
> 
> ### balena-sdk-15.16.0 - 2020-10-23
> 
> * Add SDK methods for org invites [Amit Solanki]
> 
> ### balena-sdk-15.15.0 - 2020-10-22
> 
> * Modify the os update to check against hostapp release [Stevche Radevski]
> 
> ### balena-sdk-15.14.0 - 2020-10-19
> 
> * Prevent invalid $selects in strict pine.get variant calls [Thodoris Greasidis]
> * Improve the parameter type checks for the fully typed pine.get [Thodoris Greasidis]
> 
> ### balena-sdk-15.13.0 - 2020-10-09
> 
> * Pass shouldFlatten through when creating release from url [Stevche Radevski]
> 
> ### balena-sdk-15.12.1 - 2020-09-20
> 
> * Time the test suites [Thodoris Greasidis]
> * Combine test util files from before dropping coffeescript [Thodoris Greasidis]
> 
> ### balena-sdk-15.12.0 - 2020-09-20
> 
> * Application: add rename method [JSReds]
> 
> ### balena-sdk-15.11.3 - 2020-09-19
> 
> * tests/keys: Fix race condition [Thodoris Greasidis]
> 
> ### balena-sdk-15.11.2 - 2020-09-19
> 
> * tests/device: Combine some multicontainer app tests [Thodoris Greasidis]
> * Remove some beforeEach() from the device tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.11.1 - 2020-09-19
> 
> * Fix the device.setSupervisorRelease() tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.11.0 - 2020-09-14
> 
> * Typings: Extend the supported billing cycles [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.6 - 2020-09-14
> 
> * tests: Reduce the application creations & teardowns even further [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.5 - 2020-09-14
> 
> * Login: add new error handling, update balena-errors [JSReds]
> 
> ### balena-sdk-15.10.4 - 2020-09-11
> 
> * tests: Reduce the application creations & teardowns [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.3 - 2020-09-11
> 
> * tests: Use mocha.parallel to speed up the test cases [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.2 - 2020-09-11
> 
> * tests: Remove some before/afterEach calls to speed up the tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.1 - 2020-09-10
> 
> * tests: Test that the result of device.getDeviceSlug() is a string [Thodoris Greasidis]
> * tests: Run device.getDeviceBySlug() calls in parallel to speed up tests [Thodoris Greasidis]
> * tests/os: Drop unnecessary beforeEach in getConfig() [Thodoris Greasidis]
> * tests/application: Fix incorrect skipping of unauthenticated tests [Thodoris Greasidis]
> 
> ### balena-sdk-15.10.0 - 2020-09-10
> 
> * typings: Make ReleaseWithImageDetails more accurate [Thodoris Greasidis]
> * Fully type the pine.get results [Thodoris Greasidis]
> * typings: Add the PineTypedResult helper type [Thodoris Greasidis]
> 
> ### balena-sdk-15.9.1 - 2020-09-09
> 
> * Typings: Add organization member relation to tags [Thodoris Greasidis]
> 
> ### balena-sdk-15.9.0 - 2020-09-08
> 
> * Add typings for pine.getOrCreate() [Thodoris Greasidis]
> 
> <details>
> <summary> Bump balena-pine to add getOrCreate [Thodoris Greasidis] </summary>
> 
>> #### balena-pine-12.4.0 - 2020-09-07
>> 
>> 
>> <details>
>> <summary> Update pinejs-client-core to 6.9.0 to support getOrCreate() [Thodoris Greasidis] </summary>
>> 
>>> ##### pinejs-client-js-6.9.0 - 2020-09-07
>>> 
>>> * Add 'getOrCreate' method supporting natural keys [Thodoris Greasidis]
>>> 
>>> ##### pinejs-client-js-6.8.0 - 2020-09-03
>>> 
>>> * Add support for $format [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.7.3 - 2020-08-26
>>> 
>>> * Improve $orderby typing to allow `[{a: 'desc'}, {b: 'asc'}]` [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.7.2 - 2020-08-24
>>> 
>>> * Update dev dependencies [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.7.1 - 2020-08-12
>>> 
>>> * Fix prepare $count typings [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.7.0 - 2020-08-12
>>> 
>>> * Improve typings for request/post/put/patch/delete [Pagan Gazzard]
>>> 
>> </details>
>> 
>> 
> </details>
> 
> 
> ### balena-sdk-15.8.1 - 2020-09-08
> 
> * Add mocha tests specific linting [Thodoris Greasidis]
> * Auto-fix lint errors with the test:fast script [Thodoris Greasidis]
> * Add linting checks back to the test script [Thodoris Greasidis]
> 
> ### balena-sdk-15.8.0 - 2020-09-08
> 
> * Add a hostapps model for fetching OS versions [Stevche Radevski]
> 
> ### balena-sdk-15.7.1 - 2020-09-03
> 
> * tests: Convert the device.getMACAddress tests to async await [Thodoris Greasidis]
> 
> ### balena-sdk-15.7.0 - 2020-09-03
> 
> * Add methods for managing organization membership tags [Thodoris Greasidis]
> * tests: Support testing tags with two word names [Thodoris Greasidis]
> 
> ### balena-sdk-15.6.0 - 2020-09-03
> 
> * Add the models.device.getMetrics method [Thodoris Greasidis]
> * Add the device metric related fields [Thodoris Greasidis]
> 
> ### balena-sdk-15.5.0 - 2020-08-31
> 
> * Add methods for retrieving organization memberships [Thodoris Greasidis]
> 
> ### balena-sdk-15.4.5 - 2020-08-31
> 
> * Remove invite by username example [Amit Solanki]
> 
> ### balena-sdk-15.4.4 - 2020-08-31
> 
> * Workaround a regression in lodash typings for throttle() [Thodoris Greasidis]
> 
> ### balena-sdk-15.4.3 - 2020-08-28
> 
> * tests: Prevent callback support tests from hanging when failing [Thodoris Greasidis]
> 
> ### balena-sdk-15.4.2 - 2020-08-28
> 
> * Add missing balena-request typings for the refreshToken method [Thodoris Greasidis]
> 
> ### balena-sdk-15.4.1 - 2020-08-28
> 
> * Combine the two device model files [Thodoris Greasidis]
> 
> ### balena-sdk-15.4.0 - 2020-08-27
> 
> * Add methods to enable, verify & disable 2fa [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.7 - 2020-08-27
> 
> * Improve $orderby typing to allow `[{a: 'desc'}, {b: 'asc'}]` [Pagan Gazzard]
> 
> ### balena-sdk-15.3.6 - 2020-08-26
> 
> * Document how to use with pkg [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.5 - 2020-08-26
> 
> * Use a more semantic parameter name for device.getDeviceSlug [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.4 - 2020-08-26
> 
> * tests: Update the tests for the new maximum application name size [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.3 - 2020-08-21
> 
> * typings: Fix nested $count support in the strict pine variant [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.2 - 2020-08-20
> 
> * Update TypeScript to 4.0 [Thodoris Greasidis]
> 
> ### balena-sdk-15.3.1 - 2020-08-13
> 
> 
> <details>
> <summary> Bump balena-request to fix breaking user's stored token on token refresh [Thodoris Greasidis] </summary>
> 
>> #### balena-request-11.1.1 - 2020-08-13
>> 
>> * Stop refreshing the token on absolute urls [Thodoris Greasidis]
>> 
> </details>
> 
> 
> ### balena-sdk-15.3.0 - 2020-08-12
> 
> 
> <details>
> <summary> Update balena-pine and add custom typings for prepare/subscribe [Pagan Gazzard] </summary>
> 
>> #### balena-pine-12.3.0 - 2020-08-12
>> 
>> 
>> <details>
>> <summary> Update pinejs-client-core to 6.6.1 [Pagan Gazzard] </summary>
>> 
>>> ##### pinejs-client-js-6.6.1 - 2020-08-11
>>> 
>>> * Fix typing when id is specified to be `AnyObject | undefined` [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.6.0 - 2020-08-11
>>> 
>>> * Deprecate `$expand: { 'a/$count': {...} }` [Pagan Gazzard]
>>> * Deprecate `resource: 'a/$count'` and update typings to reflect it [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.5.0 - 2020-08-11
>>> 
>>> * Add `options: { $count: { ... } }` sugar for top level $count [Pagan Gazzard]
>>> * Add `$expand: { a: { $count: { ... } } }` sugar for $count in expands [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.4.0 - 2020-08-11
>>> 
>>> * Improve return typing of `subscribe` method [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.3.0 - 2020-08-11
>>> 
>>> * Fix Poll.on typings [Pagan Gazzard]
>>> * Improve return typing when id is passed to GET methods [Pagan Gazzard]
>>> * Remove `PromiseResult` type, use `Promise<PromiseResultTypes>` instead [Pagan Gazzard]
>>> * Remove `PromiseObj` type, use `Promise<{}>` instead [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.2.0 - 2020-08-10
>>> 
>>> * Add `$filter: { a: { $count: 1 } }` sugar for $count in filters [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.1.2 - 2020-08-10
>>> 
>>> * Remove redundant ParamsObj/SubscribeParamsObj types [Pagan Gazzard]
>>> 
>>> ##### pinejs-client-js-6.1.1 - 2020-08-10
>>> 
>>> * Make use of `mapObj` helper in more places [Pagan Gazzard]
>>> * Use `Object.keys` in preference to `hasOwnProperty` where applicable [Pagan Gazzard]
>>> 
>> </details>
>> 
>> 
> </details>
> 
> 
> ### balena-sdk-15.2.5 - 2020-08-10
> 
> * Split the User resource & JWT interfaces [Thodoris Greasidis]
> 
> ### balena-sdk-15.2.4 - 2020-08-10
> 
> * Fix pine.get with id result type to include undefined [Thodoris Greasidis]
> 
> ### balena-sdk-15.2.3 - 2020-08-08
> 
> * Add a few missing explicit field $selects [Thodoris Greasidis]
> 
> ### balena-sdk-15.2.2 - 2020-08-05
> 
> * Convert index.js to typescript [Pagan Gazzard]
> * Convert dependent-resource.js to typescript [Pagan Gazzard]
> * Convert device.js to typescript [Pagan Gazzard]
> * Convert application.js to typescript [Pagan Gazzard]
> * Convert settings.js to typescript [Pagan Gazzard]
> * Convert logs.js to typescript [Pagan Gazzard]
> * Convert config.js to typescript [Pagan Gazzard]
> 
</details>

## 7.1.1 - 2021-12-09

* Export utils.isESR function for balena-cli use [Paulo Castro]

## 7.1.0 - 2021-11-18

* Add support for balenaOS ESR versions [Paulo Castro]

## 7.0.4 - 2021-10-26

* Prevent the cacheStream from closing the other passthrough [Kyle Harding]

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
