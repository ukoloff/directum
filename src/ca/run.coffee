#
# Запуск сценария изнутри Directum
#

sh.Run """
"#{launcher}"
  -S=#{srvdb.s}
  -D=#{srvdb.d}
  -CT=Script
  -F=#{WScript.ScriptName}
  "-R=js=#{WScript.ScriptFullName}"
""".replace /\s+/g, ' '
