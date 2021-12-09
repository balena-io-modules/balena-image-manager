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

import { fromSharedOptions } from 'balena-sdk';
import { promises as fs } from 'fs';

const balena = fromSharedOptions();

const RESINOS_VERSION_REGEX = /v?\d+\.\d+\.\d+(\.rev\d+)?((\-|\+).+)?/;

/**
 * @summary Get file created date
 * @function
 * @protected
 *
 * @param {String} file - file path
 * @returns {Promise<Date>} date since creation
 *
 * @example
 * utils.getFileCreatedDate('foo/bar').then (createdTime) ->
 * 	console.log("The file was created in #{createdTime}")
 */
export async function getFileCreatedDate(file) {
	const { ctime } = await fs.stat(file);
	return ctime;
}

/**
 * @summary Get the device type manifest
 * @function
 * @protected
 *
 * @param {String} deviceType - device type slug or alias
 * @returns {Promise<Object>} device type manifest
 */
export function getDeviceType(deviceType) {
	return balena.models.device.getManifestBySlug(deviceType);
}

/**
 * @summary Get the most recent compatible version
 * @function
 * @protected
 *
 * @param {String} deviceType - device type slug or alias
 * @param {String} versionOrRange - supports the same version options
 * as `balena.models.os.getMaxSatisfyingVersion`.
 * See `manager.get` for the detailed explanation.
 * @returns {Promise<String>} the most recent compatible version.
 */
export async function resolveVersion(deviceType, versionOrRange) {
	const version = isESR(versionOrRange)
		? versionOrRange
		: await balena.models.os.getMaxSatisfyingVersion(
				deviceType,
				versionOrRange,
		  );
	if (!version) {
		throw new Error('No such version for the device type');
	}
	return version;
}

/**
 * Heuristically determine whether the given semver version is a balenaOS
 * ESR version.
 *
 * @param {string} version Semver version. If invalid or range, return false.
 */
export function isESR(version) {
	const match = version.match(/^v?(\d+)\.\d+\.\d+/);
	const major = parseInt((match && match[1]) || '', 10);
	return major >= 2018; // note: (NaN >= 2018) is false
}

/**
 * @summary Check if the string is a valid balenaOS version number
 * @function
 * @protected
 * @description Throws an error if the version is invalid
 *
 * @param {String} version - version number to validate
 * @returns {void} the most recent compatible version.
 */
export function validateVersion(version) {
	if (!RESINOS_VERSION_REGEX.test(version)) {
		throw new Error('Invalid version number');
	}
}
