/*
Copyright 2016-2020 Balena Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

import * as Promise from 'bluebird';
import * as fs from 'fs';
import * as mkdirp from 'mkdirp';
import { fromSharedOptions } from 'balena-sdk';
import * as mime from 'mime';
import * as path from 'path';
import * as utils from './utils';
import * as rimraf from 'rimraf';

const balena = fromSharedOptions();
const renameAsync = Promise.promisify(fs.rename);
const unlinkAsync = Promise.promisify(fs.unlink);
const rimrafAsync = Promise.promisify(rimraf);

/**
 * @summary Get path to image in cache
 * @function
 * @protected
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} version - the exact balenaOS version number
 * @returns {Promise<String>} image path
 *
 * @example
 * cache.getImagePath('raspberry-pi', '1.2.3').then (imagePath) ->
 * 	console.log(imagePath)
 */
export function getImagePath(deviceType, version) {
	return Promise.try(() => utils.validateVersion(version))
		.then(() =>
			Promise.props({
				cacheDirectory: balena.settings.get('cacheDirectory'),
				fstype: utils.getDeviceType(deviceType).get('yocto').get('fstype'),
			}),
		)
		.then(function (results) {
			const extension = results.fstype === 'zip' ? 'zip' : 'img';
			return path.join(
				results.cacheDirectory,
				`${deviceType}-v${version}.${extension}`,
			);
		});
}

/**
 * @summary Determine if a device image is fresh
 * @function
 * @protected
 *
 * @description
 * If the device image does not exist, return false.
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} version - the exact balenaOS version number
 * @returns {Promise<Boolean>} is image fresh
 *
 * @example
 * utils.isImageFresh('raspberry-pi', '1.2.3').then (isFresh) ->
 * 	if isFresh
 * 		console.log('The Raspberry Pi image v1.2.3 is fresh!')
 */
export function isImageFresh(deviceType, version) {
	return getImagePath(deviceType, version)
		.then((
			imagePath, // Swallow errors from utils.getFileCreatedTime.
		) =>
			// We interpret these as if the file didn't exist
			utils.getFileCreatedDate(imagePath).catch(function () {
				// ignore errors
			}),
		)
		.then(function (createdDate) {
			if (createdDate == null) {
				return false;
			}

			return balena.models.os
				.getLastModified(deviceType, version)
				.then((lastModifiedDate) => lastModifiedDate < createdDate);
		});
}

/**
 * @summary Get an image from the cache
 * @function
 * @protected
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} version - the exact balenaOS version number
 * @returns {Promise<fs.ReadStream>} image readable stream
 *
 * @example
 * utils.getImage('raspberry-pi', '1.2.3').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */
export function getImage(deviceType, version) {
	return getImagePath(deviceType, version).then(function (imagePath) {
		const stream = fs.createReadStream(imagePath);
		// Default to application/octet-stream if we could not find a more specific mime type
		// @ts-ignore adding an extra prop
		stream.mime = mime.getType(imagePath) ?? 'application/octet-stream';
		return stream;
	});
}

/**
 * @summary Get a writable stream for an image in the cache
 * @function
 * @protected
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} version - the exact balenaOS version number
 * @returns {Promise<fs.WriteStream & { persistCache: () => Promise<void>, removeCache: () => Promise<void> }>} image writable stream
 *
 * @example
 * utils.getImageWritableStream('raspberry-pi', '1.2.3').then (stream) ->
 * 	fs.createReadStream('foo/bar').pipe(stream)
 */
export function getImageWritableStream(deviceType, version) {
	// @ts-expect-error missing typings for the extra properties on the stream we return
	return getImagePath(deviceType, version).then((
		imagePath, // Ensure the cache directory exists, to prevent
	) =>
		// ENOENT errors when trying to write to it.
		mkdirp(path.dirname(imagePath)).then(function () {
			// Append .inprogress to streams, move them to the right location only on success
			const inProgressPath = imagePath + '.inprogress';
			const stream = fs.createWriteStream(inProgressPath);

			// Call .isCompleted on the stream
			// @ts-ignore adding an extra prop
			stream.persistCache = () => renameAsync(inProgressPath, imagePath);

			// @ts-ignore adding an extra prop
			stream.removeCache = () => unlinkAsync(inProgressPath);

			return stream;
		}),
	);
}

/**
 * @summary Clean the cache
 * @function
 * @protected
 *
 * @returns {Promise}
 *
 * @example
 * cache.clean()
 */
export function clean() {
	return balena.settings.get('cacheDirectory').then(rimrafAsync);
}
