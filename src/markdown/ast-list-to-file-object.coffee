isArray           = require('util-ex/lib/is/type/array')
isString          = require('util-ex/lib/is/type/string')

module.exports = class AstListToFileObject
  constructor:(src, dest)->
    return listToObject(src, dest) if src.type is 'list'


  @listToObject: listToObject = (listNode, dest)->
    dest ?= {}
    dest.ordered  = listNode.ordered
    dest.contents = bodyToObject(listNode.body)
    dest

  @bodyToObject: bodyToObject = (bodyNode)->
    bodyNode = [bodyNode] unless isArray bodyNode
    result = []
    for node in bodyNode
      continue unless node.type is 'listitem'
      result.push textToObject(node.text)
    result

  @textToObject: textToObject = (textNode)->
    result = {}
    if isArray textNode
      result.title = []
      result.contents = []
      for node in textNode
        #if isString node
        #  result.title = result.concat node
        if node.type is 'link'
          result.title = result.title.concat node.text
          result.path = node.href
          result.hint = node.title if node.title
        else if node.type is 'list'
          listToObject(node, result)
        else
          result.title = result.title.concat node
      result.title = result.title[0] if isArray(result.title) and result.title.length is 1
    else if isString textNode
      result.title = textNode
    else if textNode.type is 'link'
      result.title = textNode.text
      result.path = textNode.href
      result.hint = textNode.title if textNode.title
    else
      result.title = textNode
    result
