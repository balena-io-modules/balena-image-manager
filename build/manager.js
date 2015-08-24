
/*
The MIT License

Copyright (c) 2015 Resin.io, Inc. https://resin.io.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */

/**
 * @module manager
 */
var cache, image, stream;

stream = require('stream');

cache = require('./cache');

image = require('./image');


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
    return image.download(slug);
  }).then(function(imageStream) {
    var pass;
    pass = new stream.PassThrough();
    imageStream.pipe(pass);
    return cache.getImageWritableStream(slug).then(function(cacheStream) {
      var pass2;
      pass.pipe(cacheStream);
      pass2 = new stream.PassThrough();
      imageStream.on('progress', function(state) {
        return pass2.emit('progress', state);
      });
      return pass.pipe(pass2);
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
