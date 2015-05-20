_ = require('lodash')
fs = require('fs')
fse = require('fs-extra')
tmp = require('tmp')

###*
# @summary Copy a file
# @function
# @protected
#
# @param {String} origin - origin
# @param {String} destination - destination
# @param {Function} callback - callback (error, destination)
#
# @example
# utils.copy 'foo/bar', 'bar/baz', (error, destination) ->
#		throw error if error?
#		console.log("The file was copied to #{destination}")
###
exports.copy = (origin, destination, callback) ->
	fse.copy origin, destination, (error) ->
		return callback(error) if error?
		return callback(null, destination)

###*
# @summary Generate a temporal image path
# @function
# @protected
#
# @param {Function} callback - callback (error, imagePath)
#
# @example
# utils.generateTemporalImagePath (error, imagePath) ->
#		throw error if error?
#		console.log(imagePath)
###
exports.generateTemporalImagePath = (callback) ->
	options =
		prefix: 'resin-image-'
		postfix: '.img'

	tmp.tmpName(options, callback)

###*
# @summary Get a function that when called unlinks a file
# @function
# @protected
#
# @param {String} file - file
# @returns {Function} unlink function
#
# @example
# unlinkFunction = utils.getUnlinkFunction('foo/bar')
# unlinkFunction (error) ->
#		throw error if error?
#		console.log('foo/bar was removed')
###
exports.getUnlinkFunction = (file) ->

	# Using fse here makes tests using mock-fs fail
	return _.partial(fs.unlink, file)
