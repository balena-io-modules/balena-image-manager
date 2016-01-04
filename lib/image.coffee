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

_ = require('lodash')
resin = require('resin-sdk')

###*
# @summary Get mocked OS Params for a device type
# @function
# @private
#
# @description
# Later on, we will be able to download a non configured os image directly.
#
# @param {String} slug - device type slug
# @returns {Promise<Object>} os parameters
#
# @throws Will throw if the user doesn't have any application of the required device type.
#
# @example
# image.getOSParams('raspberry-pi').then (params) ->
#		console.log(params)
###
exports.getOSParameters = (slug) ->
	resin.models.application.getAll().then (applications) ->
		application = _.find(applications, device_type: slug)

		if not application?
			throw new Error("Unknown device type: #{slug}")

		result =
			network: 'ethernet'
			appId: application.id

		if slug is 'parallella'
			result.processorType = 'Z7010'
			result.coprocessorCore = '16'
		else if slug is 'intel-edison'
			result.network = 'wifi'
			result.wifiSsid = 'ssid'
			result.wifiKey = 'key'

		return result

###*
# @summary Download a device image
# @function
# @protected
#
# @param {String} slug - device type slug
# @returns {Promise<ReadStream>} image readable stream
#
# @example
# image.download('raspberry-pi').then (stream) ->
# 	stream.pipe(fs.createWriteStream('foo/bar.img'))
###
exports.download = (slug) ->
	exports.getOSParameters(slug).then(resin.models.os.download)
