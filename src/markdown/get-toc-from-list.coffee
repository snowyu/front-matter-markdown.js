isString          = require('util-ex/lib/is/type/string')
isArray           = require('util-ex/lib/is/type/array')
markdown          = require('./')
getHeadingSection = require('./get-heading-section')
getListSection    = require('./get-list-section')
skipSpace         = require('./skip-space')
AstParser         = require('./ast-parser')
list2FileObject   = require('./ast-list-to-file-object')

module.exports = getToc = (aContent, headings, aOptions)->
  aContent = markdown.lexer(aContent) if isString(aContent)
  result = getHeadingSection aContent, headings
  result = skipSpace getListSection result
  result = AstParser.parse(result)
  if result and result.length
    result = list2FileObject result[0]
  else
    result = null
  result

###
[ { type: 'list_item_start' },
  { type: 'text', text: '[list1](./list1) tddf' },
  { type: 'list_start', ordered: false },
  { type: 'list_item_start' },
  { type: 'text', text: 'sublist1' },
[
  {
    name: 'list1'
    path: './list1'
    contents: [
      {
        name: 'sublist1'
        path: undefined,
      }
    ]
  }
]
###
getToc """
# dddd

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


## heading3

ddff
sdsdd

""", ['heading1']
