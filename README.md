## front-matter-markdown [![npm](https://img.shields.io/npm/v/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)

[![Build Status](https://img.shields.io/travis/snowyu/front-matter-markdown.js/master.svg)](http://travis-ci.org/snowyu/front-matter-markdown.js)
[![Code Climate](https://codeclimate.com/github/snowyu/front-matter-markdown.js/badges/gpa.svg)](https://codeclimate.com/github/snowyu/front-matter-markdown.js)
[![Test Coverage](https://codeclimate.com/github/snowyu/front-matter-markdown.js/badges/coverage.svg)](https://codeclimate.com/github/snowyu/front-matter-markdown.js/coverage)
[![downloads](https://img.shields.io/npm/dm/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)
[![license](https://img.shields.io/npm/l/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)

Get the config object from a markdown string. It will extract configuration from [front-matter](http://jekyllrb.com/docs/frontmatter/).
And get the `directory` from the list of heading `TOC/Table Of Content/Summary`.
It will generate a TOC from the markdown string if the list is empty


## Usage

```coffee
parseMarkdown = require('front-matter-markdown')

markdownStr = """
---
title: this is a title
---

# table of contents

* [Directory](./dir1)
  * [Directory2](/dir2)
* [Directory3](#inline)

# this is a inline heading {#inline}

"""
console.log(JSON.stringify parseMarkdown(markdownStr), null, 1)
```

the results:

```bash
{
 "title": "this is a title",
 "ordered": false,
 "contents": [
  {
   "title": "Directory",
   "path": "./dir1",
   "ordered": false,
   "contents": [
    {
     "title": "Directory2",
     "path": "/dir2"
    }
   ]
  },
  {
   "title": "Directory3",
   "path": "#inline"
  }
 ]
}
```


## API

```js
var parseMarkdown = require('front-matter-markdown');
```

* `parseMarkdown(aMarkdownString, aOptions)`: parse a markdown string to a plain object.
  * `aOptions`*(Object)*:
    * `content` *(Boolean)*: whether extract the markdown content from configuration.
      defaults to true. it will store the compiled markdown to `$compiled` too.
      * **Note**: the `content` and `$compiled` attributes are non-enumerable.
    * `toc` *(Boolean)*: whether extract the directory from the list in the specified heading.
      defaults to true.
    * `heading` *(String|RegExp|ArrayOf(String))*: the heading(s) to extract the directory.
      defaults to ['TOC', 'Table Of Content', 'Summary']
    * `headingsAsToc` *(Boolean|Object)*: whether `generate` the directory from the headings of markdown.
      defaults to true. It will `generate` the toc if no toc list in the specified heading(`toc` enabled).
      * `maxDepth` *(Number)*: Use headings whose depth is at most max depth for `generate`.
        defaluts to 3.
      * `firstLevel` *(Number)*: the first level to `generate` the directory from the headings of markdown.
        defaluts to 1.

## License

MIT
