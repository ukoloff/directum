#
# Получить фотку пользователя AD
#

module.exports = (u)->
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
