isFunction      = require('util-ex/lib/is/type/function')
isIn            = require('util-ex/lib/is/in')

module.exports = (headings, filter)->
  (heading)->
    result = true
    result = filter(heading) if isFunction filter
    result = !isIn(heading, headings) if result
    result
