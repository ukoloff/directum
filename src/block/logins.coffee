echo 'Поиск удаляемых логинов SQL'
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

echo "Удаляем: #{x.join ', '}" if x.length

for u in x
  try
    mssql.h.sp_revokelogin u
  catch e
    echo "##{e.message}"
