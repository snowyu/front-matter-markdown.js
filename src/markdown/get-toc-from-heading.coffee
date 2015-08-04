isString          = require('util-ex/lib/is/type/string')
isArray           = require('util-ex/lib/is/type/array')
isFunction        = require('util-ex/lib/is/type/function')
markdown          = require('./')
getHeadingSection = require('./get-heading-section')
getListSection    = require('./get-list-section')
skipSpace         = require('./skip-space')
extractType       = require('./extract-type')
AstParser         = require('./ast-parser')
list2FileObject   = require('./ast-list-to-file-object')


module.exports = getToc = (aContent, aOptions)->
  #TODO: not fined.
  aOptions ?= {}
  aContent = markdown.lexer(aContent) if isString(aContent)
  links = aContent.links
  if isFunction aOptions.filter
    result = extractType aContent, 'heading', (node)->
      aOptions.filter node.text
  else
    result = extractType aContent, 'heading'
  result.links = links if links
  result = AstParser.parse(result)
  #console.log JSON.stringify result[0]
  return

getToc """
# [dddd][dd]

# heading1

a list

* [list1](./list1) tddf
  * sublist1
    * sublist2
* list1
* test

this
sdd

anther list

* [list2](./list2)
* list2


dfdfdf
dfdfdfdf


dfdfdf

* list3

hi end

### heading2

* list4
* list41

[dd]: http://sdd.com
## heading3

ddff
sdsdd

"""
