#
# Путь к временному файлу
#

tmp = sh.ExpandEnvironmentStrings '%TEMP%'

module.exports = ->
  for i in [1..16]
    if not fs.FileExists n = fs.BuildPath tmp, rnd()
      return n
  throw Error 'Cannot create temporary file'
