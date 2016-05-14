echo 'Удаление логинов SQL'
mssql.command "Create Table #Do(main NVarChar(255))"
.Execute()
cmd = mssql.command "Insert Into #Do(main) Values(?+'\\')"
assign cmd, 0, ad.dc
cmd.Execute()
cmd = mssql.command """
  Select name
  From master..syslogins
  Where name in
    (Select (Select main From #Do)+UserLogin Collate Cyrillic_General_CI_AS
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
