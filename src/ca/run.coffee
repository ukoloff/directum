#
# Запуск сценария изнутри Directum
#

x=sh.Environment('Process')
assign = new Function 'o,k,v', 'o(k)=v'
assign x, 'CA_BAT', WScript.ScriptFullName

sh.Run """
"#{launcher}" -S=#{srvdb.s} -D=#{srvdb.d} -CT=Script -F=#{WScript.ScriptName}
"""
