###
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
###

Promise = require('bluebird')
fs = Promise.promisifyAll(require('fs'))
mkdirp = Promise.promisify(require('mkdirp'))
rimraf = Promise.promisify(require('rimraf'))
mime = require('mime')
resin = require('resin-sdk-preconfigured')
path = require('path')
utils = require('./utils')

###*
# @summary Get path to image in cache
# @function
# @protected
#
# @param {String} deviceType - device type slug or alias
# @param {String} version - the exact resin OS version number
# @returns {Promise<String>} image path
#
# @example
# cache.getImagePath('raspberry-pi', '1.2.3').then (imagePath) ->
# 	console.log(imagePath)
###
exports.getImagePath = (deviceType, version) ->
	Promise.try ->
		utils.validateVersion(version)
	.then ->
		Promise.props
			cacheDirectory: resin.settings.get('cacheDirectory')
			fstype: utils.getDeviceType(deviceType)
				.get('yocto')
				.get('fstype')
	.then (results) ->
		extension = if results.fstype is 'zip' then 'zip' else 'img'
		return path.join(results.cacheDirectory,
			"#{deviceType}-v#{version}.#{extension}")

###*
# @summary Determine if a device image is fresh
# @function
# @protected
#
# @description
# If the device image does not exist, return false.
#
# @param {String} deviceType - device type slug or alias
# @param {String} version - the exact resin OS version number
# @returns {Promise<Boolean>} is image fresh
#
# @example
# utils.isImageFresh('raspberry-pi', '1.2.3').then (isFresh) ->
# 	if isFresh
# 		console.log('The Raspberry Pi image v1.2.3 is fresh!')
###
exports.isImageFresh = (deviceType, version) ->
	exports.getImagePath(deviceType, version)
	.then (imagePath) ->
		# Swallow errors from utils.getFileCreatedTime.
		# We interpret these as if the file didn't exist
		utils.getFileCreatedDate(imagePath)
		.catch -> return
	.then (createdDate) ->
		return false if not createdDate?

		return resin.models.os.getLastModified(deviceType, version)
			.then (lastModifiedDate) ->
				return lastModifiedDate < createdDate

###*
# @summary Get an image from the cache
# @function
# @protected
#
# @param {String} deviceType - device type slug or alias
# @param {String} version - the exact resin OS version number
# @returns {Promise<ReadStream>} image readable stream
#
# @example
# utils.getImage('raspberry-pi', '1.2.3').then (stream) ->
# 	stream.pipe(fs.createWriteStream('foo/bar.img'))
###
exports.getImage = (deviceType, version) ->
	exports.getImagePath(deviceType, version)
		.then (imagePath) ->
			stream = fs.createReadStream(imagePath)
			stream.mime = mime.lookup(imagePath)
			return stream

###*
# @summary Get a writable stream for an image in the cache
# @function
# @protected
#
# @param {String} deviceType - device type slug or alias
# @param {String} version - the exact resin OS version number
# @returns {Promise<WriteStream>} image writable stream
#
# @example
# utils.getImageWritableStream('raspberry-pi', '1.2.3').then (stream) ->
# 	fs.createReadStream('foo/bar').pipe(stream)
###
exports.getImageWritableStream = (deviceType, version) ->
	exports.getImagePath(deviceType, version)
		.then (imagePath) ->
			# Ensure the cache directory exists, to prevent
			# ENOENT errors when trying to write to it.
			mkdirp(path.dirname(imagePath)).then ->
				# Append .inprogress to streams, move them to the right location only on success
				inProgressPath = imagePath + '.inprogress'
				stream = fs.createWriteStream(inProgressPath)

				# Call .isCompleted on the stream
				stream.persistCache = ->
					fs.renameAsync(inProgressPath, imagePath)

				stream.removeCache = ->
					fs.unlinkAsync(inProgressPath)

				return stream
###*
# @summary Clean the cache
# @function
# @protected
#
# @returns {Promise}
#
# @example
# cache.clean()
###
exports.clean = ->
	resin.settings.get('cacheDirectory').then(rimraf)
