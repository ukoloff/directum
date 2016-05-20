#
# Открыть ссылки в системном браузере
#

module.exports = ->
  for z in $ 'a' when z.target
    do (url = z.href)->
      z.onclick = ->
        sh.run url
        false
