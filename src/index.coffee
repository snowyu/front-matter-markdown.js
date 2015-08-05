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

  result = matter(aContent, aOptions)
  aContent = result.content
  result = result.data
  unless result.content or aOptions.content is false
    defineProperty result, 'content', aContent

  if isString aOptions.heading
    headings = [aOptions.heading]
  else if isArray aOptions.heading
    headings = aOptions.heading
  else
    headings = ['toc', /table of content/, 'summary']
  compiled = markdown.lexer aContent
  defineProperty result, '$compiled', compiled unless aOptions.content is false

  if aOptions.toc isnt false
    toc = getTocFromList(compiled, headings)
  if !(toc and toc.contents.length) and aOptions.headingsAsToc isnt false
    aOptions = aOptions.headingsAsToc
    aOptions = {} unless isObject aOptions
    aOptions.filter = headingFilter headings, aOptions.filter
    toc = getToc(compiled, aOptions)
  extend result, toc if toc and toc.contents.length
  result
