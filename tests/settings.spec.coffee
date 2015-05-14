path = require('path')
chai = require('chai')
expect = chai.expect
settings = require('../lib/settings')

describe 'Settings:', ->

	describe '.cacheDirectory', ->

		it 'should be a string', ->
			expect(settings.cacheDirectory).to.be.a('string')

		it 'should not be empty', ->
			expect(settings.cacheDirectory.trim()).to.not.have.length(0)

		it 'should be an absolute path', ->
			isAbsolute = (input) ->
				return path.resolve(input) is path.normalize(input)

			expect(isAbsolute(settings.cacheDirectory)).to.be.true

	describe '.cacheTime', ->

		it 'should be a number', ->
			expect(settings.cacheTime).to.be.a('number')

		it 'should be a positive number', ->
			expect(settings.cacheTime > 0).to.be.true
