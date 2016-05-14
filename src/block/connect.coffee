#
# Собственно блокирование
#

echo "Соединяемся с mssql://#{srvdb.s}/#{srvdb.d}"
mssql.connect srvdb.s, srvdb.d

echo "Соединяемся с Active Directory"
ad.connect()

require './block'
require './actions'
require './users'
require './logins'

echo "That's all folks!"
