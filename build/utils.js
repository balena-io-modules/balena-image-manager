
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
var Promise, fs, tmp;

Promise = require('bluebird');

fs = Promise.promisifyAll(require('fs'));

tmp = Promise.promisifyAll(require('tmp'));

tmp.setGracefulCleanup();


/**
 * @summary Get file created time
 * @function
 * @protected
 *
 * @param {String} file - file path
 * @returns {Promise<Number>} milliseconds since creation
 *
 * @example
 * utils.getFileCreatedTime('foo/bar').then (createdTime) ->
 * 	console.log("The file was created #{createdTime} milliseconds ago")
 */

exports.getFileCreatedTime = function(file) {
  return fs.statAsync(file).get('ctime').then(function(ctime) {
    return ctime.getTime();
  });
};


/**
 * @summary Get a temporal path
 * @function
 * @protected
 *
 * @description
 * This function only returns a path, so it's the client responsibility to delete it if there was data saved there.
 *
 * @returns {Promise<String>} temporal path
 *
 * @example
 * utils.getTemporalPath().then (temporalPath) ->
 * 	console.log(temporalPath)
 */

exports.getTemporalPath = function() {
  return tmp.tmpNameAsync();
};
