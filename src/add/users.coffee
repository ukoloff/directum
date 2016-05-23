#
# Запуск оснастки "Пользователи"
#

validate = require './validate'

$ 'a', interior
.shift()
.onclick = ->
  return unless validate.test()
  sh.Run """
  "#{launcher}" -S=#{validate.s} -D=#{validate.d} -CT=Reference -F=SYSTEM_USERS
  """
