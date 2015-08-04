#DiffMatchPatch  = require('diff-match-patch')
#dmp             = new DiffMatchPatch
#patch = dmp.patch_make(org, newF)
#fs.writeFileSync('./t.patch', JSON.stringify patch, null,1)
module.exports = [
  {
    'diffs': [
      [
        0
        't = '
      ]
      [
        -1
        '\'\''
      ]
      [
        1
        '[]'
      ]
      [
        0
        '\n   '
      ]
    ]
    'start1': 24
    'start2': 24
    'length1': 10
    'length2': 10
  }
  {
    'diffs': [
      [
        0
        'out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'cap[1]'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n  '
      ]
    ]
    'start1': 199
    'start2': 199
    'length1': 17
    'length2': 28
  }
  {
    'diffs': [
      [
        0
        '    }\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.li'
      ]
    ]
    'start1': 619
    'start2': 619
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        'ref, null, text)'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      continue'
      ]
    ]
    'start1': 668
    'start2': 668
    'length1': 32
    'length2': 33
  }
  {
    'diffs': [
      [
        0
        'text;\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        1
        ' '
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.li'
      ]
    ]
    'start1': 876
    'start2': 876
    'length1': 35
    'length2': 46
  }
  {
    'diffs': [
      [
        0
        'l, text)'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 934
    'start2': 934
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        ';\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.options'
      ]
    ]
    'start1': 1233
    'start2': 1233
    'length1': 27
    'length2': 37
  }
  {
    'diffs': [
      [
        0
        ': cap[0]'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 1318
    'start2': 1318
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        'true;\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.outputLink('
      ]
    ]
    'start1': 1469
    'start2': 1469
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        '      })'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 1565
    'start2': 1565
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        'h);\n        out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.re'
      ]
    ]
    'start1': 1725
    'start2': 1725
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        'er.reffn(cap[1])'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n        contin'
      ]
    ]
    'start1': 1765
    'start2': 1765
    'length1': 32
    'length2': 33
  }
  {
    'diffs': [
      [
        0
        '    out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'cap[0].c'
      ]
    ]
    'start1': 2104
    'start2': 2104
    'length1': 19
    'length2': 29
  }
  {
    'diffs': [
      [
        0
        'harAt(0)'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 2133
    'start2': 2133
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        ';\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.outputL'
      ]
    ]
    'start1': 2235
    'start2': 2235
    'length1': 27
    'length2': 37
  }
  {
    'diffs': [
      [
        0
        'p, link)'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 2278
    'start2': 2278
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        'gth);\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.st'
      ]
    ]
    'start1': 2434
    'start2': 2434
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        'p[2] || cap[1]))'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      continue'
      ]
    ]
    'start1': 2498
    'start2': 2498
    'length1': 32
    'length2': 33
  }
  {
    'diffs': [
      [
        0
        'gth);\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.em'
      ]
    ]
    'start1': 2627
    'start2': 2627
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        'p[2] || cap[1]))'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      continue'
      ]
    ]
    'start1': 2687
    'start2': 2687
    'length1': 32
    'length2': 33
  }
  {
    'diffs': [
      [
        0
        'gth);\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.co'
      ]
    ]
    'start1': 2820
    'start2': 2820
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        ', true))'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 2890
    'start2': 2890
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        'gth);\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.ma'
      ]
    ]
    'start1': 3015
    'start2': 3015
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        ', false)'
      ]
      [
        1
        ')'
      ]
      [
        0
        '; //FIXM'
      ]
    ]
    'start1': 3081
    'start2': 3081
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        'gth);\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.renderer.br'
      ]
    ]
    'start1': 3239
    'start2': 3239
    'length1': 35
    'length2': 45
  }
  {
    'diffs': [
      [
        0
        'rer.br()'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 3278
    'start2': 3278
    'length1': 16
    'length2': 17
  }
  {
    'diffs': [
      [
        0
        ';\n      out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this.rendere'
      ]
    ]
    'start1': 3411
    'start2': 3411
    'length1': 27
    'length2': 37
  }
  {
    'diffs': [
      [
        0
        '.output(cap[1]))'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      continue'
      ]
    ]
    'start1': 3458
    'start2': 3458
    'length1': 32
    'length2': 33
  }
  {
    'diffs': [
      [
        0
        'out '
      ]
      [
        -1
        '+'
      ]
      [
        0
        '= '
      ]
      [
        1
        'out.concat('
      ]
      [
        0
        'this'
      ]
    ]
    'start1': 3603
    'start2': 3603
    'length1': 11
    'length2': 21
  }
  {
    'diffs': [
      [
        0
        'cap[0]))'
      ]
      [
        1
        ')'
      ]
      [
        0
        ';\n      '
      ]
    ]
    'start1': 3649
    'start2': 3649
    'length1': 16
    'length2': 17
  }
]
