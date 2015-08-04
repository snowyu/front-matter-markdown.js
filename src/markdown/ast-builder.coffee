
renderHandlerArgs =
  code: [
    'code'
    'lang'
    'escaped'
    'fenced'
  ]
  blockquote: [ 'quote' ]
  html: [ 'html' ]
  heading: [
    'text'
    'level'
    'raw'
  ]
  hr: []
  list: [
    'body'
    'ordered'
  ]
  listitem: [ 'text' ]
  paragraph: [ 'text' ]
  table: [
    'header'
    'body'
  ]
  tablerow: [ 'content' ]
  tablecell: [
    'content'
    'flags'
  ]
  strong: [ 'text' ]
  em: [ 'text' ]
  codespan: [ 'text' ]
  br: []
  del: [ 'text' ]
  link: [
    'href'
    'title'
    'text'
  ]
  image: [
    'href'
    'title'
    'text'
  ]
  footnote: [
    'refname'
    'text'
  ]
  math: [
    'content'
    'language'
    'visible'
  ]


isArray           = require('util-ex/lib/is/type/array')

module.exports = class AstBuilder

  # Returns a handler function which just returns an object which captures the
  # values of all the arguments to the handler function.
  makeHandler = (type, args) ->
    ->
      result = {type: type}
      i = -1
      while ++i < args.length
        v = arguments[i]
        continue unless v?
        v = v[0] if isArray(v) and v.length is 1
        result[args[i]] = v
      result

  for k,v of renderHandlerArgs
    @::[k] = makeHandler k, v
