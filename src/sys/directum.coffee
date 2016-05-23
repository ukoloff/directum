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

# Прикрепить фотку из файла
@photo = (prs, filename)->
  return unless filename
  req = prs.Requisites 'Текст'
  req.LoadFromFile filename
  req.Extension = 'jpg'
  prs.ДаНет = 'Да'
