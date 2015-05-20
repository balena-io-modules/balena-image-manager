fs = require('fs')
path = require('path')
_ = require('lodash')
chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
mockFs = require('mock-fs')
inject = require('resin-config-inject')
manager = require('../lib/manager')
cache = require('../lib/cache')
image = require('../lib/image')
utils = require('../lib/utils')
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

	describe '.configure()', ->

		it 'should throw if no device manifest', ->
			expect ->
				manager.configure(null, { hello: 'world' }, _.noop, _.noop)
			.to.throw('Missing device manifest')

		it 'should throw if device manifest is not an object', ->
			expect ->
				manager.configure(123, { hello: 'world' }, _.noop, _.noop)
			.to.throw('Invalid device manifest: 123')

		it 'should throw if no device manifest slug', ->
			expect ->
				manager.configure({ configPartition: 2 }, { hello: 'world' }, _.noop, _.noop)
			.to.throw('Missing device manifest slug')

		it 'should throw if device manifest slug is not a string', ->
			expect ->
				manager.configure({ slug: 123, configPartition: 2 }, { hello: 'world' }, _.noop, _.noop)
			.to.throw('Invalid device manifest slug: 123')

		it 'should throw if no device manifest config partition', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi' }, { hello: 'world' }, _.noop, _.noop)
			.to.throw('Missing device manifest config partition')

		it 'should throw if no config', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, null, _.noop, _.noop)
			.to.throw('Missing config')

		it 'should throw if config is not an object', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, 123, _.noop, _.noop)
			.to.throw('Invalid config: 123')

		it 'should throw if no callback', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, { hello: 'world' }, null, _.noop)
			.to.throw('Missing callback')

		it 'should throw if callback is not a function', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, { hello: 'world' }, 123, _.noop)
			.to.throw('Invalid callback: 123')

		it 'should throw if no progress callback', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, { hello: 'world' }, _.noop, null)
			.to.throw('Missing on progress callback')

		it 'should throw if progress callback is not a function', ->
			expect ->
				manager.configure({ slug: 'raspberry-pi', configPartition: 2 }, { hello: 'world' }, _.noop, 123)
			.to.throw('Invalid on progress callback: 123')

		describe 'given we were unable to get the unconfigured image', ->

			beforeEach ->
				@managerGetStub = sinon.stub(manager, 'get')
				@managerGetStub.yields(new Error('image error'))

			afterEach ->
				@managerGetStub.restore()

			it 'should return the error', (done) ->
				manager.configure
					slug: 'raspberry-pi'
					configPartition: 2
				,
					hello: 'world'
				, (error, imagePath, removeCallback) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('image error')
					expect(imagePath).to.not.exist
					expect(removeCallback).to.not.exist
					done()
				, _.noop

		describe 'given we were able to get the unconfigured image', ->

			beforeEach ->
				@managerGetStub = sinon.stub(manager, 'get')
				@managerGetStub.yields(null, 'cache/image.img')

			afterEach ->
				@managerGetStub.restore()

			describe 'given copy was unsuccessful', ->

				beforeEach ->
					@utilsCopyStub = sinon.stub(utils, 'copy')
					@utilsCopyStub.yields(new Error('copy error'))

				afterEach ->
					@utilsCopyStub.restore()

				it 'should return the error', (done) ->
					manager.configure
						slug: 'raspberry-pi'
						configPartition: 2
					,
						hello: 'world'
					, (error, imagePath, removeCallback) ->
						expect(error).to.be.an.instanceof(Error)
						expect(error.message).to.equal('copy error')
						expect(imagePath).to.not.exist
						expect(removeCallback).to.not.exist
						done()
					, _.noop

			describe 'given copy was successful', ->

				beforeEach ->
					@utilsCopyStub = sinon.stub(utils, 'copy')
					@utilsCopyStub.yields(null, 'dest')

				afterEach ->
					@utilsCopyStub.restore()

				describe 'given inject was unsuccessful', ->

					beforeEach ->
						@injectWriteStub = sinon.stub(inject, 'write')
						@injectWriteStub.yields(new Error('inject error'))

					afterEach ->
						@injectWriteStub.restore()

					it 'should return the error', (done) ->
						manager.configure
							slug: 'raspberry-pi'
							configPartition: 2
						,
							hello: 'world'
						, (error, imagePath, removeCallback) ->
							expect(error).to.be.an.instanceof(Error)
							expect(error.message).to.equal('inject error')
							expect(imagePath).to.not.exist
							expect(removeCallback).to.not.exist
							done()
						, _.noop

				describe 'given inject was successful', ->

					beforeEach ->
						@injectWriteStub = sinon.stub(inject, 'write')
						@injectWriteStub.yields(null)

					afterEach ->
						@injectWriteStub.restore()

					it 'should return the image path and remove callback', (done) ->
						manager.configure
							slug: 'raspberry-pi'
							configPartition: 2
						,
							hello: 'world'
						, (error, imagePath, removeCallback) ->
							expect(error).to.not.exist
							expect(imagePath).to.equal('dest')
							expect(removeCallback).to.be.a('function')
							done()
						, _.noop

					it 'should remove the image path if remove callback is called', (done) ->
						fsUnlinkStub = sinon.stub(fs, 'unlink')

						manager.configure
							slug: 'raspberry-pi'
							configPartition: 2
						,
							hello: 'world'
						, (error, imagePath, removeCallback) ->
							removeCallback()
							expect(fsUnlinkStub).to.have.been.calledOnce
							expect(fsUnlinkStub).to.have.been.calledWith('dest')
							fsUnlinkStub.restore()
							done()
						, _.noop
