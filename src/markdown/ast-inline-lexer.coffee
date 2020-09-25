inherits        = require('inherits-ex/lib/inherits')
InlineLexer     = require('kramed/lib/lex/inline')
newOutputFn     = require('./ast-inline-lexer-output-new')
# createFunc      = require('util-ex/lib/_create-function')

# DiffMatchPatch  = require('diff-match-patch')
# patch           = require('./ast-inline-lexer-patch')
# dmp             = new DiffMatchPatch

module.exports = class AstInlineLexer
  #DiffMatchPatch  = require('diff-match-patch')
  #dmp             = new DiffMatchPatch
  #patch = dmp.patch_make(org, newF)
  #fs.writeFileSync('./t.patch', JSON.stringify patch, null,1)
  # [newOutputFn] = dmp.patch_apply(patch, InlineLexer::output.toString())

  inherits AstInlineLexer, InlineLexer

  constructor: ->super

  # output: createFunc newOutputFn
  output: newOutputFn
