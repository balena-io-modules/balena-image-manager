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

###*
# @module manager
###

stream = require('stream')
fs = require('fs')
unzip = require('unzip2')
resin = require('resin-sdk')
rindle = require('rindle')
cache = require('./cache')
utils = require('./utils')

###*
# @summary Get a device operating system image
# @function
# @public
#
# @description
# This function saves a copy of the downloaded image in the cache directory setting specified in [resin-settings-client](https://github.com/resin-io/resin-settings-client).
#
# @param {String} slug - device type slug
# @returns {Promise<ReadStream>} image readable stream
#
# @example
# manager.get('raspberry-pi').then (stream) ->
# 	stream.pipe(fs.createWriteStream('foo/bar.img'))
###
exports.get = (slug) ->
	cache.isImageFresh(slug).then (isFresh) ->
		return cache.getImage(slug) if isFresh
		return resin.models.os.download(slug).then (imageStream) ->

			# Piping to a PassThrough stream is needed to be able
			# to then pipe the stream to multiple destinations.
			pass = new stream.PassThrough()
			imageStream.pipe(pass)

			# Save a copy of the image in the cache
			cache.getImageWritableStream(slug).then (cacheStream) ->
				pass.pipe(cacheStream)

				# If we return `pass` directly, the client will not be able
				# to read all data from it after a delay, since it will be
				# instantly piped to `cacheStream`.
				# The solution is to create yet another PassThrough stream,
				# pipe to it and return the new stream instead.
				pass2 = new stream.PassThrough()
				pass2.mime = imageStream.mime
				imageStream.on 'progress', (state) ->
					pass2.emit('progress', state)
				return pass.pipe(pass2)

###*
# @summary Clean the saved images cache
# @function
# @public
#
# @description
# Useful to manually force an image to be re-downloaded.
#
# @returns {Promise}
#
# @example
# manager.cleanCache()
###
exports.cleanCache = ->
	cache.clean()

###*
# @summary Pipe image stream to a temporal location
# @function
# @public
#
# @description
# If the image is a zip directory, it's uncompressed to a temporal location.
#
# Make you *delete the temporal file* after you're done with it.
#
# @param {Stream} stream - image stream
# @returns {Promise<String>} temporal location
#
# @example
# manager.get('raspberry-pi').then (stream) ->
# 	manager.pipeTemporal(stream)
# .then (temporalPath) ->
# 	console.log("The image was piped to #{temporalPath}")
###
exports.pipeTemporal = (stream) ->
	utils.getTemporalPath().then (temporalPath) ->

		# We completely rely on the `mime` custom property
		# to make this decision.
		# The actual stream should be checked instead.
		if stream.mime is 'application/zip'
			output = unzip.Extract(path: temporalPath)
		else
			output = fs.createWriteStream(temporalPath)

		rindle.wait(stream.pipe(output)).return(temporalPath)
