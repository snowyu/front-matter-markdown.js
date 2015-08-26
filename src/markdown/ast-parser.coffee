inherits        = require('inherits-ex/lib/inherits')
Parser          = require('kramed/lib/parser')
InlineLexer     = require('./ast-inline-lexer')
Renderer        = require('./ast-builder')

module.exports = class AstParser
  inherits AstParser, Parser

  @parse = (src, options, renderer) ->
    parser = new AstParser(options, renderer)
    parser.parse src


  constructor: (options)->
    super
    @renderer = new Renderer

  parse: (src) ->
    src.links = {} unless src.links
    @inline = new InlineLexer(src.links, @options, @renderer)
    @tokens = src.reverse()
    out = []
    while @next()
      out = out.concat @tok()
    out

  tok: ->
    return '' unless @token and @token.hasOwnProperty('type')

    switch (@token.type)
      when 'table'
        header = []
        body = []

        cell = []
        for i in [0...@token.header.length]
          flags = { header: true, align: this.token.align[i] }
          cell = cell.concat @renderer.tablecell(
            @inline.output(@token.header[i]),
            { header: true, align: this.token.align[i] }
          )
        header = header.contact @renderer.tablerow(cell)

        for i in [0...@token.cells.length]
          row = @token.cells[i]
          cell = []
          for j in [0...row.length]
            cell = cell.concat @renderer.tablecell(
              @inline.output(row[j]),
              { header: false, align: this.token.align[j] }
            )

          body = body.concat @renderer.tablerow(cell)

        return @renderer.table(header, body)

      when 'blockquote_start'
        body = []

        while @next().type != 'blockquote_end'
          body = body.concat @tok()
        return @renderer.blockquote(body)

      when 'list_start'
        body = []
        ordered = @token.ordered

        while @next().type != 'list_end'
          body = body.concat @tok()

        return @renderer.list(body, ordered)

      when 'list_item_start'
        body = []

        while @next().type != 'list_item_end'
          body = body.concat if @token.type == 'text'
            @parseText()
          else
            @tok()

        return @renderer.listitem(body)

      when 'loose_item_start'
        body = []

        while @next().type != 'list_item_end'
          body = body.concat @tok()

        return @renderer.listitem(body)
    return super
