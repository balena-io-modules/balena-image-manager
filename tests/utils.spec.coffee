m = require('mochainon')
EventEmitter = require('events').EventEmitter
Promise = require('bluebird')
path = require('path')
fs = require('fs')
utils = require('../lib/utils')

describe 'Utils:', ->

	describe '.getFileSize()', ->

		describe 'given the file exists', ->

			beforeEach ->
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(null, size: 512)

			afterEach ->
				@fsStatStub.restore()

			it 'should eventually equal the size', ->
				promise = utils.getFileSize('foo')
				m.chai.expect(promise).to.eventually.equal(512)

		describe 'given the file does not exist', ->

			beforeEach ->
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(new Error('ENOENT, stat \'foo\''))

			afterEach ->
				@fsStatStub.restore()

			it 'should be rejected with an error', ->
				promise = utils.getFileSize('foo')
				m.chai.expect(promise).to.be.rejectedWith('ENOENT')

	describe '.getFileCreatedTime()', ->

		describe 'given the file exists', ->

			beforeEach ->
				@date = new Date(2014, 1, 1)
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(null, ctime: @date)

			afterEach ->
				@fsStatStub.restore()

			it 'should eventually equal the created time in milliseconds', ->
				promise = utils.getFileCreatedTime('foo')
				m.chai.expect(promise).to.eventually.equal(@date.getTime())

		describe 'given the file does not exist', ->

			beforeEach ->
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(new Error('ENOENT, stat \'foo\''))

			afterEach ->
				@fsStatStub.restore()

			it 'should be rejected with an error', ->
				promise = utils.getFileCreatedTime('foo')
				m.chai.expect(promise).to.be.rejectedWith('ENOENT')

	describe '.getTemporalPath()', ->

		it 'should return an absolute path', (done) ->
			isAbsolute = (filePath) ->
				path.resolve(filePath) is path.normalize(filePath)

			utils.getTemporalPath().then (temporal) ->
				m.chai.expect(isAbsolute(temporal)).to.be.true
			.nodeify(done)

		it 'should always return different paths', (done) ->
			Promise.props
				first: utils.getTemporalPath()
				second: utils.getTemporalPath()
				third: utils.getTemporalPath()
			.then (temporals) ->
				m.chai.expect(temporals.first).to.not.equal(temporals.second)
				m.chai.expect(temporals.second).to.not.equal(temporals.third)
				m.chai.expect(temporals.third).to.not.equal(temporals.first)
			.nodeify(done)

	describe '.waitStream()', ->

		describe 'given a stream that emits a close event', ->

			beforeEach ->
				@stream = new EventEmitter()
				setTimeout =>
					@stream.emit('close')
				, 100

			it 'should resolve the promise', ->
				promise = utils.waitStream(@stream)
				m.chai.expect(promise).to.be.fulfilled

		describe 'given a stream that emits an error event', ->

			beforeEach ->
				@stream = new EventEmitter()
				setTimeout =>
					@stream.emit('error', new Error('Hello World'))
				, 100

			it 'should be rejected with the error', ->
				promise = utils.waitStream(@stream)
				m.chai.expect(promise).to.be.rejectedWith('Hello World')
