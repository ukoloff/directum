echo 'Удаление логинов SQL'
cmd = mssql.command """
  Select name
  From master..syslogins
  Where name in
    (Select '#{ad.dc}\\'+UserLogin Collate Cyrillic_General_CI_AS
     From MBUser
     Where UserStatus='О' And NeedEncode='W')
  """
cmdX = mssql.command 'exec sp_revokelogin ?'
x = []
mssql.execute cmd, (u)->
  x.push u.name
  try
    assign cmdX, 0, u.name
    cmdX.Execute()
  # catch

echo "Удалялись: #{x.join ', '}" if x.length
