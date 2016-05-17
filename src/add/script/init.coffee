#
# Отображение процесса подключения
#

tbody = $ 'tbody'
  .shift()

@doIt = (title, fn)->
  alert title
  r = tbody.insertRow()
  c = r.insertCell()
  c.innerHTML = title

row = without ->
  td @
  td (0).toFixed 3
  td()
