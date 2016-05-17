echo 'Поиск удаляемых пользователей SQL'
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

echo "Удаляем: #{x.join ', '}" if x.length

for u in x
  try
    mssql.h.sp_dropuser u
  catch e
    echo "##{e.message}"
