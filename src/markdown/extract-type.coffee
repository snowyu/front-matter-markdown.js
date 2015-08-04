isFunction      = require('util-ex/lib/is/type/function')

module.exports  = (nodes, type, aFilter)->
  nodes.filter (node)->
    result = node and node.type == type
    result = aFilter(node) if result and isFunction(aFilter)
    result
