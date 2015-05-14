fs = require('fs')
path = require('path')
_ = require('lodash')
chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
cache = require('../lib/cache')
settings = require('../lib/settings')

describe 'Cache:', ->

	describe '.getImagePath()', ->

		it 'should return a string', ->
			expect(cache.getImagePath('foo')).to.be.a('string')

		it 'should be an absolute path', ->
			isAbsolute = (input) ->
				return path.resolve(input) is path.normalize(input)

			result = cache.getImagePath('foo')
			expect(isAbsolute(result)).to.be.true

		it 'should have an extension equal to img', ->
			result = cache.getImagePath('foo')
			extension = path.extname(result)
			expect(extension).to.equal('.img')

	describe '.isImageFresh()', ->

		describe 'given the image does not exist', ->

			beforeEach ->
				@fsExistsStub = sinon.stub(fs, 'exists')
				@fsExistsStub.yields(false)

			afterEach ->
				@fsExistsStub.restore()

			it 'should return false', (done) ->
				cache.isImageFresh
					slug: 'raspberry-pi'
				, (error, isFresh) ->
					expect(error).to.not.exist
					expect(isFresh).to.be.false
					done()

		describe 'given the image exists', ->

			beforeEach ->
				@fsExistsStub = sinon.stub(fs, 'exists')
				@fsExistsStub.yields(true)

			afterEach ->
				@fsExistsStub.restore()

			describe 'given there was an error getting the stats', ->

				beforeEach ->
					@fsStatsStub = sinon.stub(fs, 'stat')
					@fsStatsStub.yields(new Error('stat error'))

				afterEach ->
					@fsStatsStub.restore()

				it 'should return the same error', (done) ->
					cache.isImageFresh
						slug: 'raspberry-pi'
					, (error, isFresh) ->
						expect(error).to.be.an.instanceof(Error)
						expect(error.message).to.equal('stat error')
						expect(isFresh).to.not.exist
						done()

			describe 'given it was created before the cache time', ->

				beforeEach ->
					@dateNowStub = sinon.stub(Date, 'now')
					@dateNowStub.returns(1000000000000)

					@fsStatsStub = sinon.stub(fs, 'stat')
					@fsStatsStub.yields null,
						ctime: new Date(Date.now() - settings.cacheTime + 1)

				afterEach ->
					@dateNowStub.restore()
					@fsStatsStub.restore()

				it 'should return true', (done) ->
					cache.isImageFresh
						slug: 'raspberry-pi'
					, (error, isFresh) ->
						expect(error).to.not.exist
						expect(isFresh).to.be.true
						done()

			describe 'given it was created after the cache time', ->

				beforeEach ->
					@dateNowStub = sinon.stub(Date, 'now')
					@dateNowStub.returns(1000000000000)

					@fsStatsStub = sinon.stub(fs, 'stat')
					@fsStatsStub.yields null,
						ctime: new Date(Date.now() - settings.cacheTime - 1)

				afterEach ->
					@dateNowStub.restore()
					@fsStatsStub.restore()

				it 'should return false', (done) ->
					cache.isImageFresh
						slug: 'raspberry-pi'
					, (error, isFresh) ->
						expect(error).to.not.exist
						expect(isFresh).to.be.false
						done()

			describe 'given it was created just at the cache time', ->

				beforeEach ->
					@dateNowStub = sinon.stub(Date, 'now')
					@dateNowStub.returns(1000000000000)

					@fsStatsStub = sinon.stub(fs, 'stat')
					@fsStatsStub.yields null,
						ctime: new Date(Date.now() - settings.cacheTime)

				afterEach ->
					@dateNowStub.restore()
					@fsStatsStub.restore()

				it 'should return false', (done) ->
					cache.isImageFresh
						slug: 'raspberry-pi'
					, (error, isFresh) ->
						expect(error).to.not.exist
						expect(isFresh).to.be.false
						done()
