echo 'Удаление логинов SQL'
cmd = mssql.command """
  Select name
  From master..syslogins
  Where name in
    (Select '#{ad.dc}\\'+UserLogin Collate Cyrillic_General_CI_AS
     From MBUser
     Where UserStatus='О' And NeedEncode='W')
  """
x = []
mssql.execute cmd, (u)->
  x.push u.name
  try
    mssql.h.ActiveConnection.sp_revokelogin u.name
  catch
echo "Удалялись: #{x.join ', '}" if x.length
