#
# Wrap .js into .bat
# http://www.dostips.com/forum/viewtopic.php?p=37780#p37780
#
fs = require "fs"
iconv = require "iconv-lite"
ini = require '../package'

module.exports =
me = (options)->

me::apply = (compiler)->
  compiler.plugin "done", (compilation)->
    for k, z of compilation.compilation.assets
      dst = z.existsAt
      continue unless /[.]js$/.test dst
      fs.unlink dst, ->
      dst = dst.replace /[.].*?$/, '.bat'
      fs.writeFile dst, toANSI """
0</*! :: See #{ini.homepage}
@echo off
cscript //nologo //e:javascript "%~f0" %*
goto :EOF */0;
#{do z.source}

      """
    return

toANSI = (s)->
  iconv.encode s, 'cp1251'
