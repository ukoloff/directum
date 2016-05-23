#
# Этапы генерации пользователя
#
module.exports =
steps = []

step = (id, title, fn)->
  steps.push {id, title, fn}

step 'ПОЛ', 'Обновление пользователя Directum', (u)->
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

step 'ПРС', 'Генерация персоны', (u)->
  Prs = directum.app.ReferencesFactory.ПРС.GetComponent()
  Prs.Open()
  Prs.Insert()
  Prs.Дополнение = u.AD.sn           # Фамилия
  Prs.Дополнение2 = u.AD.givenName   # Имя
  Prs.Дополнение3 = u.AD.middleName  # Отчество
  Prs.Строка2 = u.AD.mail        		 # Личный e-mail
  directum.photo Prs, img = ad.photo u.AD
  Prs.Save()
  fs.DeleteFile img if img
  u.PrsKod = Prs.Код

# Временный код для поиска кода подразделения по id
# SQL сервер убивает русские буквы :-)
id2kod = (id)->
  directum.app.ReferencesFactory.ПОД.GetObjectById(id).Код

step 'РАБ', 'Генерация работника', (u)->
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

step 'КНТ', 'Настройка контакта', (u)->
  Knt = directum.app.ReferencesFactory.КНТ.GetComponent()
  Knt.Open()
  Knt.OpenRecord()    # Без этого запись не работает (???!)
  unless Knt.Locate 'Персона', u.PrsKod
    throw Error 'Контакт не найден'
  # Раньше это работало, но кажется в версии 4.5 удмурты это испортили :-(
  Knt.Строка2 = u.AD.mail     # Личный e-mail
  Knt.Save()

step 'SQL', 'Генерация пользователя SQL', (u)->
  mssql.h.sp_grantlogin X = "#{ad.dc}\\#{u.UserLogin}"

  cmd = mssql.command """
    Select Count(*) as N
    From sysusers U Inner Join master..syslogins L
      On U.sid=L.sid
      Where U.name=? And L.name=?
    """
  assign cmd, 0, u.UserLogin
  assign cmd, 1, X

  return if mssql.execute cmd
  .pop().N

  # mssql.h.sp_adduser X, u.UserLogin
  cmd = mssql.command "Exec sp_adduser ?, ?"
  assign cmd, 0, X
  assign cmd, 1, u.UserLogin
  cmd.Execute()
