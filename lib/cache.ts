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

import * as fs from 'fs';
import * as mkdirp from 'mkdirp';
import { fromSharedOptions } from 'balena-sdk';
import * as mime from 'mime';
import * as path from 'path';
import * as utils from './utils';
import * as rimraf from 'rimraf';
import { promisify } from 'util';

const balena = fromSharedOptions();
const rimrafAsync = promisify(rimraf);

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
export const getImagePath = async (deviceType, version) => {
	await utils.validateVersion(version);
	const [cacheDirectory, deviceTypeInfo] = await Promise.all([
		balena.settings.get('cacheDirectory'),
		balena.models.config.getDeviceTypeManifestBySlug(deviceType),
	]);
	const extension = deviceTypeInfo.yocto.fstype === 'zip' ? 'zip' : 'img';
	return path.join(cacheDirectory, `${deviceType}-v${version}.${extension}`);
};

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
export const isImageFresh = async (deviceType, version) => {
	const imagePath = await getImagePath(deviceType, version);
	let createdDate;
	try {
		createdDate = await utils.getFileCreatedDate(imagePath);
	} catch {
		// Swallow errors from utils.getFileCreatedTime.
	}
	if (createdDate == null) {
		return false;
	}

	const lastModifiedDate = await balena.models.os.getLastModified(
		deviceType,
		version,
	);
	return lastModifiedDate < createdDate;
};

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
export async function getImage(deviceType, version) {
	const imagePath = await getImagePath(deviceType, version);
	const stream = fs.createReadStream(imagePath) as ReturnType<
		typeof fs.createReadStream
	> & { mime: string };
	// Default to application/octet-stream if we could not find a more specific mime type
	stream.mime = mime.getType(imagePath) ?? 'application/octet-stream';
	return stream;
}

export type ImageWritableStream = ReturnType<typeof fs.createWriteStream> & Record<
   'persistCache' | 'removeCache',
   () => void
>;
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
export async function getImageWritableStream(deviceType, version) {
	const imagePath = await getImagePath(deviceType, version);

	// Ensure the cache directory exists, to prevent
	// ENOENT errors when trying to write to it.
	await mkdirp(path.dirname(imagePath));

	// Append .inprogress to streams, move them to the right location only on success
	const inProgressPath = imagePath + '.inprogress';
	const stream = fs.createWriteStream(inProgressPath) as ImageWritableStream;

	// Call .isCompleted on the stream
	stream.persistCache = () => fs.promises.rename(inProgressPath, imagePath);

	stream.removeCache = () => fs.promises.unlink(inProgressPath);

	return stream;
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
export async function clean() {
	await rimrafAsync(await balena.settings.get('cacheDirectory'));
}
