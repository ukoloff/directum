#
# Запуск сценария изнутри Directum
#

srvdb

x=sh.Environment('Process')
assign = new Function 'o,k,v', 'o(k)=v'
assign x, 'CA_BAT', WScript.ScriptFullName

script = WScript.ScriptName.replace /\W+/, '_'

sh.Run """
"#{launcher}" -S=#{srvdb.s} -D=#{srvdb.d} -CT=Script -F=#{script}
"""
