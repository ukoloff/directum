#
# Интерфейс к MS SQL
#

h = @h  # Соединение с сервером

@connect = (host, db)->
  @h = h = new ActiveXObject "ADODB.Connection"
  h.Provider = 'SQLOLEDB'
  h.Open "Integrated Security=SSPI;Data Source=#{host}"
  use db if db
  h

@use =
use = (db)->
  h.DefaultDatabase="[#{db}]"

@command = (sql)->
  cmd = new ActiveXObject "ADODB.Command"
  cmd.ActiveConnection = h
  cmd.CommandText = sql
  cmd

@fields =
fields = (recordset)->
  return if recordset.EOF
  r = {}
  each recordset.Fields, (f)->
    r[f.name] = f.value
    return
  r

@execute = (command, fn)->
  n = 0
  res = [] if 'function' == typeof fn
  rs = command.Execute()
  while !rs.EOF
    f = fields rs
    rs.MoveNext()
    if res
      res.push f
    else if false == fn f, n++
      return
  res
