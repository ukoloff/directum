#
# Проверить имя сервера и БД
#

form  = dom.forms[0]

@test =
test = ->
  for k, i in 's d'.split ' '
    c = form[i]
    if /^\w+$/.test exports[k] = c.value.replace /^\s+|\s+$/g, ''
      continue
    c.focus()
    c.select()
    return false
  true

form.onsubmit = ->
  require './connect' if test()
  false
