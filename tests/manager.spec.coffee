m = require('mochainon')
_ = require('lodash')
path = require('path')
tmp = require('tmp')
PassThrough = require('stream').PassThrough
Promise = require('bluebird')
rimraf = Promise.promisify(require('rimraf'))
fs = Promise.promisifyAll(require('fs'))
stringToStream = require('string-to-stream')
manager = require('../lib/manager')
cache = require('../lib/cache')
image = require('../lib/image')

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
						@imageDownloadStub = m.sinon.stub(image, 'download')
						@imageDownloadStub.returns(Promise.resolve(stringToStream('Download image')))

					afterEach ->
						@imageDownloadStub.restore()

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

				describe 'given a stream with a length property', ->

					beforeEach ->
						@imageDownloadStub = m.sinon.stub(image, 'download')
						message = 'Lorem ipsum dolor sit amet'
						stream = stringToStream(message)
						stream.length = message.length
						@imageDownloadStub.returns(Promise.resolve(stream))

					afterEach ->
						@imageDownloadStub.restore()

					it 'should preserve the property', (done) ->
						manager.get('raspberry-pi').then (stream) ->
							m.chai.expect(stream.length).to.equal(26)
						.nodeify(done)

				describe 'given a stream with a mime property', ->

					beforeEach ->
						@imageDownloadStub = m.sinon.stub(image, 'download')
						message = 'Lorem ipsum dolor sit amet'
						stream = stringToStream(message)
						stream.mime = 'application/zip'
						@imageDownloadStub.returns(Promise.resolve(stream))

					afterEach ->
						@imageDownloadStub.restore()

					it 'should preserve the property', (done) ->
						manager.get('raspberry-pi').then (stream) ->
							m.chai.expect(stream.mime).to.equal('application/zip')
						.nodeify(done)

	describe '.pipeTemporal()', ->

		describe 'given a plain text stream', ->

			beforeEach ->
				@stream = fs.createReadStream(path.join(__dirname, 'fixtures', 'lorem.txt'))
				@stream.mime = 'text/plain'

			it 'should copy the contents to a temporary file', (done) ->
				manager.pipeTemporal(@stream).then (temporalPath) ->
					fs.readFileAsync(temporalPath, encoding: 'utf8').then (contents) ->
						contents = contents.trim(/[\n\r]/, '')
						m.chai.expect(contents).to.equal('Lorem ipsum dolor sit amet')
						fs.unlinkAsync(temporalPath)
				.nodeify(done)

		describe 'given a zip archive containing a single file', ->

			beforeEach ->
				@stream = fs.createReadStream(path.join(__dirname, 'fixtures', 'lorem.zip'))
				@stream.mime = 'application/zip'

			it 'should extract the contents to a temporary directory', (done) ->
				manager.pipeTemporal(@stream).then (temporalPath) ->
					file = path.join(temporalPath, 'lorem.txt')
					fs.readFileAsync(file, encoding: 'utf8').then (contents) ->
						contents = contents.trim(/[\n\r]/, '')
						m.chai.expect(contents).to.equal('Lorem ipsum dolor sit amet')
						rimraf(temporalPath)
				.nodeify(done)
