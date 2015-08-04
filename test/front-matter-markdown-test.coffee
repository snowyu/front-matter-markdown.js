chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
assert          = chai.assert
chai.use(sinonChai)


#loadConfig      = require '../src/'

describe 'frontMatterMarkdown', ->
  it 'should add a config file name', ->
