m = require('mochainon')
fs = require('fs')

utils = require('../build/utils')

describe 'Utils:', ->

	describe '.getFileCreatedDate()', ->

		describe 'given the file exists', ->

			beforeEach ->
				@date = new Date(2014, 1, 1)
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(null, ctime: @date)

			afterEach ->
				@fsStatStub.restore()

			it 'should eventually equal the created time in milliseconds', ->
				promise = utils.getFileCreatedDate('foo')
				m.chai.expect(promise).to.eventually.equal(@date)

		describe 'given the file does not exist', ->

			beforeEach ->
				@fsStatStub = m.sinon.stub(fs, 'stat')
				@fsStatStub.withArgs('foo').yields(new Error('ENOENT, stat \'foo\''))

			afterEach ->
				@fsStatStub.restore()

			it 'should be rejected with an error', ->
				promise = utils.getFileCreatedDate('foo')
				m.chai.expect(promise).to.be.rejectedWith('ENOENT')
