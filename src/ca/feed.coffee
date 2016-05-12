#
# Запускается изнутри Directum
# Отдаёт сертификаты для установки
#

URL='https://ekb.ru/omz/abook/pki/'

nocrl # Зачем-то отключаем проверку сертификатов

Application = 0 # Directum's Application
n = 5
Q = []

@init = (app, me)->
  Application = app
  c = Application.Connection
  mssql.connect c.ServerName, c.DatabaseName
  Q = csv ajax.get URL+"?q=r@;u!@&sort=C&as=csv&rnd=#{rnd()}"

@next = ->
  n-- > 0

@item = ->
  "Пункт #{n}..."
