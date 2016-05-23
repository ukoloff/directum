#
# Нарисовать список пользователей с крыжиками
#

users = require './connect.steps'
.users

t = without ->
  infos =
    ServerVersion: 'Версия сервера'
    ClientVersion: 'Версия клиента'
    Name: 'Наименование'
    ServerName: 'Сервер'
    DatabaseName: 'База данных'
    Code: 'Код системы'
  ul ->
    for k, v of infos
      li (-> b v), ': ', @sys[k]
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        for x in '№,Пользователь,Имя,Таб. №,Должность,Код,Подразделение'.
            split ','
          th x
      tbody ->
        for u, i in @users
          tr
            class: if i & 1 then 'odd' else 'even'
            ->
              td align: 'right', nowrap: 'true', ->
                label i+1, ' ', -> input
                  type: 'checkbox'
                  disabled: !u.Depts.length
              td ->
                if u.AD
                  a
                    href: "https://ekb.ru/omz/dc/user/?u=#{u.AD.sAMAccountName}"
                    target: "_blank"
                    u.AD.sAMAccountName
                else
                  text u.UserLogin
              td u.AD?.displayName
              td u.AD?.employeeId
              td u.AD?.title
              td u.Dept
              td switch u.Depts.length
                when 0
                  -> center '-'
                when 1
                  u.Depts[0].NameAn
                else
                  -> select ->
                    for z in u.Depts
                      option
                        value: z.Analit
                        z.NameAn
                    text u.Depts.length
      tfoot ->
        td align: 'right', -> label '* ', -> input type: 'checkbox'
        td colspan: 6, 'Все найденные'
  div
    class: 'text-right'
    -> input
      type: 'button'
      disabled: true
      value: ' Генерировать! >> '

interior.innerHTML = t
  users: users
  sys: directum.app.Connection.SystemInfo

do require './opener'

# Кнопка
btn = $ 'input', interior
.pop()

# Чекбоксы
tbody = $ 'tbody', interior
.pop()
cboxes = for r in tbody.rows
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
  for r, i in tbody.rows when cboxes[i].checked and not cboxes[i].disabled
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
