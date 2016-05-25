#
# Подключение к Active Directory
#

info = dc = root = base =
h = @h

@connect = ->
  @info =
  info = new ActiveXObject "ADSystemInfo"

  @dc =
  dc = info.DomainShortName

  @rootDSE =
  root = GetObject "LDAP://rootDSE"

  @base =
  base = root.Get 'rootDomainNamingContext'

  @h = h = new ActiveXObject "ADODB.Connection"
  h.Provider = "ADsDSOObject"
  h.Open "Active Directory Provider"
  h

@cmd =
cmd = (text)->
  z = new ActiveXObject "ADODB.Command"
  z.ActiveConnection = h
  assign.o z.Properties
    "Page Size": 1000
    Searchscope: 2    # ADS_SCOPE_SUBTREE
  z.CommandText = text
  z

# Найти пользователя по имени в AD и вернуть все его данные
@user = (u)->
  rs = cmd "<LDAP://#{base}>;(&(objectCategory=user)(sAMAccountName=#{
    u.replace /[()*\\]/g, '\\$&'
    }));*;subTree"
  .Execute()
  GetObject rs(0).Value unless rs.EOF

# Сохранить фотку пользователя во временный файл
@photo = (u)->
  if u.thumbnailPhoto?
    u = u.thumbnailPhoto
  else if u.jpegPhoto?
    u = u.jpegPhoto
  else
    return

  stream = new ActiveXObject "ADODB.Stream"
  stream.Type = 1	 # adTypeBinary
  stream.Open()
  stream.Write u
  stream.SaveToFile t = tmpnam(), 2 # adSaveCreateOverWrite
  stream.Close()
  t
