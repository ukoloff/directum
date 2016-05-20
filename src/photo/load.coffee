#
# Собственно загрузка фоток
#

echo "Соединяемся с mssql://#{srvdb.s}/#{srvdb.d}"
mssql.connect srvdb.s, srvdb.d

echo "Соединяемся с Active Directory"
ad.connect()

echo "Соединяемся с Directum"
directum.connect srvdb.s, srvdb.d

echo "That's all folks!"
