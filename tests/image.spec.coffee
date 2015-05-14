resin = require('resin-sdk')
path = require('path')
_ = require('lodash')
fs = require('fs')
mockFs = require('mock-fs')
chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
image = require('../lib/image')
settings = require('../lib/settings')

describe 'Image:', ->

	describe '.getOSParams()', ->

		describe 'given there was an error fetching the applications', ->

			beforeEach ->
				@applicationGetAllStub = sinon.stub(resin.models.application, 'getAll')
				@applicationGetAllStub.yields(new Error('resin error'))

			afterEach ->
				@applicationGetAllStub.restore()

			it 'should return the error', (done) ->
				image.getOSParams 'raspberry-pi', (error, params) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('resin error')
					expect(params).to.not.exist
					done()

		describe 'given the user has applications', ->

			beforeEach ->
				@applicationGetAllStub = sinon.stub(resin.models.application, 'getAll')
				@applicationGetAllStub.yields null, [
					{	id: 1, device_type: 'raspberry-pi' }
					{	id: 2, device_type: 'intel-edison' }
				]

			afterEach ->
				@applicationGetAllStub.restore()

			describe 'given the user has the device type', ->

				it 'should default network to "ethernet"', (done) ->
					image.getOSParams 'raspberry-pi', (error, params) ->
						expect(error).to.not.exist
						expect(params.network).to.equal('ethernet')
						done()

				it 'should return the correct appId', (done) ->
					image.getOSParams 'raspberry-pi', (error, params) ->
						expect(error).to.not.exist
						expect(params.appId).to.equal(1)
						done()

			describe 'given the user does not have the device type', ->

				it 'should return an error', (done) ->
					image.getOSParams 'foobar', (error, params) ->
						expect(error).to.be.an.instanceof(Error)
						expect(error.message).to.equal('Unknown device type: foobar')
						expect(params).to.not.exist
						done()

	describe '.download()', ->

		describe 'given an error when fetching the params', ->

			beforeEach ->
				@imageGetOsParamsStub = sinon.stub(image, 'getOSParams')
				@imageGetOsParamsStub.yields(new Error('params error'))

			afterEach ->
				@imageGetOsParamsStub.restore()

			it 'should return the error', (done) ->
				image.download 'raspberry-pi', 'foo/bar.img', (error, output) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('params error')
					expect(output).to.not.exist
					done()
				, _.noop

		describe 'given correct params', ->

			beforeEach ->
				@imageGetOsParamsStub = sinon.stub(image, 'getOSParams')
				@imageGetOsParamsStub.yields(null, { network: 'ethernet', appId: 3 })

			afterEach ->
				@imageGetOsParamsStub.restore()

			describe 'given we are able to download the image', ->

				beforeEach ->
					mockFs()

					@osDownloadCopy = resin.models.os.download
					resin.models.os.download = (params, output, callback) ->
						fs.writeFile output, 'download mock', (error) ->
							return callback(error) if error?
							return callback(null, output)

				afterEach ->
					resin.models.os.download = @osDownloadCopy
					mockFs.restore()

				it 'should download an image', (done) ->

					destination = path.join(settings.cacheDirectory, 'rpi.img')

					image.download 'raspberry-pi', destination, (error, output) ->
						expect(output).to.equal(destination)
						fs.readFile output, encoding: 'utf8', (error, contents) ->
							expect(error).to.not.exist
							expect(contents).to.equal('download mock')
							done()
					, _.noop
