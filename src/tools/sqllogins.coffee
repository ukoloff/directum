#
# Используются ли SQL login'ы
#
cmd = mssql.command """
  Select
  Count(*) As N
  From master..syslogins
  Where name = SYSTEM_USER
  """

module.exports = mssql.execute cmd
.shift().N > 0
