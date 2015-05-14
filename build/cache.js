var fs, path, settings;

fs = require('fs');

path = require('path');

settings = require('./settings');


/**
 * @summary Get path to image in cache
 * @function
 * @protected
 *
 * @param {String} type - device type slug
 *
 * @example
 * path = cache.getImagePath('raspberry-pi')
 */

exports.getImagePath = function(deviceType) {
  return path.join(settings.cacheDirectory, "" + deviceType + ".img");
};


/**
 * @summary Determine if a device image is fresh
 * @function
 * @protected
 *
 * @description
 * If the device image does not exist, return false.
 *
 * Notice that this function may be tweaked per device
 * by setting cache options in the manifest, which
 * could be read by this function in the future.
 *
 * @param {Object} deviceManifest - device manifest
 * @param {Function} callback - callback (error, isFresh)
 *
 * @example
 * cache.isImageFresh manifest, (error, isFresh) ->
 *		throw error if error?
 *		console.log("Is image fresh? #{isFresh}")
 */

exports.isImageFresh = function(deviceManifest, callback) {
  var imagePath;
  imagePath = exports.getImagePath(deviceManifest.slug);
  return fs.exists(imagePath, function(exists) {
    if (!exists) {
      return callback(null, false);
    }
    return fs.stat(imagePath, function(error, stats) {
      var createdTime, timeDelta;
      if (error != null) {
        return callback(error);
      }
      createdTime = stats.ctime.getTime();
      timeDelta = Date.now() - createdTime;
      return callback(null, timeDelta < settings.cacheTime);
    });
  });
};
