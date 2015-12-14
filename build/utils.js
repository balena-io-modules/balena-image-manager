
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
var Promise, fs, tmp;

Promise = require('bluebird');

fs = Promise.promisifyAll(require('fs'));

tmp = Promise.promisifyAll(require('tmp'));

tmp.setGracefulCleanup();


/**
 * @summary Get file size
 * @function
 * @protected
 *
 * @param {String} file - file path
 * @returns {Promise<Number>} file size in bytes
 *
 * @example
 * utils.getFileSize('foo/bar').then (size) ->
 * 	console.log("Size: #{size}")
 */

exports.getFileSize = function(file) {
  return fs.statAsync(file).get('size');
};


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
