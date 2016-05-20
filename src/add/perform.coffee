#
# Собственно генерация пользователей а также всего, что понадобится впредь (ц)
#

users = require './cb'

t = without ->
  ths =
    '№': false
    Пользователь: false
    ПОЛ: 'Обновление пользователя Directum'
    ПРС: 'Генерация персоны'
    РАБ: 'Генерация работника'
    КНТ: 'Настройка контакта'
    SQL: 'Генерация пользователя SQL'
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th title: v, k for k, v of ths
      tbody ->
        for u, i in @
          tr ->
            td align: 'right', i+1
            td u.AD.sAMAccountName
            td align: 'center' for i in [1..5]

interior.innerHTML = t users

tbody = $ 'tbody', interior
.pop()

perform = ->
  for u, i in users
    row = tbody.rows[i]
    for step, n in steps
      cell = row.cells[2+n]
      try
        step u
        cell.innerHTML = '+'
      catch error
        cell.innerHTML = '#'
        cell.title = error.message

require './loop'
.push perform

steps = []

# ПОЛ
steps.push (u)->
  cmd = mssql.command """
    Update MBUser
    Set
      UserName=?,
      Domain = ?
    Where UserLogin=?
    """
  assign cmd, 0, u.AD.cn
  assign cmd, 1, ad.dc
  assign cmd, 2, u.UserLogin
  cmd.Execute()

  POL = directum.app.ReferencesFactory.ПОЛ.GetObjectById u.Analit
  POL.Дополнение3 = u.AD.cn
  POL.Save()

# ПРС
steps.push (u)->
  Prs = directum.app.ReferencesFactory.ПРС.GetComponent()
  Prs.Open()
  Prs.Insert()
  Prs.Дополнение = u.AD.sn           # Фамилия
  Prs.Дополнение2 = u.AD.givenName   # Имя
  Prs.Дополнение3 = u.AD.middleName  # Отчество
  Prs.Строка2 = u.AD.mail        		 # Личный e-mail
  Prs.Save()
  u.PrsKod = Prs.Код
