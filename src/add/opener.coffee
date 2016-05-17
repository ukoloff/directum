#
# Открыть ссылки в системном браузере
#

for z in $ 'a' when z.target
  do (url = z.href)->
    z.onclick = ->
      sh.run url
      false
