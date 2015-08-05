isArray           = require('util-ex/lib/is/type/array')
isString          = require('util-ex/lib/is/type/string')

module.exports = class AstHeadingsToFileObject
  constructor:(nodes)->
    contents = []
    result = contents: contents
    level = nodes[0].level
    lastObj = null
    parents = [result]
    nodes.forEach (node, i)->
      obj = textToObject(node)
      if node.level > level #child
        contents = lastObj.contents = []
        parents.push lastObj
        level = node.level
      else if node.level < level #parent
        parent = parents.pop() || result
        contents = parent.contents
        level = node.level
      contents.push obj
      lastObj = obj
    result = null unless result.contents.length
    return result

  @textToObject: textToObject = (textNode)->
    result = {}
    if isString textNode.text
      result.title = textNode.text
    else if !isArray textNode.text
      textNode = textNode.text
      if textNode.type is 'link'
        result.title = textNode.text
        result.path  = textNode.href
        result.hint  = textNode.title if textNode.title
      else
        result.title = textNode
    else
      result.title = []
      textNode.text.forEach (n)->
        if n.type is 'link'
          result.title.push n.text
          result.path = n.href
          result.hint = n.title if n.title
        else
          result.title.push n
    result
