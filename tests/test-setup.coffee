mockery = require('mockery')

exports.balena = require('balena-sdk').fromSharedOptions()

# Make sure we're all using literally the same instance of balena-sdk
# so we can mock out methods called by the real code
mockery.enable({
	warnOnReplace: false,
	warnOnUnregistered: false
})
mockery.registerMock('balena-sdk', {
	fromSharedOptions: -> exports.balena
})
