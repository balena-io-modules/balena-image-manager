var mkdirp, path, resin, _;

path = require('path');

_ = require('lodash');

resin = require('resin-sdk');

mkdirp = require('mkdirp');


/**
 * @summary Get mocked OS Params for a device type
 * @function
 * @private
 *
 * @param {String} deviceType - device type slug
 * @param {Function} callback - callback (error, params)
 *
 * @example
 * mock.getOSParams 'raspberry-pi', (error, params) ->
 *		throw error if error?
 *		console.log(params)
 */

exports.getOSParams = function(deviceType, callback) {
  var osParams;
  osParams = {
    network: 'ethernet'
  };
  return resin.models.application.getAll(function(error, applications) {
    var application;
    if (error != null) {
      return callback(error);
    }
    application = _.find(applications, {
      device_type: deviceType
    });
    if (application == null) {
      return callback(new Error("Unknown device type: " + deviceType));
    }
    osParams.appId = application.id;
    return callback(null, osParams);
  });
};


/**
 * @summary Download a device image
 *
 * @param {String} deviceType - device type slug
 * @param {String} output - output path
 * @param {Function} callback - callback (error, output)
 * @param {Function} onProgress - on progress callback (state)
 *
 * @todo
 * This function should be greatly simplified once we can
 * download a non configured image directly.
 *
 * @example
 * image.download 'raspberry-pi', '/tmp/image.img', (error, output) ->
 *		throw error if error?
 *		console.log("The image was downloaded to #{output}")
 *	, (state) ->
 *		console.log(state)
 */

exports.download = function(deviceType, output, callback, onProgress) {
  return mkdirp(path.dirname(output), function(error) {
    if (error != null) {
      return callback(error);
    }
    return exports.getOSParams(deviceType, function(error, params) {
      if (error != null) {
        return callback(error);
      }
      return resin.models.os.download(params, output, callback, onProgress);
    });
  });
};
