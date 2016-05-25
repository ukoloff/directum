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

if x.length
  echo "Удаляем: #{x.join ', '}"
  cmd = mssql.command """
    Declare @sql nvarchar(max);
    Select @sql = '';

    Select @sql = @sql + 'Drop Table ' +
      QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';'
    From INFORMATION_SCHEMA.TABLES
    Where TABLE_SCHEMA = ?
      And TABLE_TYPE ='BASE TABLE';

    exec sp_executesql @sql;
  """

for u in x
  try
    assign.l cmd, u
    .Execute()
    mssql.h.sp_dropuser u
  catch e
    echo "##{e.message}"
