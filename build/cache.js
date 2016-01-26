
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
  return Promise.props({
    cacheDirectory: resin.settings.get('cacheDirectory'),
    fstype: resin.models.device.getManifestBySlug(slug).get('yocto').get('fstype')
  }).then(function(results) {
    var extension;
    extension = results.fstype === 'zip' ? 'zip' : 'img';
    return path.join(results.cacheDirectory, slug + "." + extension);
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
    return utils.getFileCreatedDate(imagePath)["catch"](function() {});
  }).then(function(createdTime) {
    if (createdTime == null) {
      return false;
    }
    return resin.settings.get('imageCacheTime').then(function(imageCacheTime) {
      return Date.now() - createdTime.getTime() < imageCacheTime;
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
    var stream;
    stream = fs.createReadStream(imagePath);
    stream.mime = mime.lookup(imagePath);
    return stream;
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
