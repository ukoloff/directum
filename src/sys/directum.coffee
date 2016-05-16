#
# Соединение с Directum
#

photo =
lp =
app = 0

@init =
init = ->
  @lp =
  lp = new ActiveXObject "SBLogon.LoginPoint"

@connect = (srv, db)->
  init() unless lp
  @app =
  app = lp.GetApplication "ServerName=#{srv};DBName=#{db};IsOSAuth=1"

# Поддержка фоток ?
@test = ->
  @photo = photo =
    !!app.ReferencesFactory.ПРС.GetComponent().FindRequisite 'Текст'
