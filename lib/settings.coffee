path = require('path')
userHome = require('user-home')

module.exports =

	# TODO: The $HOME/.resin location is used by other modules
	# This needs to be refactored to every module fetch
	# the local resin directory from a single place to avoid
	# synchronisation issues
	cacheDirectory: path.join(userHome, '.resin', 'cache')

	cacheTime: 1 * 1000 * 60 * 60 * 24 * 7 # 1 week in milliseconds
