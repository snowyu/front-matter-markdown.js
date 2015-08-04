isArray         = require('util-ex/lib/is/type/array')
isString        = require('util-ex/lib/is/type/string')
isObject        = require('util-ex/lib/is/type/object')
isFunction      = require('util-ex/lib/is/type/function')
defineProperty  = require('util-ex/lib/defineProperty')
extend          = require('util-ex/lib/_extend')
matter          = require('gray-matter')
markdown        = require('./markdown')
getTocFromList  = require('./markdown/get-toc-from-list')
getToc          = require('./markdown/get-toc-from-heading')
headingFilter   = require('./gen-heading-filter')

getKeys     = Object.keys

module.exports = (aContent, aOptions)->

  aOptions ?= {}

  result = matter(aMarkdownString, aOptions)
  aContent = result.content
  result = result.data

  if isString aOptions.heading
    headings = [aOptions.heading]
  else if isArray aOptions.heading
    headings = aOptions.heading
  else
    headings = ['toc', 'table of content', 'summary']
  compiled = markdown.lexer aContent

  toc = getTocFromList(compiled, headings) if aOptions.directory isnt false
  if !(toc and toc.contents.length) and aOptions.generate isnt false
    aOptions = aOptions.generate
    aOptions ?= {}
    aOptions.filter = headingFilter aOptions.filter
    toc = getToc(compiled, aOptions)
  extend result, toc if toc and toc.contents.length
  result
