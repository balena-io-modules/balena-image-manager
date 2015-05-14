var resin, _;

_ = require('lodash');

resin = require('resin-sdk');


/**
 * @summary Get mocked OS Params for a device type
 * @function
 * @protected
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
