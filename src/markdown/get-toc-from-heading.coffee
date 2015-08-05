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
  aOptions ?= {}
  firstLevel = aOptions.firstLevel || 1
  maxDepth  = aOptions.maxDepth || 3
  aContent = markdown.lexer(aContent) if isString(aContent)
  links = aContent.links
  result = extractType aContent, 'heading', (node)->
    reserved = node.depth >= firstLevel and (node.depth - firstLevel) < maxDepth
    reserved = aOptions.filter node.text if reserved and isFunction aOptions.filter
    reserved
  if result and result.length
    result.links = links if links
    result = AstParser.parse(result)
    result = headings2FileObject(result)
  result
