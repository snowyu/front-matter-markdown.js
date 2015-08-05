isString          = require('util-ex/lib/is/type/string')
isArray           = require('util-ex/lib/is/type/array')
isFunction        = require('util-ex/lib/is/type/function')
markdown          = require('./')
getHeadingSection = require('./get-heading-section')
getListSection    = require('./get-list-section')
skipSpace         = require('./skip-space')
extractType       = require('./extract-type')
AstParser         = require('./ast-parser')
headings2FileObject = require('./ast-headings-to-file-object')


module.exports = getToc = (aContent, aOptions)->
  #TODO: not fined.
  aOptions ?= {}
  firstLevel = aOptions.firstLevel || 1
  maxDepth  = aOptions.maxDepth || 3
  aContent = markdown.lexer(aContent) if isString(aContent)
  links = aContent.links
  result = extractType aContent, 'heading', (node)->
    result = node.depth >= firstLevel and (node.depth - firstLevel) <= maxDepth
    result = aOptions.filter node.text if result and isFunction aOptions.filter
    result
  result.links = links if links
  result = AstParser.parse(result)
  result = headings2FileObject(result)
  result




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
