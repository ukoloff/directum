#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

popup "Превед!!!"

app  = 0
n = 5
start = (App)->
  app = app

next = ->
  n-- > 0

item = ->
  "Item #{n}..."  

do ->
  @start = start
  @next = next
  @item = item
