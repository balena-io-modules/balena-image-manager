
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
var cache, fs, resin, stream, utils;

stream = require('stream');

fs = require('fs');

resin = require('resin-sdk');

cache = require('./cache');

utils = require('./utils');


/**
 * @summary Get a device operating system image
 * @function
 * @public
 *
 * @description
 * This function saves a copy of the downloaded image in the cache directory setting specified in [resin-settings-client](https://github.com/resin-io/resin-settings-client).
 *
 * @param {String} slug - device type slug
 * @returns {Promise<ReadStream>} image readable stream
 *
 * @example
 * manager.get('raspberry-pi').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */

exports.get = function(slug) {
  return cache.isImageFresh(slug).then(function(isFresh) {
    if (isFresh) {
      return cache.getImage(slug);
    }
    return resin.models.os.download(slug).then(function(imageStream) {
      var pass;
      pass = new stream.PassThrough();
      imageStream.pipe(pass);
      return cache.getImageWritableStream(slug).then(function(cacheStream) {
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
