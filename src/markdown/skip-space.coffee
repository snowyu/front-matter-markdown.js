module.exports = (nodes) ->
  nodes.filter (node) ->
    node and node.type != 'space'
