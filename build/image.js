
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
var _, resin;

_ = require('lodash');

resin = require('resin-sdk');


/**
 * @summary Get mocked OS Params for a device type
 * @function
 * @private
 *
 * @description
 * Later on, we will be able to download a non configured os image directly.
 *
 * @param {String} slug - device type slug
 * @returns {Promise<Object>} os parameters
 *
 * @throws Will throw if the user doesn't have any application of the required device type.
 *
 * @example
 * image.getOSParams('raspberry-pi').then (params) ->
 *		console.log(params)
 */

exports.getOSParameters = function(slug) {
  return resin.models.application.getAll().then(function(applications) {
    var application;
    application = _.find(applications, {
      device_type: slug
    });
    if (application == null) {
      throw new Error("Unknown device type: " + slug);
    }
    return {
      network: 'ethernet',
      appId: application.id
    };
  });
};


/**
 * @summary Download a device image
 * @function
 * @protected
 *
 * @param {String} slug - device type slug
 * @returns {Promise<ReadStream>} image readable stream
 *
 * @example
 * image.download('raspberry-pi').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */

exports.download = function(slug) {
  return exports.getOSParameters(slug).then(resin.models.os.download);
};
