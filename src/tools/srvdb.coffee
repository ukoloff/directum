#
# Стандартная командная строка SERVER/DATABASE
#
help = ->
  echo """
Запуск: #{WScript.ScriptName} <Server>/<Database>

Например: #{WScript.ScriptName} Directum/Directum
  """
  exit 1

module.exports =
parse = do ->
  do help unless argv.length
  for x in argv
    do help unless ///^\w+/\w+///.test x
  x = argv[0].split '/'
  s: x[0]
  d: x[1]
