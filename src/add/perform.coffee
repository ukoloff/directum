#
# Собственно генерация пользователей а также всего, что понадобится впредь (ц)
#
users = require './cb'
steps = require './perform.steps'
t = require './perform.html'

interior.innerHTML = t
  steps: steps
  users: users

tBody = $ 'tbody', interior
.pop()

evloop.push ->
  for u, i in users
    row = tBody.rows[i]
    for step, n in steps
      cell = row.cells[2+n]
      try
        step.fn u
        cell.innerHTML = '+'
      catch error
        cell.innerHTML = '#'
        cell.title = error.message
        throw error if DEBUG
  do finish

finish = ->
  $ 'center', interior
  .pop()
  .innerHTML = "That's all folks!"
