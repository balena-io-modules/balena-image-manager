var async, cache, image, inject, utils, _;

async = require('async');

inject = require('resin-config-inject');

_ = require('lodash');

cache = require('./cache');

image = require('./image');

utils = require('./utils');


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


/**
 * @summary Configure an image and return the local path
 * @function
 * @public
 *
 * @description
 * Since the image is configured in a temporal file, a function
 * gets passed as the third argument of the callback, which when called
 * it removes the temporal configured image file.
 *
 * @param {Object} deviceManifest - the device manifest
 * @param {Object} config - device config
 * @param {Function} callback - callback (error, path, removeCallback)
 * @param {Function} onProgress - on progress callback
 *
 * @example
 * manager.configure manifest, { hello: 'world' }, (error, path, removeCallback) ->
 * 	throw error if error?
 * 	console.log("The configured device image lives in #{path}")
 *
 * 	removeCallback (error) ->
 * 		throw error if error?
 * 		console.log('The configured temporal image was removed')
 *
 * , (state) ->
 * 	console.log(state)
 */

exports.configure = function(deviceManifest, config, callback, onProgress) {
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
  if (deviceManifest.configPartition == null) {
    throw new Error('Missing device manifest config partition');
  }
  if (config == null) {
    throw new Error('Missing config');
  }
  if (!_.isPlainObject(config)) {
    throw new Error("Invalid config: " + config);
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
  return async.waterfall([
    function(callback) {
      return async.parallel({
        imagePath: function(callback) {
          return exports.get(deviceManifest, callback, onProgress);
        },
        temporalImagePath: function(callback) {
          return utils.generateTemporalImagePath(callback);
        }
      }, function(error, results) {
        if (error != null) {
          return callback(error);
        }
        return callback(null, results);
      });
    }, function(results, callback) {
      return utils.copy(results.imagePath, results.temporalImagePath, callback);
    }, function(temporalImagePath, callback) {
      var partition;
      partition = deviceManifest.configPartition;
      return inject.write(temporalImagePath, config, partition, function(error) {
        var removeCallback;
        if (error != null) {
          return callback(error);
        }
        removeCallback = utils.getUnlinkFunction(temporalImagePath);
        return callback(null, temporalImagePath, removeCallback);
      });
    }
  ], callback);
};
