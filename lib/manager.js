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

/**
 * @module manager
 */

import * as stream from 'stream';
import { fromSharedOptions } from 'balena-sdk';
import * as cache from './cache';
import * as utils from './utils';

const balena = fromSharedOptions();

const doDownload = async (deviceType, version) => {
	const imageStream = await balena.models.os.download(deviceType, version);
	// Piping to a PassThrough stream is needed to be able
	// to then pipe the stream to multiple destinations.
	const pass = new stream.PassThrough();
	imageStream.pipe(pass);

	// Save a copy of the image in the cache
	const cacheStream = await cache.getImageWritableStream(deviceType, version);

	pass.pipe(cacheStream, { end: false });
	pass.on('end', cacheStream.persistCache);

	// If we return `pass` directly, the client will not be able
	// to read all data from it after a delay, since it will be
	// instantly piped to `cacheStream`.
	// The solution is to create yet another PassThrough stream,
	// pipe to it and return the new stream instead.
	const pass2 = new stream.PassThrough();
	// @ts-ignore adding an extra prop
	pass2.mime = imageStream.mime;
	imageStream.on('progress', (state) => pass2.emit('progress', state));

	imageStream.on('error', async (err) => {
		await cacheStream.removeCache();
		pass2.emit('error', err);
	});

	return pass.pipe(pass2);
};

/**
 * @summary Get a device operating system image
 * @function
 * @public
 *
 * @description
 * This function saves a copy of the downloaded image in the cache directory setting specified in [balena-settings-client](https://github.com/balena-io-modules/balena-settings-client).
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} versionOrRange - can be one of
 * * the exact version number,
 * in which case it is used if the version is supported,
 * or the promise is rejected,
 * * a [semver](https://www.npmjs.com/package/semver)-compatible
 * range specification, in which case the most recent satisfying version is used
 * if it exists, or the promise is rejected,
 * * `'latest'` in which case the most recent version is used, including pre-releases,
 * * `'recommended'` in which case the recommended version is used, i.e. the most
 * recent version excluding pre-releases, the promise is rejected
 * if only pre-release versions are available,
 * * `'default'` in which case the recommended version is used if available,
 * or `latest` is used otherwise.
 * Defaults to `'latest'`.
 * @returns {Promise<NodeJS.ReadableStream>} image readable stream
 *
 * @example
 * manager.get('raspberry-pi', 'default').then (stream) ->
 * 	stream.pipe(fs.createWriteStream('foo/bar.img'))
 */
export async function get(deviceType, versionOrRange) {
	if (versionOrRange == null) {
		versionOrRange = 'latest';
	}
	const version = await utils.resolveVersion(deviceType, versionOrRange);
	const isFresh = await cache.isImageFresh(deviceType, version);
	const $stream = isFresh
		? await cache.getImage(deviceType, version)
		: await doDownload(deviceType, version);
	// schedule the 'version' event for the next iteration of the event loop
	// so that callers have a chance of adding an event handler
	setImmediate(() =>
		$stream.emit('balena-image-manager:resolved-version', version),
	);
	return $stream;
}

/**
 * @summary Clean the saved images cache
 * @function
 * @public
 *
 * @description
 * Useful to manually force an image to be re-downloaded.
 *
 * @returns {Promise}
 *
 * @example
 * manager.cleanCache()
 */
export function cleanCache() {
	return cache.clean();
}
