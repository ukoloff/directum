#
# Wrap .js into .bat
# http://www.dostips.com/forum/viewtopic.php?p=37780#p37780
#
fs = require "fs"
path = require 'path'

iconv = require "iconv-lite"
yaml = require 'js-yaml'

ini = require '../package'

module.exports =
me = ->

me::apply = (compiler)->
  compiler.plugin "done", (compilation)->
    yml = readYML()
    target = yml[":target#{if compilation.compilation.options.debug then ':debug' else ''}"]
    prolog = yml[':prolog'].replace '#{homepage}', ini.homepage

    for k, z of compilation.compilation.assets
      x = path.parse dst = z.existsAt
      continue if '.js' != x.ext
      fs.unlink dst, ->
      x.ext = '.bat'
      delete x.base
      bat = yml[x.name] or yml[':*']
      fs.writeFile path.format(x), toANSI """
        #{prolog}#{word bat.command}"%~f0" #{word bat.args}#{target}
        #{yml[':epilog']}#{do z.source}

        """, ->
    return

word = (s)->
  if s
    "#{s} "
  else
    ''

readYML = ->
  z = path.parse __filename
  delete z.basename
  z.ext = '.yml'
  z.dir = path.join z.dir, '../src'
  delete z.base
  yaml.safeLoad fs.readFileSync path.format z

toANSI = (s)->
  iconv.encode s, 'cp1251'
