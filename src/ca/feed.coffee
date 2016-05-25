#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

nocrl # Зачем-то отключаем проверку сертификатов

# "Глобальные" переменные
Application = 0 # Directum's Application
x = {}
Q = []
Crt = {}
U = {}
cmdUser = 0
cmdCrt = 0
cmdReset = 0

@init = (app, me)->
  Application = app
  c = Application.Connection
  mssql.connect c.ServerName, c.DatabaseName
  Q = csv ajax.get "#{PACKAGE.pki}?q=r@;u!@&sort=C&as=csv&rnd=#{rnd()}"

@next = ->
  fs.DeleteFile Crt.ТекстТ2 if Crt.ТекстТ2
  while x = Q.shift()
    continue if x.Revoke or not x.u
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
    assign.l cmdUser, x.u
    continue unless U = mssql.fields cmdUser.Execute()
    U.cn = x.subj.replace(/.*\/CN=/i, '').replace /\/.*/, ''

    cmdCrt = mssql.command """
      Select Count(*) As N
      From MBAnValR2
      Where
        Analit=?
        And SoderT2=?
    """
    assign.l cmdCrt, U.Analit, U.SHA1 = x.SHA1.replace /\W/g, ''
    continue if cmdCrt.Execute()(0).value
    return true
  false

@item = ->
  ajax.dl "#{PACKAGE.pki}?as=der&n=#{x.id}", tmp = tmpnam()

  cmdReset ||= mssql.command """
    Update MBAnValR2
      Set DefaultCert='Н', CertificateType='Э'
    Where
      Analit=?
  """
  assign.l cmdReset, U.Analit
  .Execute()

  Crt =
    u: x.u
    Kod: U.Kod
    Analit: U.Analit
    ISBStartObjectName: '{B1B27433-D685-47F8-8500-CF9525407145}'
    СтрокаТ2: U.cn
    СодержаниеТ2: U.SHA1
    ТекстТ2: tmp
    ISBCertificateInfo: U.UserName
    ISBCertificateType: 'ЭЦП и шифрование'
    ISBDefaultCert: 'Да'
    СостояниеТ2: 'Действующая'
