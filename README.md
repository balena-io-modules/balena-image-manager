resin-image-manager
-------------------

[![npm version](https://badge.fury.io/js/resin-image-manager.svg)](http://badge.fury.io/js/resin-image-manager)
[![dependencies](https://david-dm.org/resin-io/resin-image-manager.png)](https://david-dm.org/resin-io/resin-image-manager.png)
[![Build Status](https://travis-ci.org/resin-io/resin-image-manager.svg?branch=master)](https://travis-ci.org/resin-io/resin-image-manager)

Manage fetching device images with caching support.

Installation
------------

Install `resin-image-manager` by running:

```sh
$ npm install --save resin-image-manager
```

Documentation
-------------

### manager.get(Object deviceManifest, Function callback, Function onProgress)

Get the path to a certain device operating system image in the cache. If the image is not on the cache, or already expired, the image is downloaded from Resin.io.

**Note:** For technical limitations that are currently being solved, you can only download a device image if you have an application created for that device type in your account.

A device manifest is an object that can be obtained from the [Resin SDK](https://github.com/resin-io/resin-sdk).  Please refer to the documentation for more details.

The callback gets passed two arguments `(error, path)`.

If the image needs to be downloaded, the `onProgress` callback gets called with the current download state, [as documented in Resin Request](https://github.com/resin-io/resin-request#function-onprogressstate).

Example:

```coffee
manager = require('resin-image-manager')

manager.get {
	slug: 'raspberry-pi'
}, (error, path) ->
	throw error if error?
	console.log("The image lives in #{path}")
, (state) ->
	console.log(state)
```

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

Contribute
----------

- Issue Tracker: [github.com/resin-io/resin-image-manager/issues](https://github.com/resin-io/resin-image-manager/issues)
- Source Code: [github.com/resin-io/resin-image-manager](https://github.com/resin-io/resin-image-manager)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/resin-image-manager/issues/new) on GitHub.

License
-------

The project is licensed under the MIT license.
