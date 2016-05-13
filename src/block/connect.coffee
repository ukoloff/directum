#
# Собственно блокирование
#

echo "Соединяемся с mssql://#{srvdb.s}/#{srvdb.d}"
mssql.connect srvdb.s, srvdb.d

echo "Соединяемся с Active Directory"
ad.connect()
