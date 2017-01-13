m = require('mochainon')
resin = require('resin-sdk-preconfigured')
path = require('path')
tmp = require('tmp')
PassThrough = require('stream').PassThrough
Promise = require('bluebird')
rimraf = Promise.promisify(require('rimraf'))
fs = Promise.promisifyAll(require('fs'))
stringToStream = require('string-to-stream')
manager = require('../lib/manager')
cache = require('../lib/cache')

describe 'Manager:', ->

	describe '.get()', ->

		describe 'given an existent image', ->

			beforeEach ->
				@image = tmp.fileSync()
				fs.writeSync(@image.fd, 'Cache image', 0, 'utf8')

				@cacheGetImagePathStub = m.sinon.stub(cache, 'getImagePath')
				@cacheGetImagePathStub.returns(Promise.resolve(@image.name))

			afterEach ->
				@cacheGetImagePathStub.restore()
				@image.removeCallback()

			describe 'given the image is fresh', ->

				beforeEach ->
					@cacheIsImageFresh = m.sinon.stub(cache, 'isImageFresh')
					@cacheIsImageFresh.returns(Promise.resolve(true))

				afterEach ->
					@cacheIsImageFresh.restore()

				it 'should eventually become a readable stream of the cached image', (done) ->
					manager.get('raspberry-pi').then (stream) ->
						result = ''

						stream.on 'data', (chunk) ->
							result += chunk

						stream.on 'end', ->
							m.chai.expect(result).to.equal('Cache image')
							done()

			describe 'given the image is not fresh', ->

				beforeEach ->
					@cacheIsImageFresh = m.sinon.stub(cache, 'isImageFresh')
					@cacheIsImageFresh.returns(Promise.resolve(false))

				afterEach ->
					@cacheIsImageFresh.restore()

				describe 'given a valid download endpoint', ->

					beforeEach ->
						@osDownloadStub = m.sinon.stub(resin.models.os, 'download')
						@osDownloadStub.returns(Promise.resolve(stringToStream('Download image')))

					afterEach ->
						@osDownloadStub.restore()

					it 'should eventually become a readable stream of the download image and save a backup copy', (done) ->
						manager.get('raspberry-pi').then (stream) =>
							result = ''

							stream.on 'data', (chunk) ->
								result += chunk

							stream.on 'end', =>
								m.chai.expect(result).to.equal('Download image')

								fs.readFileAsync(@image.name, encoding: 'utf8').then (contents) ->
									m.chai.expect(contents).to.equal('Download image')
									done()

					it 'should be able to read from the stream after a slight delay', (done) ->
						manager.get('raspberry-pi').then (stream) ->
							Promise.delay(200).return(stream)
						.then (stream) ->
							pass = new PassThrough()
							stream.pipe(pass)

							result = ''

							pass.on 'data', (chunk) ->
								result += chunk

							pass.on 'end', ->
								m.chai.expect(result).to.equal('Download image')
								done()

				describe 'given a stream with a mime property', ->

					beforeEach ->
						@osDownloadStub = m.sinon.stub(resin.models.os, 'download')
						message = 'Lorem ipsum dolor sit amet'
						stream = stringToStream(message)
						stream.mime = 'application/zip'
						@osDownloadStub.returns(Promise.resolve(stream))

					afterEach ->
						@osDownloadStub.restore()

					it 'should preserve the property', (done) ->
						manager.get('raspberry-pi').then (stream) ->
							m.chai.expect(stream.mime).to.equal('application/zip')
						.nodeify(done)
