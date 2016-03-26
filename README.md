## front-matter-markdown [![npm](https://img.shields.io/npm/v/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)

[![Build Status](https://img.shields.io/travis/snowyu/front-matter-markdown.js/master.svg)](http://travis-ci.org/snowyu/front-matter-markdown.js)
[![Code Climate](https://codeclimate.com/github/snowyu/front-matter-markdown.js/badges/gpa.svg)](https://codeclimate.com/github/snowyu/front-matter-markdown.js)
[![Test Coverage](https://codeclimate.com/github/snowyu/front-matter-markdown.js/badges/coverage.svg)](https://codeclimate.com/github/snowyu/front-matter-markdown.js/coverage)
[![downloads](https://img.shields.io/npm/dm/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)
[![license](https://img.shields.io/npm/l/front-matter-markdown.svg)](https://npmjs.org/package/front-matter-markdown)

Get the config object from a markdown string. It will extract configuration from [front-matter](http://jekyllrb.com/docs/frontmatter/).
And get the directory(`contents`) from the list of heading `TOC/Table Of Content/Summary`.
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
 "skipSize": 31,
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
      defaults to false. the 'directoy' is put into `contents` attributes.
    * `links` *(Boolean)*: merge the markdown links label to the result, default to false.
    * `heading` *(String|RegExp|ArrayOf(String))*: the toc list in the heading(s) to extract the directory.
      defaults to ['TOC', 'Table Of Content', 'Summary']
    * `headingsAsToc` *(Boolean|Object)*: whether `generate` the directory from the headings of markdown.
      defaults to false. It will `generate` the toc if no toc list in the specified heading(`toc` enabled).
      * `maxDepth` *(Number)*: Use headings whose depth is at most max depth for `generate`.
        defaluts to 3.
      * `firstLevel` *(Number)*: the first level to `generate` the directory from the headings of markdown.
        defaluts to 1.
  * `Returns`:
    * `skipSize` *Number*: the front-matter configuration size if exists
    * `content` *String*: the markdown string after removing the front-matter configuration. (available on `content` is true)
    * `$compiled` *Object*: the compiled markdown tree.(available on `content` is true)
    * `contents` *Object*:  the directory from the list in the specified heading. (available on `toc`)

## Changes

### v0.3

+ markdown inline options to control parser.
  * toc
  * heading: the toc list in the heading section.
  * headingsAsToc
+ setOptionAlias function
* **broken**: toc, headingsAsToc options are defaults to false now.
+ add the links option: merge the markdown links label to the result, default to false.

```coffee
markdownStr = """
  ---
  title: this is a title
  toc: false
  headingsAsToc: false
  heading: Category
  ---
  # Category

  * [Directory](./dir1)
    * [Directory2](/dir2)
  * [Directory3](#inline)

  # this is a inline heading {#inline}

  [linkLabel1]: hi
  [linkLabel2]: url "with title text"
  """
result = parseMarkdown(markdownStr) #= parseMarkdown markdownStr,
                                    #   toc:false
                                    #   headingsAsToc: false
                                    #   heading: 'Category'

```

## License

MIT
