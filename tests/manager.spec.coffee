path = require('path')
_ = require('lodash')
chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
manager = require('../lib/manager')
cache = require('../lib/cache')
image = require('../lib/image')
settings = require('../lib/settings')

describe 'Manager:', ->

	describe '.get()', ->

		it 'should throw if no device manifest', ->
			expect ->
				manager.get(null, _.noop, _.noop)
			.to.throw('Missing device manifest')

		it 'should throw if device manifest is not an object', ->
			expect ->
				manager.get(123, _.noop, _.noop)
			.to.throw('Invalid device manifest: 123')

		it 'should throw if no device manifest slug', ->
			expect ->
				manager.get({}, _.noop, _.noop)
			.to.throw('Missing device manifest slug')

		it 'should throw if device manifest slug is not a string', ->
			expect ->
				manager.get(slug: 123, _.noop, _.noop)
			.to.throw('Invalid device manifest slug: 123')

		it 'should throw if no callback', ->
			expect ->
				manager.get(slug: 'raspberry-pi', null, _.noop)
			.to.throw('Missing callback')

		it 'should throw if callback is not a function', ->
			expect ->
				manager.get(slug: 'raspberry-pi', 123, _.noop)
			.to.throw('Invalid callback: 123')

		it 'should throw if no progress callback', ->
			expect ->
				manager.get(slug: 'raspberry-pi', _.noop, null)
			.to.throw('Missing on progress callback')

		it 'should throw if progress callback is not a function', ->
			expect ->
				manager.get(slug: 'raspberry-pi', _.noop, 123)
			.to.throw('Invalid on progress callback: 123')

		beforeEach ->
			@imageDownloadStub = sinon.stub(image, 'download')
			@imageDownloadStub.yields(null, cache.getImagePath('raspberry-pi'))

		afterEach ->
			@imageDownloadStub.restore()

		describe 'given the image is fresh', ->

			beforeEach ->
				@cacheIsImageFreshStub = sinon.stub(cache, 'isImageFresh')
				@cacheIsImageFreshStub.yields(null, true)

			afterEach ->
				@cacheIsImageFreshStub.restore()

			it 'should not download the image', (done) ->
				manager.get
					slug: 'raspberry-pi'
				, (error, imagePath) =>
					expect(@imageDownloadStub).to.not.have.been.called
					done()
				, _.noop

			it 'should return the image path', (done) ->
				manager.get
					slug: 'raspberry-pi'
				, (error, imagePath) ->
					expect(error).to.not.exist
					expect(imagePath).to.equal(cache.getImagePath('raspberry-pi'))
					done()
				, _.noop

		describe 'given the image is not fresh', ->

			beforeEach ->
				@cacheIsImageFreshStub = sinon.stub(cache, 'isImageFresh')
				@cacheIsImageFreshStub.yields(null, false)

			afterEach ->
				@cacheIsImageFreshStub.restore()

			it 'should download the image', (done) ->
				manager.get
					slug: 'raspberry-pi'
				, (error, imagePath) =>
					expect(@imageDownloadStub).to.have.been.calledOnce
					expect(@imageDownloadStub).to.have.been.calledWith('raspberry-pi')
					done()
				, _.noop

			it 'should return the image path', (done) ->
				manager.get
					slug: 'raspberry-pi'
				, (error, imagePath) ->
					expect(error).to.not.exist
					expect(imagePath).to.equal(cache.getImagePath('raspberry-pi'))
					done()
				, _.noop
