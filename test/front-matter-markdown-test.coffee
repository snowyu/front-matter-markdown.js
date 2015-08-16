chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
assert          = chai.assert
chai.use(sinonChai)


config      = require '../src/'

describe 'frontMatterMarkdown', ->
  it 'should get config object from a simple markdown string without any toc info', ->
    s = """
    ---
    config: file0
    ---

    this file0.
    """
    actural = config s
    expected =
      'config': 'file0'
      'skipSize': 22
    assert.deepEqual actural, expected
  it 'should get config object with inline options', ->
    s = """
    ---
    config: file0
    toc: false
    headingsAsToc: false
    heading: 'table of content'
    ---

    this file0.

    # table of content

    * [Directory](./dir1)
      * [Directory2](/dir2)
    * [Directory3](#inline)
    """
    actural = config s
    expected =
      'config': 'file0'
      toc: false
      headingsAsToc: false
      heading: 'table of content'
      'skipSize': 82
    assert.deepEqual actural, expected
  it 'should get config object from markdown string and disable directoy', ->
    actural = config mkdn, toc:false, headingsAsToc: false
    expected =
      'config1': 123
      'skipSize': 21
    assert.deepEqual actural, expected
    actural.should.have.ownProperty 'content'
    actural.should.have.ownProperty '$compiled'
    actural.should.have.property 'skipSize', 21
  it 'should get config object from markdown string and disable directoy and content', ->
    actural = config mkdn, toc:false, headingsAsToc: false, content:false
    expected =
      'config1': 123
      'skipSize': 21
    assert.deepEqual actural, expected
    actural.should.not.have.ownProperty 'content'
    actural.should.not.have.ownProperty '$compiled'
  it 'should get config object from markdown string and disable toc heading', ->
    actural = config mkdn, toc:false
    expected =
      'config1': 123
      'skipSize': 21
      'contents': [
        title: 'Heading1'
      ]
    assert.deepEqual actural, expected

  it 'should get config object from markdown string with summary heading', ->
    actural = config(mkdn)
    expected =
      'config1': 123
      'skipSize': 21
      'ordered': false
      'contents': [
        {
          'title': 'Dir1'
          'path': './dir1'
        }
        {
          'title': 'Dir2'
          'contents': [
            { 'title': 'Dir21' }
            { 'title': 'Dir22' }
          ]
          'path': './dir2'
          'ordered': false
        }
        { 'title': 'Dir3' }
      ]
    assert.deepEqual actural, expected
  it 'should get config object from markdown string with no summary heading', ->
    actural = config(mkdn2)
    expected =
      'config1': 123
      'skipSize': 21
      'contents': [
        { 'title': 'Heading1' }
        {
          'title': 'Heading2'
          'path': './heading2'
          'contents': [
            {
              'title': 'Heading21'
              'path': './heading21'
            }
            {
              'title': 'Heading22'
              'path': './heading22'
              'contents': [ {
                'title': 'Heading221'
                'path': './heading221'
              } ]
            }
          ]
        }
      ]
    assert.deepEqual actural, expected
    #console.log JSON.stringify actural



mkdn = """
---
config1: 123
---
# Summary

* [Dir1](./dir1)
* [Dir2][dir2]
  * Dir21
  * Dir22
* Dir3

# Heading1

heading1End

[dir2]: ./dir2
"""

mkdn2 = """
---
config1: 123
---
# Heading1

heading1End

# [Heading2][Heading2]

heading2End

## [Heading21][Heading21]

heading21End

## [Heading22][Heading22]

heading22End

### [Heading221][Heading221]

heading221End

#### Nothong

[dir2]: ./dir2
[Heading2]: ./heading2
[Heading21]: ./heading21
[Heading221]: ./heading221
[Heading22]: ./heading22
"""
