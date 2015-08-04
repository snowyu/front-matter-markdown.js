module.exports = (nodes, aIndex = 0, corrected = true)->
  index = -1
  level = 0
  start = null
  end = 0
  while end < nodes.length
    node = nodes[end++]
    switch node.type
      when 'list_start'
        index++ if level == 0
        if index == aIndex and !start
          start = end-1
        level++
      when 'list_end'
        level--
        if level == 0 and index == aIndex
          return nodes.slice(start, end)
      when 'loose_item_start'
        # Correct loose items
        node.type = 'list_item_start' if corrected
  return
