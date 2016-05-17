#
# Этапы подключения
#
validate = require './validate'

module.exports =
steps = []

step = (title, fn)->
  steps.push {title, fn}

step 'Инициализация клиента Directum', ->
  directum.init()

step 'Подключение к серверу Directum', ->
  directum.connect validate.s, validate.d

step 'Проверка поддержки фотографий', ->
  directum.test()

step 'Подключение к серверу MS SQL', ->
  mssql.connect validate.s

step 'Выбор базы данных MS SQL', ->
  mssql.use validate.d

step 'Подключение к Active Directory', ->
  ad.connect()

users = []

step 'Поиск пользователей Directum', ->
  steps.users =
  users = mssql.execute mssql.command """
    Select U.Analit, U.Kod, X.UserKod, X.UserLogin, X.UserName
    From MBAnalit As U, MBUser As X
    Where
     U.Vid=(Select Vid from MBVidAn Where Kod='ПОЛ')
     And U.Dop=X.UserKod
     And X.UserStatus<>'О' And X.UserType='П'
     And X.UserCategory='О' And X.NeedEncode='W'
     And U.Analit not In
        (Select Polzovatel From MBAnalit Where
         Polzovatel is not Null
         And Vid=(Select Vid from MBVidAn Where Kod='РАБ'))
    """

step 'Поиск пользователей в AD', ->
  for z in users
    z.AD = ad.user z.UserLogin

step 'Поиск подразделений', ->
  for z in users
    z.Depts = dept.list z.Dept = dept.id z.AD
