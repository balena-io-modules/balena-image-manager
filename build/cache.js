
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
var Promise, fs, mime, mkdirp, path, resin, rimraf, utils;

Promise = require('bluebird');

fs = Promise.promisifyAll(require('fs'));

mkdirp = Promise.promisify(require('mkdirp'));

rimraf = Promise.promisify(require('rimraf'));

mime = require('mime');

resin = require('resin-sdk');

path = require('path');

utils = require('./utils');


/**
 * @summary Get path to image in cache
 * @function
 * @protected
 *
 * @param {String} slug - device type slug
 * @returns {Promise<String>} image path
 *
 * @example
 * cache.getImagePath('raspberry-pi').then (imagePath) ->
 * 	console.log(imagePath)
 */

exports.getImagePath = function(slug) {
  return resin.settings.get('cacheDirectory').then(function(cacheDirectory) {
    var extension;
    extension = 'img';
    if (slug === 'intel-edison') {
      extension = 'zip';
    }
    return path.join(cacheDirectory, slug + "." + extension);
  });
};


/**
 * @summary Determine if a device image is fresh
 * @function
 * @protected
 *
 * @description
 * If the device image does not exist, return false.
 *
 * @param {String} slug - device slug
 * @returns {Promise<Boolean>} is image fresh
 *
 * @example
 * utils.isImageFresh('raspberry-pi').then (isFresh) ->
 * 	if isFresh
 * 		console.log('The Raspberry Pi image is fresh!')
 */

exports.isImageFresh = function(slug) {
  return exports.getImagePath(slug).then(function(imagePath) {
    return utils.getFileCreatedTime(imagePath)["catch"](function() {});
  }).then(function(createdTime) {
    if (createdTime == null) {
      return false;
    }
    return resin.settings.get('imageCacheTime').then(function(imageCacheTime) {
      return Date.now() - createdTime < imageCacheTime;
    });
  });
};


/**
 * @summary Get an image from the cache
 * @function
 * @protected
 *
 * @param {String} slug - device slug
 * @returns {Promise<ReadStream>} image readable stream
 *
 * @example
 * utils.getImage('raspberry-pi').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */

exports.getImage = function(slug) {
  return exports.getImagePath(slug).then(function(imagePath) {
    return utils.getFileSize(imagePath).then(function(size) {
      var stream;
      stream = fs.createReadStream(imagePath);
      stream.length = size;
      stream.mime = mime.lookup(imagePath);
      return stream;
    });
  });
};


/**
 * @summary Get a writable stream for an image in the cache
 * @function
 * @protected
 *
 * @param {String} slug - device slug
 * @returns {Promise<WriteStream>} image writable stream
 *
 * @example
 * utils.getImageWritableStream('raspberry-pi').then (stream) ->
 * 	fs.createReadStream('foo/bar').pipe(stream)
 */

exports.getImageWritableStream = function(slug) {
  return exports.getImagePath(slug).then(function(imagePath) {
    return mkdirp(path.dirname(imagePath)).then(function() {
      return fs.createWriteStream(imagePath);
    });
  });
};


/**
 * @summary Clean the cache
 * @function
 * @protected
 *
 * @returns {Promise}
 *
 * @example
 * cache.clean()
 */

exports.clean = function() {
  return resin.settings.get('cacheDirectory').then(rimraf);
};
