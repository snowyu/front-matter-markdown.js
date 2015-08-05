chai            = require 'chai'
sinon           = require 'sinon'
sinonChai       = require 'sinon-chai'
should          = chai.should()
expect          = chai.expect
assert          = chai.assert
chai.use(sinonChai)


extend            = require 'util-ex/lib/_extend'
markdown          = require('../src/markdown')
skipSpace         = require '../src/markdown/skip-space'
getHeadingSection = require('../src/markdown/get-heading-section')
getListSection    = require('../src/markdown/get-list-section')
AstParser         = require('../src/markdown/ast-parser')
list2FileObject   = require('../src/markdown/ast-list-to-file-object')
getTocFromHeading = require('../src/markdown/get-toc-from-heading')

describe 'Markdown', ->
  describe 'skipSpace', ->
    it 'should skip space', ->
      result = [
        {type:'a'}
        {type: 'space'}
        {type:'b'}
        {type: 'space'}, {type: 'space'}
        {type:'c'}, 123
      ]
      actural = skipSpace result
      expected= [
        {type:'a'}
        {type:'b'}
        {type:'c'}, 123
      ]
      assert.deepEqual actural, expected

  describe 'getHeadingSection', ->
    it 'should get first heading section if no headings', ->
      actural = getHeadingSection markdown.lexer mkdn
      should.exist actural
      heading = actural[0]
      should.exist heading
      heading.should.have.property 'type', 'heading'
      heading.should.have.property 'depth', 3
      heading.should.have.property 'text', 'heading1'
      actural.pop().should.have.property 'text', 'heading1End'

      actural = getHeadingSection markdown.lexer '### heading1'
      should.exist actural, 'actural'
      actural.should.have.length 1
      heading = actural[0]
      should.exist heading, 'heading'
      heading.should.have.property 'type', 'heading'
      heading.should.have.property 'depth', 3
      heading.should.have.property 'text', 'heading1'
    it 'should get specified heading section via case-sensitive heading name', ->
      actural = getHeadingSection markdown.lexer(mkdn), 'Heading2', true
      should.not.exist actural
      actural = getHeadingSection markdown.lexer(mkdn), /summary/, true
      should.not.exist actural
    it 'should get specified heading section via heading name', ->
      actural = getHeadingSection markdown.lexer(mkdn), 'heading2'
      should.exist actural
      heading = actural[0]
      should.exist heading
      heading.should.have.property 'type', 'heading'
      heading.should.have.property 'depth', 1
      heading.should.have.property 'text', 'heading2'
      actural.pop().should.have.property 'text', 'heading2End'
      actural = getHeadingSection markdown.lexer(mkdn), 'headingNone'
      should.not.exist actural
    it 'should get specified heading section via heading list', ->
      actural = getHeadingSection markdown.lexer(mkdn), ['summary', 'toc']
      should.exist actural
      heading = actural[0]
      should.exist heading
      heading.should.have.property 'type', 'heading'
      heading.should.have.property 'depth', 2
      heading.should.have.property 'text', 'Summary'
      actural.pop().should.have.property 'text', 'summaryEnd'
    it 'should get specified heading section via regexp', ->
      actural = getHeadingSection markdown.lexer(mkdn), /Summary/
      should.exist actural
      heading = actural[0]
      should.exist heading
      heading.should.have.property 'type', 'heading'
      heading.should.have.property 'depth', 2
      heading.should.have.property 'text', 'Summary'
      actural.pop().should.have.property 'text', 'summaryEnd'

  describe 'getListSection', ->
    it 'should return undefined if no specified list', ->
      actural = getListSection markdown.lexer(mkdn), 5
      should.not.exist actural, 'actural'
    it 'should get first list section via default', ->
      actural = getListSection markdown.lexer(mkdn)
      should.exist actural, 'actural'
      actural.should.have.length.greaterThan 2
      node = actural[0]
      should.exist node, 'node'
      node.should.have.property 'type', 'list_start'
      node.should.have.property 'ordered', false
      node = actural[2]
      should.exist node, 'node'
      node.should.have.property 'text', '[list1](./list1)'
    it 'should get list section via index', ->
      actural = getListSection markdown.lexer(mkdn), 1
      should.exist actural, 'actural'
      actural.should.have.length.greaterThan 2
      node = actural[0]
      should.exist node, 'node'
      node.should.have.property 'type', 'list_start'
      node.should.have.property 'ordered', false
      node = actural[2]
      should.exist node, 'node'
      node.should.have.property 'text', 'list21'

  describe 'AstParser', ->
    it 'should get AST plain object of simple markdown heading', ->
      actural = AstParser.parse markdown.lexer('#[hello](./ff)')
      should.exist actural, 'actural'
      expected = [
        type: 'heading'
        text:
          type: 'link'
          href:'./ff'
          text:'hello'
        level:1
        raw: '[hello](./ff)'
      ]
      assert.deepEqual actural, expected

    it 'should get AST plain object of simple markdown list', ->
      actural = AstParser.parse markdown.lexer('* [hello][he]\n[he]:./ff')
      expected = [
        type: 'list'
        ordered: false
        body:
          type: 'listitem'
          text:
            type: 'link'
            text: 'hello'
            href: './ff'
      ]
      should.exist actural, 'actural'
      assert.deepEqual actural, expected
    it 'should get AST plain object of markdown list', ->
      actural = AstParser.parse markdown.lexer(mkdnList.raw)
      expected = mkdnList.expected
      assert.deepEqual actural, expected

  describe 'astList2FileObject', ->
    it 'should get a plain file object', ->
      actural = AstParser.parse markdown.lexer(mkdnList.raw)
      actural = list2FileObject(actural[0])
      expected =
        'ordered': false
        'contents': [
          {
            'path': './ff'
            'title': 'hello'
          }
          {
            'path': './aa'
            'title': 'list1'
            'ordered': true
            'contents': [
              { 'title': 'sublist' }
              { 'title': 'sub2' }
            ]
          }
        ]
      assert.deepEqual actural, expected

  describe 'getTocFromHeading', ->
    it 'should get a plain file object', ->
      actural = markdown.lexer(mkdn)
      actural = getTocFromHeading(actural)
      expected = 'contents': [
        { 'title': 'heading1' }
        {
          'title': 'heading2'
          'contents': [ {
            'title': 'Summary'
            'contents': [ {
              'title': 'heading4'
              'path': './heading4'
            } ]
          } ]
        }
      ]
      assert.deepEqual actural, expected



mkdn = """
hlleo

test it

### heading1

this is a list1

* [list1](./list1)
  * list11
  * [list12](./list12)
    * list121

heading1End

# heading2

* list21
* list22

heading2End

## Summary

* listSummary1
* listSummary2

summaryEnd

### [heading4](./heading4)

heading4End
"""

mkdnList =
  raw: """
  * [hello](./ff)
  * [list1](./aa)
    1. sublist
    1. sub2
  """
  expected: [
    'type': 'list'
    'body': [
      {
        'type': 'listitem'
        'text':
          'type': 'link'
          'href': './ff'
          'text': 'hello'
      }
      {
        'type': 'listitem'
        'text': [
          {
            type: 'link'
            href: './aa'
            text: 'list1'
          }
          {
            'type': 'list'
            'body': [
              'type': 'listitem'
              'text': 'sublist'
            ,
              'type': 'listitem'
              'text': 'sub2'
            ]
            'ordered': true
          }
        ]
      }
    ]
    'ordered': false
  ]
