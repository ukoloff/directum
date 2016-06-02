#
# Запуск оснастки "Пользователи"
#

validate = require './validate'

$ 'a', interior
.shift()
.onclick = ->
  if validate.test()
    evloop.push ->
      sh.Run """
        "#{launcher}" -S=#{validate.s} -D=#{validate.d} -CT=Reference -F=SYSTEM_USERS
        """
  false
