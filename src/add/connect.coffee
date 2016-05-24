#
# Отображение процесса подключения к серверам
#
steps = require './connect.steps'

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
              td align: 'right', br
              td align: 'center', br

tError = without ->
  b @message

interior.innerHTML = t steps

tBody = $ 'tbody', interior
.pop()

window = dom.parentWindow

connect = ->
  for s, i in steps
    cells = tBody.rows[i].cells
    timer = window.Timer cells[2]
    try
      do s.fn
      cells[3].innerHTML = '+'
    catch e
      cells[3].innerHTML = tError e
      err = true
      break
    finally
      timer.stop()
  exit 1 if err
  require './cb'

evloop.push connect
