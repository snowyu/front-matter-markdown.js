isIn            = require('util-ex/lib/is/in')
isArray         = require('util-ex/lib/is/type/array')
isBoolean       = require('util-ex/lib/is/type/boolean')

module.exports = (nodes, headings, caseSensitive)->
  start = 0
  headings = [headings] if headings and !isArray headings

  #seek the heading beginning:
  while start < nodes.length
    node = nodes[start++]
    break if node.type == 'heading' and
      (!headings or isIn(node.text, headings, caseSensitive))

  if start <= nodes.length and node.type is 'heading'
    end = start
    while end < nodes.length
      node = nodes[end++]
      break if node.type == 'heading'
    end-- unless end is nodes.length
    start-- unless start is 0
    result = nodes.slice(start, end)
  result
