#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

URL='https://ekb.ru/omz/abook/pki/'

Application = 0 # Directum's Application
n = 5
Q = []

@init = (app)->
  Application = app
  Q = csv ajax.get URL+"?q=r@;u!@&sort=C&as=csv&rnd=#{rnd()}"
  popup "Найдено #{Q.length} сертификатов"

@next = ->
  n-- > 0

@item = ->
  "Пункт #{n}..."
