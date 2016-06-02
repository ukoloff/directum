#
# Запуск Directum и сценария в нём
#

throw Error 'SBLauncher.exe not found!' unless launcher

script = wsh.ScriptName.replace /\W+/, '_'

assign sh.Environment('Process'), script.toUpperCase(), wsh.ScriptFullName

sh.Run """
  "#{launcher}" -S=#{srvdb.s} -D=#{srvdb.d} -CT=Script -F=#{script}
  """
