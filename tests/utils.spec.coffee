path = require('path')
fs = require('fs')
fse = require('fs-extra')
chai = require('chai')
expect = chai.expect
sinon = require('sinon')
chai.use(require('sinon-chai'))
mockFs = require('mock-fs')
utils = require('../lib/utils')

describe 'Utils:', ->

	describe '.copy()', ->

		describe 'given there was an error when copying the file', ->

			beforeEach ->
				@fsExtraCopyStub = sinon.stub(fse, 'copy')
				@fsExtraCopyStub.yields(new Error('copy error'))

			afterEach ->
				@fsExtraCopyStub.restore()

			it 'should return the same error', (done) ->
				utils.copy 'foo', 'bar', (error, destination) ->
					expect(error).to.be.an.instanceof(Error)
					expect(error.message).to.equal('copy error')
					expect(destination).to.not.exist
					done()

		describe 'given there was no error when copying the file', ->

			beforeEach ->
				@fsExtraCopyStub = sinon.stub(fse, 'copy')
				@fsExtraCopyStub.yields(null)

			afterEach ->
				@fsExtraCopyStub.restore()

			it 'should return back the destination', (done) ->
				utils.copy 'foo', 'bar', (error, destination) ->
					expect(error).to.not.exist
					expect(destination).to.equal('bar')
					done()

	describe '.generateTemporalImagePath()', ->

		it 'should yield a string', (done) ->
			utils.generateTemporalImagePath (error, imagePath) ->
				expect(error).to.not.exist
				expect(imagePath).to.be.a('string')
				done()

		it 'should be an absolute path', (done) ->
			isAbsolute = (input) ->
				return path.resolve(input) is path.normalize(input)

			utils.generateTemporalImagePath (error, imagePath) ->
				expect(error).to.not.exist
				expect(isAbsolute(imagePath)).to.be.true
				done()

		it 'should have a prefix equal to resin-image-', (done) ->
			utils.generateTemporalImagePath (error, imagePath) ->
				expect(error).to.not.exist
				basename = path.basename(imagePath)
				expect(basename.indexOf('resin-image-')).to.equal(0)
				done()

		it 'should have an extension of .img', (done) ->
			utils.generateTemporalImagePath (error, imagePath) ->
				expect(error).to.not.exist
				expect(path.extname(imagePath)).to.equal('.img')
				done()

	describe '.getUnlinkFunction()', ->

		it 'should return a function', ->
			unlinkFn = utils.getUnlinkFunction('foo')
			expect(unlinkFn).to.be.a('function')

		it 'should return a function that unlinks the file', (done) ->
			mockFs
				'foo/bar.txt': 'hello'

			# mock-fs only mocks the real fs, not fs-extra
			# therefore we must use fs in this test.

			fs.exists 'foo/bar.txt', (exists) ->
				expect(exists).to.be.true

				unlinkFn = utils.getUnlinkFunction('foo/bar.txt')
				unlinkFn (error) ->
					expect(error).to.not.exist

					fs.exists 'foo/bar.txt', (exists) ->
						expect(exists).to.be.false
						mockFs.restore()
						done()
