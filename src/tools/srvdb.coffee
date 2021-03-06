#
# Стандартная командная строка SERVER/DATABASE
#
help = ->
  echo """
Запуск: #{wsh.ScriptName} <Server>/<Database>

Например: #{wsh.ScriptName} Directum/Directum

Умолчания можно дописать в 3 строку файла.

Подробности на <#{PACKAGE.homepage}>.
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
