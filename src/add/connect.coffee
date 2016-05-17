#
# Отображение процесса подключения к серверам
#
steps = require './steps'

t = without ->
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th x for x in '№ Операция Время Результат'.split ' '
      tbody ->
        for z, i in @
          tr
            class: if i & 1 then 'odd' else 'even'
            ->
              td align: 'right', i+1
              td z.title
              td align: 'right'
              td align: 'center'

interior.innerHTML = t steps

tbody = $ 'tbody'
.pop()

window = dom.parentWindow

connect = ->
  for s, i in steps
    timer = window.Timer tbody.rows[i].cells[2]
    wsh.Sleep 1234
    timer.stop()

require './loop'
.push connect
