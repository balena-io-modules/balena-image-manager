_ = require('lodash')
cache = require('./cache')
image = require('./image')

###*
# @summary Get the local path to a device image
# @function
# @public
#
# @description
# If the image is not in the cache, re-download it.
# If the image is in the cache but is not fresh enough, a new download is triggered.
#
# @param {Object} deviceManifest - the device manifest
# @param {Function} callback - callback (error, path)
# @param {Function} onProgress - on progress callback
#
# @example
# manager.get manifest, (error, path) ->
#		throw error if error?
#		console.log("The device image lives in #{path}")
#	, (state) ->
#		console.log(state)
###
exports.get = (deviceManifest, callback, onProgress) ->

	if not deviceManifest?
		throw new Error('Missing device manifest')

	if not _.isPlainObject(deviceManifest)
		throw new Error("Invalid device manifest: #{deviceManifest}")

	if not deviceManifest.slug?
		throw new Error('Missing device manifest slug')

	if not _.isString(deviceManifest.slug)
		throw new Error("Invalid device manifest slug: #{deviceManifest.slug}")

	if not callback?
		throw new Error('Missing callback')

	if not _.isFunction(callback)
		throw new Error("Invalid callback: #{callback}")

	if not onProgress?
		throw new Error('Missing on progress callback')

	if not _.isFunction(onProgress)
		throw new Error("Invalid on progress callback: #{onProgress}")

	imagePath = cache.getImagePath(deviceManifest.slug)

	cache.isImageFresh deviceManifest, (error, isFresh) ->
		return callback(error) if error?
		return callback(null, imagePath) if isFresh
		image.download(deviceManifest.slug, imagePath, callback, onProgress)
