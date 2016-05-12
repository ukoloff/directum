#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

URL='https://ekb.ru/omz/abook/pki/'

nocrl # Зачем-то отключаем проверку сертификатов

# "Глобальные" переменные
Application = 0 # Directum's Application
n = 5
Q = []
Crt = {}
U = {}
cmdUser = 0
cmdCrt = 0

log = 0
@init = (app, me)->
  Application = app
  c = Application.Connection
  mssql.connect c.ServerName, c.DatabaseName
  Q = csv zzz = ajax.get URL+"?q=r@;u!@&sort=C&as=csv&rnd=#{rnd()}"

  log = fs.CreateTextFile me+'.log'
  for z in Q
    log.WriteLine dump z

@next = ->
  log.WriteLine("next()")
  fs.DeleteFile Crt.ТекстТ2 if Crt.ТекстТ2
  while x = Q.shift()
    log.WriteLine("next()2 #{x.u}")
    continue if x.Revoke or not x.u
    log.WriteLine("User: #{x.u}")
    cmdUser ||= mssql.command """
      Select
       UserLogin, UserKod, UserName, P.Analit, P.Kod
      From
       mbUser U, mbAnalit P, mbVidAn V
      Where
       U.NeedEncode='W' And U.UserKod=P.Dop And
       P.Vid=V.Vid And V.Kod='ПОЛ'
       And U.UserLogin=?
    """
    assign cmdUser, 0, x.u
    continue unless U = mssql.fields cmdUser.Execute()
    U.cn = x.subj.replace(/.*\/CN=/i, '').replace /\/.*/, ''

    cmdCrt = mssql.command """
      Select Count(*) As N
      From MBAnValR2
      Where
       Analit=?
       And SoderT2=?
    """
    assign cmdCrt, 0, U.Analit
    assign cmdCrt, 1, U.SHA1 = x.SHA1.replace /\W/g, ''
    continue if cmdCrt.Execute()(0).value
    return true
  false

@item = ->
  "Пункт #{n}..."
