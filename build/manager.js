
/*
Copyright 2016 Resin.io

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
 */

/**
 * @module manager
 */
var cache, doDownload, fs, resin, stream, utils;

stream = require('stream');

fs = require('fs');

resin = require('resin-sdk-preconfigured');

cache = require('./cache');

utils = require('./utils');

doDownload = function(deviceType, version) {
  return resin.models.os.download(deviceType, version).then(function(imageStream) {
    var pass;
    pass = new stream.PassThrough();
    imageStream.pipe(pass);
    return cache.getImageWritableStream(deviceType, version).then(function(cacheStream) {
      var pass2;
      pass.pipe(cacheStream);
      pass2 = new stream.PassThrough();
      pass2.mime = imageStream.mime;
      imageStream.on('progress', function(state) {
        return pass2.emit('progress', state);
      });
      return pass.pipe(pass2);
    });
  });
};


/**
 * @summary Get a device operating system image
 * @function
 * @public
 *
 * @description
 * This function saves a copy of the downloaded image in the cache directory setting specified in [resin-settings-client](https://github.com/resin-io/resin-settings-client).
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} versionOrRange - can be one of
 * * the exact version number,
 * in which case it is used if the version is supported,
 * or the promise is rejected,
 * * a [semver](https://www.npmjs.com/package/semver)-compatible
 * range specification, in which case the most recent satisfying version is used
 * if it exists, or the promise is rejected,
 * * `'latest'` in which case the most recent version is used, including pre-releases,
 * * `'recommended'` in which case the recommended version is used, i.e. the most
 * recent version excluding pre-releases, the promise is rejected
 * if only pre-release versions are available,
 * * `'default'` in which case the recommended version is used if available,
 * or `latest` is used otherwise.
 * Defaults to `'latest'`.
 * @returns {Promise<ReadStream>} image readable stream
 *
 * @example
 * manager.get('raspberry-pi', 'default').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */

exports.get = function(deviceType, versionOrRange) {
  if (versionOrRange == null) {
    versionOrRange = 'latest';
  }
  return utils.resolveVersion(deviceType, versionOrRange).then(function(version) {
    return cache.isImageFresh(deviceType, version).then(function(isFresh) {
      if (isFresh) {
        return cache.getImage(deviceType, version);
      } else {
        return doDownload(deviceType, version);
      }
    });
  });
};


/**
 * @summary Clean the saved images cache
 * @function
 * @public
 *
 * @description
 * Useful to manually force an image to be re-downloaded.
 *
 * @returns {Promise}
 *
 * @example
 * manager.cleanCache()
 */

exports.cleanCache = function() {
  return cache.clean();
};
