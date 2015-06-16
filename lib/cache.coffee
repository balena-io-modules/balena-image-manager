fs = require('fs')
path = require('path')
settings = require('./settings')

###*
# @summary Get path to image in cache
# @function
# @protected
#
# @param {String} type - device type slug
#
# @example
# path = cache.getImagePath('raspberry-pi')
###
exports.getImagePath = (deviceType) ->
	extension = 'img'
	if deviceType is 'intel-edison'
		extension = 'zip'
	return path.join(settings.cacheDirectory, "#{deviceType}.#{extension}")

###*
# @summary Determine if a device image is fresh
# @function
# @protected
#
# @description
# If the device image does not exist, return false.
#
# Notice that this function may be tweaked per device
# by setting cache options in the manifest, which
# could be read by this function in the future.
#
# @param {Object} deviceManifest - device manifest
# @param {Function} callback - callback (error, isFresh)
#
# @example
# cache.isImageFresh manifest, (error, isFresh) ->
#		throw error if error?
#		console.log("Is image fresh? #{isFresh}")
###
exports.isImageFresh = (deviceManifest, callback) ->
	imagePath = exports.getImagePath(deviceManifest.slug)

	fs.exists imagePath, (exists) ->
		if not exists
			return callback(null, false)

		fs.stat imagePath, (error, stats) ->
			return callback(error) if error?

			createdTime = stats.ctime.getTime()
			timeDelta = Date.now() - createdTime

			return callback(null, timeDelta < settings.cacheTime)
