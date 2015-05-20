async = require('async')
inject = require('resin-config-inject')
_ = require('lodash')
cache = require('./cache')
image = require('./image')
utils = require('./utils')

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

###*
# @summary Configure an image and return the local path
# @function
# @public
#
# @description
# Since the image is configured in a temporal file, a function
# gets passed as the third argument of the callback, which when called
# it removes the temporal configured image file.
#
# @param {Object} deviceManifest - the device manifest
# @param {Object} config - device config
# @param {Function} callback - callback (error, path, removeCallback)
# @param {Function} onProgress - on progress callback
#
# @example
# manager.configure manifest, { hello: 'world' }, (error, path, removeCallback) ->
# 	throw error if error?
# 	console.log("The configured device image lives in #{path}")
#
# 	removeCallback (error) ->
# 		throw error if error?
# 		console.log('The configured temporal image was removed')
#
# , (state) ->
# 	console.log(state)
###
exports.configure = (deviceManifest, config, callback, onProgress) ->

	if not deviceManifest?
		throw new Error('Missing device manifest')

	if not _.isPlainObject(deviceManifest)
		throw new Error("Invalid device manifest: #{deviceManifest}")

	if not deviceManifest.slug?
		throw new Error('Missing device manifest slug')

	if not _.isString(deviceManifest.slug)
		throw new Error("Invalid device manifest slug: #{deviceManifest.slug}")

	if not deviceManifest.configPartition?
		throw new Error('Missing device manifest config partition')

	if not config?
		throw new Error('Missing config')

	if not _.isPlainObject(config)
		throw new Error("Invalid config: #{config}")

	if not callback?
		throw new Error('Missing callback')

	if not _.isFunction(callback)
		throw new Error("Invalid callback: #{callback}")

	if not onProgress?
		throw new Error('Missing on progress callback')

	if not _.isFunction(onProgress)
		throw new Error("Invalid on progress callback: #{onProgress}")

	async.waterfall([

		(callback) ->
			async.parallel

				imagePath: (callback) ->
					exports.get(deviceManifest, callback, onProgress)

				temporalImagePath: (callback) ->
					utils.generateTemporalImagePath(callback)

			, (error, results) ->
				return callback(error) if error?
				return callback(null, results)

		(results, callback) ->
			utils.copy(results.imagePath, results.temporalImagePath, callback)

		(temporalImagePath, callback) ->
			partition = deviceManifest.configPartition
			inject.write temporalImagePath, config, partition, (error) ->
				return callback(error) if error?
				removeCallback = utils.getUnlinkFunction(temporalImagePath)
				return callback(null, temporalImagePath, removeCallback)

	], callback)
