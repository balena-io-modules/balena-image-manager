m = require('mochainon')
Promise = require('bluebird')
nock = require('nock')
resin = require('resin-sdk')
fixtures = require('./fixtures/tokens.json')
image = require('../lib/image')

describe 'Image:', ->

	describe '.getOSParameters()', ->

		describe 'given the user has applications', ->

			beforeEach ->
				@resinApplicationGetAllStub = m.sinon.stub(resin.models.application, 'getAll')
				@resinApplicationGetAllStub.returns Promise.resolve [
					{ id: 1, device_type: 'raspberry-pi' }
					{ id: 2, device_type: 'intel-edison' }
					{ id: 3, device_type: 'parallella' }
				]

			afterEach ->
				@resinApplicationGetAllStub.restore()

			describe 'given it does have an app of the required type', ->

				beforeEach ->
					@deviceType = 'raspberry-pi'

				it 'should eventually return the correct os parameters', ->
					promise = image.getOSParameters(@deviceType)
					m.chai.expect(promise).to.eventually.become
						network: 'ethernet'
						appId: 1

			describe 'given it does not have an app of the required type', ->

				beforeEach ->
					@deviceType = 'foo'

				it 'should be rejected with an error message', ->
					promise = image.getOSParameters(@deviceType)
					m.chai.expect(promise).to.be.rejectedWith("Unknown device type: #{@deviceType}")

			describe 'given a raspberry pi device type', ->

				beforeEach ->
					@deviceType = 'raspberry-pi'

				it 'should contain all required parameters', ->
					promise = image.getOSParameters(@deviceType)
					m.chai.expect(promise).to.become
						appId: 1
						network: 'ethernet'

			describe 'given an edison device type', ->

				beforeEach ->
					@deviceType = 'intel-edison'

				it 'should contain all required parameters', ->
					promise = image.getOSParameters(@deviceType)
					m.chai.expect(promise).to.become
						appId: 2
						network: 'wifi'
						wifiSsid: 'ssid'
						wifiKey: 'key'

			describe 'given a parallella device type', ->

				beforeEach ->
					@deviceType = 'parallella'

				it 'should contain all required parameters', ->
					promise = image.getOSParameters(@deviceType)
					m.chai.expect(promise).to.become
						appId: 3
						network: 'ethernet'
						processorType: 'Z7010'
						coprocessorCore: '16'

	describe '.download()', ->

		describe 'given the user has applications', ->

			beforeEach ->
				@resinApplicationGetAllStub = m.sinon.stub(resin.models.application, 'getAll')
				@resinApplicationGetAllStub.returns Promise.resolve [
					{ id: 1, device_type: 'raspberry-pi' }
				]

			afterEach ->
				@resinApplicationGetAllStub.restore()

			describe 'given the desired device type is not valid', ->

				it 'should be rejected with an error message', ->
					promise = image.download('parallela')
					m.chai.expect(promise).to.be.rejectedWith('Unknown device type: parallela')

			describe 'given the desired device type is valid', ->

				describe 'given an always valid whoami endpoint', ->

					beforeEach (done) ->
						resin.settings.get('apiUrl').then (apiUrl) ->
							nock(apiUrl).get('/whoami')
								.reply(200, fixtures.johndoe.token)
							done()

					afterEach ->
						nock.cleanAll()

					describe 'given a valid download endpoint', ->

						beforeEach (done) ->
							resin.settings.get('apiUrl').then (apiUrl) ->
								nock(apiUrl).get('/download?network=ethernet&appId=1')
									.reply(200, 'Lorem ipsum dolor sit amet')
								done()

						afterEach ->
							nock.cleanAll()

						it 'should stream the download', (done) ->
							image.download('raspberry-pi').then (stream) ->
								result = ''

								stream.on 'data', (chunk) ->
									result += chunk

								stream.on 'end', ->
									m.chai.expect(result).to.equal('Lorem ipsum dolor sit amet')
									done()

					describe 'given an invalid download endpoint', ->

						beforeEach (done) ->
							resin.settings.get('apiUrl').then (apiUrl) ->
								nock(apiUrl).get('/download?network=ethernet&appId=1')
									.reply(400, 'Invalid application id')
								done()

						afterEach ->
							nock.cleanAll()

						it 'should be rejected with an error message', ->
							promise = image.download('raspberry-pi')
							m.chai.expect(promise).to.be.rejectedWith('Invalid application id')
