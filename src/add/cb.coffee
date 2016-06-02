#
# Нарисовать список пользователей с крыжиками
#

users = require './connect.steps'
.users

t = require './cb.html'

interior.innerHTML = t
  users: users
  sys: directum.app.Connection.SystemInfo

do require './opener'

# Кнопка
btn = $ 'input', interior
.pop()

# Чекбоксы
tBody = $ 'tbody', interior
.pop()
cboxes = for r in tBody.rows
  z = $ 'input', r.cells[0]
  .pop()

# Общий чекбокс
$ 'input', $('tfoot', interior)[0]
.pop()
.onclick = ->
  checked = @checked
  z.checked = checked for z in cboxes when not z.disabled
  do toggleBtn

toggleBtn = ->
  for z in cboxes when z.checked and not z.disabled
    btn.disabled = false
    return
  btn.disabled = true

z.onclick = toggleBtn for z in cboxes

gatherData = ->
  module.exports =
  res = []
  for r, i in tBody.rows when cboxes[i].checked and not cboxes[i].disabled
    u = users[i]
    idx = if u.Depts.length > 1
      $ 'select', r
      .pop()
      .selectedIndex
    else 0
    u.Dept = u.Depts[idx]
    res.push u
  res

btn.onclick = ->
  return unless gatherData().length
  require './perform'
