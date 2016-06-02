#
# Запуск оснастки "Пользователи"
#

val = require './validate'

$ 'a', interior
.shift()
.onclick = ->
  if launcher and val.test()
    evloop.push ->
      sh.Run """
        "#{launcher}" -S=#{val.s} -D=#{val.d} -CT=Reference -F=SYSTEM_USERS
        """
  false
