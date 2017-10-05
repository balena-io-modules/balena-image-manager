m = require('mochainon')
Promise = require('bluebird')
path = require('path')
fs = Promise.promisifyAll(require('fs'))
WritableStream = require('stream').Writable
os = require('os')
tmp = require('tmp')
mockFs = require('mock-fs')
stringToStream = require('string-to-stream')
resin = require('resin-sdk-preconfigured')

cache = require('../build/cache')
utils = require('../build/utils')

describe 'Cache:', ->

	describe '.getImagePath()', ->

		describe 'given a cache directory', ->

			beforeEach ->
				@resinSettingsGetStub = m.sinon.stub(resin.settings, 'get')

				if os.platform() is 'win32'
					@resinSettingsGetStub
						.withArgs('cacheDirectory')
						.returns(Promise.resolve('C:\\Users\\johndoe\\_resin\\cache'))
				else
					@resinSettingsGetStub
						.withArgs('cacheDirectory')
						.returns(Promise.resolve('/Users/johndoe/.resin/cache'))

			afterEach ->
				@resinSettingsGetStub.restore()

			describe 'given valid slugs', ->

				beforeEach ->
					@getManifestBySlugStub = m.sinon.stub(resin.models.device, 'getManifestBySlug')
					@getManifestBySlugStub.withArgs('raspberry-pi').returns Promise.resolve
						yocto:
							fstype: 'resin-sdcard'

					@getManifestBySlugStub.withArgs('intel-edison').returns Promise.resolve
						yocto:
							fstype: 'zip'

				afterEach ->
					@getManifestBySlugStub.restore()

				it 'should eventually equal an absolute path', ->
					cache.getImagePath('raspberry-pi', '1.2.3').then (imagePath) ->
						isAbsolute = imagePath is path.resolve(imagePath)
						m.chai.expect(isAbsolute).to.be.true

				it 'should eventually equal the correct path', ->
					promise = cache.getImagePath('raspberry-pi', '1.2.3')
					if os.platform() is 'win32'
						imagePath = 'C:\\Users\\johndoe\\_resin\\cache\\raspberry-pi-v1.2.3.img'
						m.chai.expect(promise).to.eventually.equal(imagePath)
					else
						imagePath = '/Users/johndoe/.resin/cache/raspberry-pi-v1.2.3.img'
						m.chai.expect(promise).to.eventually.equal(imagePath)

				it 'should use a zip extension for directory images', ->
					cache.getImagePath('intel-edison', '1.2.3')
					.then (imagePath) ->
						m.chai.expect(path.extname(imagePath)).to.equal('.zip')

				it 'given invalid version should be rejected', ->
					promise = cache.getImagePath('intel-edison', 'DOUGH')
					m.chai.expect(promise).to.be.eventually.rejectedWith('Invalid version number')

	describe '.isImageFresh()', ->

		describe 'given the raspberry-pi manifest', ->

			beforeEach ->
				@getManifestBySlugStub = m.sinon.stub(resin.models.device, 'getManifestBySlug')
				@getManifestBySlugStub.returns Promise.resolve
					yocto:
						fstype: 'resin-sdcard'

			afterEach ->
				@getManifestBySlugStub.restore()

			describe 'given the file does not exist', ->

				beforeEach ->
					@utilsGetFileCreatedDate = m.sinon.stub(utils, 'getFileCreatedDate')
					@utilsGetFileCreatedDate.returns(Promise.reject(new Error('ENOENT, stat \'raspberry-pi\'')).catch -> return)

				afterEach ->
					@utilsGetFileCreatedDate.restore()

				it 'should return false', ->
					promise = cache.isImageFresh('raspberry-pi', '1.2.3')
					m.chai.expect(promise).to.eventually.be.false

			describe 'given a fixed created time', ->

				beforeEach ->
					@utilsGetFileCreatedDate = m.sinon.stub(utils, 'getFileCreatedDate')
					@utilsGetFileCreatedDate.returns(Promise.resolve(new Date('2014-01-01T00:00:00.000Z')))

				afterEach ->
					@utilsGetFileCreatedDate.restore()

				describe 'given the file was created before the os last modified time', ->

					beforeEach ->
						@osGetLastModified = m.sinon.stub(resin.models.os, 'getLastModified')
						@osGetLastModified.returns(Promise.resolve(new Date('2014-02-01T00:00:00.000Z')))

					afterEach ->
						@osGetLastModified.restore()

					it 'should return false', ->
						promise = cache.isImageFresh('raspberry-pi', '1.2.3')
						m.chai.expect(promise).to.eventually.be.false

				describe 'given the file was created after the os last modified time', ->

					beforeEach ->
						@osGetLastModified = m.sinon.stub(resin.models.os, 'getLastModified')
						@osGetLastModified.returns(Promise.resolve(new Date('2013-01-01T00:00:00.000Z')))

					afterEach ->
						@osGetLastModified.restore()

					it 'should return true', ->
						promise = cache.isImageFresh('raspberry-pi', '1.2.3')
						m.chai.expect(promise).to.eventually.be.true

				describe 'given the file was created just at the os last modified time', ->

					beforeEach ->
						@osGetLastModified = m.sinon.stub(resin.models.os, 'getLastModified')
						@osGetLastModified.returns(Promise.resolve(new Date('2014-00-01T00:00:00.000Z')))

					afterEach ->
						@osGetLastModified.restore()

					it 'should return false', ->
						promise = cache.isImageFresh('raspberry-pi', '1.2.3')
						m.chai.expect(promise).to.eventually.be.false

	describe '.getImage()', ->

		describe 'given an existing image', ->

			beforeEach ->
				@image = tmp.fileSync()
				fs.writeSync(@image.fd, 'Lorem ipsum dolor sit amet', 0, 'utf8')

				@cacheGetImagePathStub = m.sinon.stub(cache, 'getImagePath')
				@cacheGetImagePathStub.returns(Promise.resolve(@image.name))

			afterEach (done) ->
				@cacheGetImagePathStub.restore()
				fs.unlink(@image.name, done)

			it 'should return a stream to the image', (done) ->
				cache.getImage('lorem-ipsum', '1.2.3').then (stream) ->
					result = ''

					stream.on 'data', (chunk) ->
						result += chunk

					stream.on 'end', ->
						m.chai.expect(result).to.equal('Lorem ipsum dolor sit amet')
						done()

				return

			it 'should contain the mime property', ->
				cache.getImage('lorem-ipsum', '1.2.3')
				.then (stream) ->
					m.chai.expect(stream.mime).to.equal('application/octet-stream')

	describe '.getImageWritableStream()', ->

		describe 'given the valid image path', ->

			beforeEach ->
				@image = tmp.fileSync()
				@cacheGetImagePathStub = m.sinon.stub(cache, 'getImagePath')
				@cacheGetImagePathStub.returns(Promise.resolve(@image.name))

			afterEach (done) ->
				@cacheGetImagePathStub.restore()
				fs.unlink(@image.name, done)

			it 'should return a writable stream', ->
				cache.getImageWritableStream('raspberry-pi', '1.2.3')
				.then (stream) ->
					m.chai.expect(stream).to.be.an.instanceof(WritableStream)

			it 'should allow writing to the stream', (done) ->
				cache.getImageWritableStream('raspberry-pi', '1.2.3').then (stream) =>
					stringStream = stringToStream('Lorem ipsum dolor sit amet')
					stringStream.pipe(stream)
					stream.on 'finish', =>
						stream.persistCache()
						fs.readFileAsync(@image.name, encoding: 'utf8').then (contents) ->
							m.chai.expect(contents).to.equal('Lorem ipsum dolor sit amet')
							done()
				return

	describe '.clean()', ->

		describe 'given the cache with saved images', ->

			beforeEach ->
				resin.settings.get('cacheDirectory')
				.then (cacheDirectory) =>
					@cacheDirectory = cacheDirectory
					mockFs
						"#{@cacheDirectory}":
							'raspberry-pi': 'Raspberry Pi Image'
							'intel-edison': 'Intel Edison Image'
							'parallela': 'Parallela Image'

			afterEach ->
				mockFs.restore()

			it 'should remove the cache directory completely', (done) ->
				fs.exists @cacheDirectory, (exists) =>
					m.chai.expect(exists).to.be.true
					promise = cache.clean()
					m.chai.expect(promise).to.not.be.rejected
					promise.then =>
						fs.exists @cacheDirectory, (exists) ->
							m.chai.expect(exists).to.be.false
							done()

		describe 'given no cache', ->

			beforeEach ->
				resin.settings.get('cacheDirectory').then (cacheDirectory) =>
					@cacheDirectory = cacheDirectory
					mockFs({})

			afterEach ->
				mockFs.restore()

			it 'should keep the cache directory removed', (done) ->
				fs.exists @cacheDirectory, (exists) =>
					m.chai.expect(exists).to.be.false
					promise = cache.clean()
					m.chai.expect(promise).to.not.be.rejected
					promise.then =>
						fs.exists @cacheDirectory, (exists) ->
							m.chai.expect(exists).to.be.false
							done()
