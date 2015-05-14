path = require('path')
_ = require('lodash')
resin = require('resin-sdk')
mkdirp = require('mkdirp')

###*
# @summary Get mocked OS Params for a device type
# @function
# @private
#
# @param {String} deviceType - device type slug
# @param {Function} callback - callback (error, params)
#
# @example
# mock.getOSParams 'raspberry-pi', (error, params) ->
#		throw error if error?
#		console.log(params)
###
exports.getOSParams = (deviceType, callback) ->

	# Mock os params, later on, we will be able to
	# download a non configured os image directly
	osParams =
		network: 'ethernet'

	resin.models.application.getAll (error, applications) ->
		return callback(error) if error?

		application = _.find(applications, device_type: deviceType)

		if not application?
			return callback(new Error("Unknown device type: #{deviceType}"))

		osParams.appId = application.id

		return callback(null, osParams)

###*
# @summary Download a device image
#
# @param {String} deviceType - device type slug
# @param {String} output - output path
# @param {Function} callback - callback (error, output)
# @param {Function} onProgress - on progress callback (state)
#
# @todo
# This function should be greatly simplified once we can
# download a non configured image directly.
#
# @example
# image.download 'raspberry-pi', '/tmp/image.img', (error, output) ->
#		throw error if error?
#		console.log("The image was downloaded to #{output}")
#	, (state) ->
#		console.log(state)
###
exports.download = (deviceType, output, callback, onProgress) ->
	mkdirp path.dirname(output), (error) ->
		return callback(error) if error?

		exports.getOSParams deviceType, (error, params) ->
			return callback(error) if error?

			resin.models.os.download(params, output, callback, onProgress)
