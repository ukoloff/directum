#
# Подключение к Active Directory
#

h = @h

@info =
info = new ActiveXObject "ADSystemInfo"

@dc =
dc = info.DomainShortName

@rootDSE =
root = GetObject "LDAP://rootDSE"

@base =
base = root.Get 'rootDomainNamingContext'

@connect = ->
  @h = h = new ActiveXObject "ADODB.Connection"
  h.Provider = "ADsDSOObject"
  h.Open "Active Directory Provider"
  h

@cmd =
cmd = (text)->
  z = new ActiveXObject "ADODB.Command"
  z.ActiveConnection = h
  p = z.Properties
  assign p, "Page Size", 1000
  assign p, "Searchscope", 2    # ADS_SCOPE_SUBTREE
  z.CommandText = text
  z

# Найти пользователя по имени в AD и вернуть все его данные
@user = (u)->
  rs = cmd "<LDAP://#{base}>;(&(objectCategory=user)(sAMAccountName=#{
    u.replace(/[()*\\]/g, '\\$&')
    }));*;subTree"
  .Execute()
  GetObject rs(0).Value unless rs.EOF
