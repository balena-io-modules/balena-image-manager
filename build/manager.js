var cache, image, _;

_ = require('lodash');

cache = require('./cache');

image = require('./image');


/**
 * @summary Get the local path to a device image
 * @function
 * @public
 *
 * @description
 * If the image is not in the cache, re-download it.
 * If the image is in the cache but is not fresh enough, a new download is triggered.
 *
 * @param {Object} deviceManifest - the device manifest
 * @param {Function} callback - callback (error, path)
 * @param {Function} onProgress - on progress callback
 *
 * @example
 * manager.get manifest, (error, path) ->
 *		throw error if error?
 *		console.log("The device image lives in #{path}")
 *	, (state) ->
 *		console.log(state)
 */

exports.get = function(deviceManifest, callback, onProgress) {
  var imagePath;
  if (deviceManifest == null) {
    throw new Error('Missing device manifest');
  }
  if (!_.isPlainObject(deviceManifest)) {
    throw new Error("Invalid device manifest: " + deviceManifest);
  }
  if (deviceManifest.slug == null) {
    throw new Error('Missing device manifest slug');
  }
  if (!_.isString(deviceManifest.slug)) {
    throw new Error("Invalid device manifest slug: " + deviceManifest.slug);
  }
  if (callback == null) {
    throw new Error('Missing callback');
  }
  if (!_.isFunction(callback)) {
    throw new Error("Invalid callback: " + callback);
  }
  if (onProgress == null) {
    throw new Error('Missing on progress callback');
  }
  if (!_.isFunction(onProgress)) {
    throw new Error("Invalid on progress callback: " + onProgress);
  }
  imagePath = cache.getImagePath(deviceManifest.slug);
  return cache.isImageFresh(deviceManifest, function(error, isFresh) {
    if (error != null) {
      return callback(error);
    }
    if (isFresh) {
      return callback(null, imagePath);
    }
    return image.download(deviceManifest.slug, imagePath, callback, onProgress);
  });
};
