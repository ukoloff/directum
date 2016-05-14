echo 'Удаление пользователей SQL'
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
echo "Удалялись: #{x.join ', '}" if x.length
