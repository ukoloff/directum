#
# Отображение процесса подключения к серверам
#
steps = require './connect.steps'
t = require './connect.html'

tError = without ->
  b @message

interior.innerHTML = t steps

tBody = $ 'tbody', interior
.pop()

window = dom.parentWindow

evloop.push ->
  for s, i in steps
    cells = tBody.rows[i].cells
    timer = window.Timer cells[2]
    try
      do s.fn
      cells[3].innerHTML = '+'
    catch e
      cells[3].innerHTML = tError e
      err = true
      throw e if DEBUG
      break
    finally
      timer.stop()
  exit 1 if err
  require './cb'
