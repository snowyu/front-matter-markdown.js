InlineLexer     = require('kramed/lib/lex/inline')
fs = require 'fs'
cson = require 'cson'
DiffMatchPatch  = require('diff-match-patch')
dmp             = new DiffMatchPatch

org = fs.readFileSync './src/markdown/ast-inline-lexer-output-org.js', encoding:'utf8'
newF = fs.readFileSync './src/markdown/ast-inline-lexer-output-new.js', encoding:'utf8'
patch = dmp.patch_make(org, newF)
fs.writeFileSync('./src/markdown/ast-inline-lexer-patch.coffee', 'module.exports='+cson.stringify patch,null,2)

#fs.writeFileSync './src/markdown/ast-inline-lexer-output-org.js', InlineLexer::output.toString()