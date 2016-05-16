#
# Проверить имя сервера и БД
#

dom.forms[0].onsubmit = ->
  for k, i in 's d'.split ' '
    c = @[i]
    if /^\w+$/.test exports[k] = c.value.replace /^\s+|\s+$/g, ''
      continue
    c.focus()
    c.select()
    return false
  require './connect'
  false  # Ok
