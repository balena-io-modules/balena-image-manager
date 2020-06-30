balena-image-manager
-------------------

[![npm version](https://badge.fury.io/js/balena-image-manager.svg)](http://badge.fury.io/js/balena-image-manager)
[![dependencies](https://david-dm.org/balena-io-modules/balena-image-manager.png)](https://david-dm.org/balena-io-modules/balena-image-manager.png)
[![Build Status](https://travis-ci.org/balena-io-modules/balena-image-manager.svg?branch=master)](https://travis-ci.org/balena-io-modules/balena-image-manager)
[![Build status](https://ci.appveyor.com/api/projects/status/2nxg1uydksvey0g8?svg=true)](https://ci.appveyor.com/project/jviotti/balena-image-manager)

Join our online chat at [![Gitter chat](https://badges.gitter.im/balena-io-modules/chat.png)](https://gitter.im/balena-io-modules/chat)

Manage device base operating systems resources with caching support.

Role
----

The intention of this module is to provide low level access to how a balena device image is downloaded, cached and evaluated for freshness.

**THIS MODULE IS LOW LEVEL AND IS NOT MEANT TO BE USED BY END USERS DIRECTLY**.

Installation
------------

Install `balena-image-manager` by running:

```sh
$ npm install --save balena-image-manager
```

Documentation
-------------


* [manager](#module_manager)
    * [.get(deviceType, versionOrRange)](#module_manager.get) ⇒ <code>Promise.&lt;NodeJS.ReadableStream&gt;</code>
    * [.cleanCache()](#module_manager.cleanCache) ⇒ <code>Promise</code>

<a name="module_manager.get"></a>

### manager.get(deviceType, versionOrRange) ⇒ <code>Promise.&lt;NodeJS.ReadableStream&gt;</code>
This function saves a copy of the downloaded image in the cache directory setting specified in [balena-settings-client](https://github.com/balena-io-modules/balena-settings-client).

**Kind**: static method of [<code>manager</code>](#module_manager)  
**Summary**: Get a device operating system image  
**Returns**: <code>Promise.&lt;NodeJS.ReadableStream&gt;</code> - image readable stream  
**Access**: public  

| Param | Type | Description |
| --- | --- | --- |
| deviceType | <code>String</code> | device type slug or alias |
| versionOrRange | <code>String</code> | can be one of * the exact version number, in which case it is used if the version is supported, or the promise is rejected, * a [semver](https://www.npmjs.com/package/semver)-compatible range specification, in which case the most recent satisfying version is used if it exists, or the promise is rejected, * `'latest'` in which case the most recent version is used, including pre-releases, * `'recommended'` in which case the recommended version is used, i.e. the most recent version excluding pre-releases, the promise is rejected if only pre-release versions are available, * `'default'` in which case the recommended version is used if available, or `latest` is used otherwise. Defaults to `'latest'`. |

**Example**  
```js
manager.get('raspberry-pi', 'default').then (stream) ->
	stream.pipe(fs.createWriteStream('foo/bar.img'))
```
<a name="module_manager.cleanCache"></a>

### manager.cleanCache() ⇒ <code>Promise</code>
Useful to manually force an image to be re-downloaded.

**Kind**: static method of [<code>manager</code>](#module_manager)  
**Summary**: Clean the saved images cache  
**Access**: public  
**Example**  
```js
manager.cleanCache()
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/balena-io-modules/balena-image-manager/issues/new) on GitHub and the balena team will be happy to help.

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

Contribute
----------

- Issue Tracker: [github.com/balena-io-modules/balena-image-manager/issues](https://github.com/balena-io-modules/balena-image-manager/issues)
- Source Code: [github.com/balena-io-modules/balena-image-manager](https://github.com/balena-io-modules/balena-image-manager)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

License
-------

The project is licensed under the Apache 2.0 license.
