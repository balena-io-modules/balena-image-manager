var fs, fse, tmp, _;

_ = require('lodash');

fs = require('fs');

fse = require('fs-extra');

tmp = require('tmp');


/**
 * @summary Copy a file
 * @function
 * @protected
 *
 * @param {String} origin - origin
 * @param {String} destination - destination
 * @param {Function} callback - callback (error, destination)
 *
 * @example
 * utils.copy 'foo/bar', 'bar/baz', (error, destination) ->
 *		throw error if error?
 *		console.log("The file was copied to #{destination}")
 */

exports.copy = function(origin, destination, callback) {
  return fse.copy(origin, destination, function(error) {
    if (error != null) {
      return callback(error);
    }
    return callback(null, destination);
  });
};


/**
 * @summary Generate a temporal image path
 * @function
 * @protected
 *
 * @param {Function} callback - callback (error, imagePath)
 *
 * @example
 * utils.generateTemporalImagePath (error, imagePath) ->
 *		throw error if error?
 *		console.log(imagePath)
 */

exports.generateTemporalImagePath = function(callback) {
  var options;
  options = {
    prefix: 'resin-image-',
    postfix: '.img'
  };
  return tmp.tmpName(options, callback);
};


/**
 * @summary Get a function that when called unlinks a file
 * @function
 * @protected
 *
 * @param {String} file - file
 * @returns {Function} unlink function
 *
 * @example
 * unlinkFunction = utils.getUnlinkFunction('foo/bar')
 * unlinkFunction (error) ->
 *		throw error if error?
 *		console.log('foo/bar was removed')
 */

exports.getUnlinkFunction = function(file) {
  return _.partial(fs.unlink, file);
};
