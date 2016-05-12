#
# Интерфейс к MS SQL
#

h = @h  # Соединение с сервером

@connect = (host, db)->
  @h = h = new ActiveXObject "ADODB.Connection"
  h.Provider = 'SQLOLEDB'
  h.Open "Integrated Security=SSPI;Data Source=#{host}"
  h.DefaultDatabase="[#{db}]"
  h

@command = (sql)->
  cmd = new ActiveXObject "ADODB.Command"
  cmd.ActiveConnection = h
  cmd.CommandText = sql
  cmd

@fields = (recordset)->
  return if recordset.EOF
  r = {}
  each recordset.Fields, (f)->
    r[f.name] = f.value
    return
  r
