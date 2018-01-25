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

gAliases = {} # the config options aliases

assignDefaults = (aOptions, aConfig)->
  for k in getKeys gAliases
    if aConfig[k]?
      v = gAliases[k]
      aOptions[v] ?= aConfig[k]
  aOptions

getNonNullKeys = (aObject)->
  result = getKeys(aObject).filter (k)->aObject[k]?

linksToData = (aLinks)->
  result = {}
  for k,v of aLinks
    if getNonNullKeys(v).length is 1
      result[k] = v.href
    else
      result[k] = v
  result

module.exports = fmMarkdown = (aContent, aOptions)->

  if isObject aOptions
    aOptions = extend strict:true, aOptions
  else
    aOptions = strict:true

  if aOptions.strict
    result = matter(aContent, aOptions)
  else
    try
      result = matter(aContent, aOptions)
    catch err
      result = content:aContent, data: error: err
  vSkipSize = aContent.length - result.content.length
  aContent = result.content
  result = result.data
  result.skipSize = vSkipSize if vSkipSize > 0
  return result unless aContent
  unless result.content or aOptions.content is false
    defineProperty result, 'content', aContent

  assignDefaults(aOptions, result)

  if isString aOptions.heading
    headings = [aOptions.heading]
  else if isArray aOptions.heading
    headings = aOptions.heading
  else
    headings = ['toc', /table of content/, 'summary']
  compiled = markdown.lexer aContent
  defineProperty result, '$compiled', compiled unless aOptions.content is false
  result = extend result, linksToData compiled.links if aOptions.links and compiled.links

  if aOptions.toc
    toc = getTocFromList(compiled, headings)
  if !(toc and toc.contents and toc.contents.length) and aOptions.headingsAsToc
    aOptions = aOptions.headingsAsToc
    aOptions = {} unless isObject aOptions
    aOptions.filter = headingFilter headings, aOptions.filter
    toc = getToc(compiled, aOptions)
  extend result, toc if toc and toc.contents and toc.contents.length
  result

fmMarkdown.setOptionAlias = (aOptionName, aAlias)->
  unless aOptionName in ['toc', 'heading', 'headingsAsToc']
    throw new TypeError('invalid option name')

  if isArray aAlias
    aAlias.forEach (i)->gAliases[i] = aOptionName
  else if isString aAlias
    gAliases[aAlias] = aOptionName
  gAliases
