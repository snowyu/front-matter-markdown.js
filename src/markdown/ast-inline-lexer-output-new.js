module.exports = function(src) {
  var out = []
    , link
    , text
    , href
    , cap;

  while (src) {
    // escape
    if (cap = this.rules.escape.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(cap[1]);
      continue;
    }

    // autolink
    if (cap = this.rules.autolink.exec(src)) {
      src = src.substring(cap[0].length);
      if (cap[2] === '@') {
        text = cap[1].charAt(6) === ':'
          ? this.mangle(cap[1].substring(7))
          : this.mangle(cap[1]);
        href = this.mangle('mailto:') + text;
      } else {
        text = this.escape(cap[1]);
        href = text;
      }
      out = out.concat(this.renderer.link(href, null, text));
      continue;
    }

    // url (gfm)
    if (!this.inLink && (cap = this.rules.url.exec(src))) {
      src = src.substring(cap[0].length);
      text = this.escape(cap[1]);
      href = text;
      out = out.concat(this.renderer.link(href, null, text));
      continue;
    }

    // html
    if (cap = this.rules.html.exec(src)) {
      // Found a link
      if(cap[1] === 'a' && cap[2] && !this.inLink) {
        // Opening tag
        out = out.concat(cap[0].substring(0, cap[0].indexOf(cap[2])));
        // In between the tag
        out = out.concat(this.output(cap[2]));
        // Outer tag
        out = out.concat(cap[0].substring(cap[0].indexOf(cap[2])+cap[2].length));
        // Advance parser
        src = src.substring(cap[0].length);
        continue;
      }

      // Found HTML that we should parse
      if(cap[1] && !isHTMLBlock(cap[1]) && cap[2]) {
        // Opening tag
        out = out.concat(cap[0].substring(0, cap[0].indexOf(cap[2])));
        // In between the tag
        out = out.concat(this.output(cap[2]));
        // Outer tag
        out = out.concat(cap[0].substring(cap[0].indexOf(cap[2])+cap[2].length));
        // Advance parser
        src = src.substring(cap[0].length);
        continue;
      }

      // Any other HTML
      src = src.substring(cap[0].length);
      out = out.concat(cap[0]);
      continue;
    }

    // link
    if (cap = this.rules.link.exec(src)) {
      src = src.substring(cap[0].length);
      this.inLink = true;
      out = out.concat(this.outputLink(cap, {
        href: cap[2],
        title: cap[3]
      }));
      this.inLink = false;
      continue;
    }

    // reffn
    if ((cap = this.rules.reffn.exec(src))) {
        src = src.substring(cap[0].length);
        out = out.concat(this.renderer.reffn(cap[1]));
        continue;
    }

    // reflink, nolink
    if ((cap = this.rules.reflink.exec(src))
        || (cap = this.rules.nolink.exec(src))) {
      src = src.substring(cap[0].length);
      link = (cap[2] || cap[1]).replace(/\s+/g, ' ');
      link = this.links[link.toLowerCase()];
      if (!link || !link.href) {
        out = out.concat(cap[0].charAt(0));
        src = cap[0].substring(1) + src;
        continue;
      }
      this.inLink = true;
      out = out.concat(this.outputLink(cap, link));
      this.inLink = false;
      continue;
    }

    // strong
    if (cap = this.rules.strong.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.strong(this.output(cap[2] || cap[1])));
      continue;
    }

    // em
    if (cap = this.rules.em.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.em(this.output(cap[2] || cap[1])));
      continue;
    }

    // code
    if (cap = this.rules.code.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.codespan(this.escape(cap[2], true)));
      continue;
    }

    // math
    if (cap = this.rules.math.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.math(cap[1], 'math/tex', false)); //FIXME: filter <script> & </script>
      continue;
    }

    // br
    if (cap = this.rules.br.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.br());
      continue;
    }

    // del (gfm)
    if (cap = this.rules.del.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.renderer.del(this.output(cap[1])));
      continue;
    }

    // text
    if (cap = this.rules.text.exec(src)) {
      src = src.substring(cap[0].length);
      out = out.concat(this.escape(this.smartypants(cap[0])));
      continue;
    }

    if (src) {
      throw new
        Error('Infinite loop on byte: ' + src.charCodeAt(0));
    }
  }

  return out;
}
