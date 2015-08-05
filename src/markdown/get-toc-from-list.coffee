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
  links = aContent.links
  result = getHeadingSection aContent, headings
  if result # have such heading section
    result = getListSection result
    if result # have the list section
      result = skipSpace result
      result.links = links
      result = AstParser.parse(result)
      if result and result.length
        result = list2FileObject result[0]
      else
        result = null
  result
