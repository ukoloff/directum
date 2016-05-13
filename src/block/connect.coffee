#
# Собственно блокирование
#

echo "Соединяемся с mssql://#{srvdb.s}/#{srvdb.d}"
mssql.connect srvdb.s, srvdb.d

echo "Соединяемся с Active Directory"
ad.connect()

echo "Поиск заблокированных пользователей"
do ->
  x = []
  cmd = mssql.command """
    Select
     UserID, UserKod, UserName, UserLogin
    From MBUser
    Where
     NeedEncode='W'
     And UserStatus<>'О'
     And UserCategory='О'
  """
  mssql.execute cmd, (u)->
    if ad.user(u.UserLogin)?.userAccountControl & 2
      x.push u

  echo "Найдено: #{x.length}"
  return unless x.length

  cmd = mssql.command """
    Update MBUser
    Set
     UserStatus='О'
    Where UserID=?
  """
  names = []
  for u in x
    names.push u.UserLogin
    assign cmd, 0, u.UserID
    cmd.Execute()
  echo "Заблокированы: #{names.join ', '}"

action = (title, sql)->
  echo title
  mssql.command sql
  .Execute()

action 'Закрытие неактивных записей справочника Пользователи',
  """
    Update MBAnalit
    Set Sost='З'
    From MBUser As U, MBAnalit As A, MBVidAn As R
    Where U.UserStatus='О' And U.NeedEncode='W'
      And A.Dop=U.UserKod And A.Sost<>'З'
      And A.Vid=R.Vid And R.Kod='ПОЛ'
  """
action 'Открытие заново активированных записей справочника Пользователи',
  """
    Update MBAnalit
    Set Sost='Д'
    From MBUser As U, MBAnalit As A, MBVidAn As R
    Where U.UserStatus<>'О' And U.NeedEncode='W'
      And A.Dop=U.UserKod And A.Sost='З'
      And A.Vid=R.Vid And R.Kod='ПОЛ'
  """

action 'Копирование статуса строк справочника Пользователи в справочник Работники',
  """
    Update W
    Set Sost=U.Sost
    From MBAnalit As U, MBAnalit As W, MBVidAn As R, MBUser As X
    Where R.Kod='РАБ' And W.Vid=R.Vid
      And W.Polzovatel=U.Analit And W.Sost<>U.Sost
      And U.Dop=X.UserKod And X.NeedEncode='W'
  """

action 'Копирование статуса строк справочника Работники в справочник Персоны',
   """
    Update P
    Set Sost=W.Sost
    From MBAnalit As P, MBAnalit As W, MBVidAn As R
    Where R.Kod='РАБ' And W.Vid=R.Vid
      And W.Persona=P.Analit
      And W.Sost<>P.Sost
   """

echo 'Удаление пользователей SQL'
do ->
  cmd = mssql.command """
    Select
      name
    From sysusers
    Where name in
      (Select UserKod
        From MBUser
        Where UserStatus='О' And NeedEncode='W')
  """
  x = []
  mssql.execute cmd, (u)->
    x.push u.name
    try
      mssql.h.ActiveConnection.sp_dropuser u.name
    catch
  echo "Удалялись: #{x.join ', '}"
