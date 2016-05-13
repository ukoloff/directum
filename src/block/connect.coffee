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
