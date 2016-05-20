#
# Собственно загрузка фоток
#
photo = require '../add/photo'
echo "Соединяемся с mssql://#{srvdb.s}/#{srvdb.d}"
mssql.connect srvdb.s, srvdb.d

echo "Соединяемся с Active Directory"
ad.connect()

echo "Соединяемся с Directum"
directum.connect srvdb.s, srvdb.d

echo "Загружаем фото"
cmd = mssql.command """
  Select Distinct
    Lgn.UserLogin, Prs.Analit
  From
    MBAnalit As Wrk,
    MBAnalit As Prs,
    MBAnalit As Usr,
    MBUser As Lgn
  Where Wrk.Vid=(Select Vid From MBVidAn Where Kod='РАБ')
    And Wrk.Persona=Prs.Analit And Wrk.Polzovatel=Usr.Analit
    And Usr.Dop=Lgn.UserKod
    And Lgn.UserType='П' And Lgn.NeedEncode='W'
  Order By 1
  """
mssql.execute cmd, (z)->
  unless u = ad.user z.UserLogin
    return
  echo z.UserLogin
  unless img = photo u
    return

  Prs = directum.app.ReferencesFactory.ПРС.GetObjectById z.Analit
  req = Prs.Requisites 'Текст'
  req.LoadFromFile img
  Prs.ДаНет = 'Да'
  Prs.Save()

  fs.DeleteFile img

echo "That's all folks!"
