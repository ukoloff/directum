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
  u.Kod = POL.Код

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

# Временный код для поиска кода подразделения по id
# SQL сервер убивает русские буквы :-)
id2kod = (id)->
  directum.app.ReferencesFactory.ПОД.GetObjectById(id).Код

# РАБ
steps.push (u)->
  Wrk = directum.app.ReferencesFactory.РАБ.GetComponent()
  Wrk.Open()
  Wrk.Insert()
  Wrk.Персона = u.PrsKod
  Wrk.Пользователь = u.Kod
  Wrk.Подразделение = id2kod u.Dept.Analit
  Wrk.Строка = u.AD.title                 # Должность
  Wrk.Дополнение4 = u.AD.telephoneNumber
  Wrk.Дополнение3 = u.AD.employeeID       # Табельный номер
  Wrk.Дополнение = "#{u.AD.sn} #{u.AD.givenName} #{u.AD.middleName}"
  Wrk.Save()

# КНТ
steps.push (u)->
  Knt = directum.app.ReferencesFactory.КНТ.GetComponent()
  Knt.Open()
  Knt.OpenRecord()    # Без этого запись не работает (???!)
  unless Knt.Locate 'Персона', u.PrsKod
    throw Error 'Контакт не найден'
  # Раньше это работало, но кажется в версии 4.5 удмурты это испортили :-(
  Knt.Строка2 = u.AD.mail     # Личный e-mail
  Knt.Save()
