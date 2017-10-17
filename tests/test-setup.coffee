mockery = require('mockery')

exports.resin = require('resin-sdk').fromSharedOptions()

# Make sure we're all using literally the same instance of resin-sdk
# so we can mock out methods called by the real code
mockery.enable({
	warnOnReplace: false,
	warnOnUnregistered: false
})
mockery.registerMock('resin-sdk', {
	fromSharedOptions: -> exports.resin
})
