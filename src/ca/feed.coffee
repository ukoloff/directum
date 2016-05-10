#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

URL='https://ekb.ru/omz/abook/pki/'

app  = 0
n = 5
Q = []

start = (App)->
  app = app
  Q = csv ajax.get URL+"?q=r@;u!@&sort=C&as=csv&rnd=#{rnd()}"
  popup "Найдено #{Q.length} сертификатов"

next = ->
  n-- > 0

item = ->
  "Пункт #{n}..."

do ->
  @start = start
  @next = next
  @item = item
