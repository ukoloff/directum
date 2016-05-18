#
# Вывод сообщения на экран
#
module.exports = ->
  wsh.Echo [].slice.apply(arguments).join ' '
