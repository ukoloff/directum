#
# Эвристика для выбора выполняемого файла
#
module.exports = (asset)->
  if ///
      \( (["'])InternetExplorer[.]Application\1 \)
      |
      (["'])Client.exe\2
    ///.test asset.source()
    'start wscript.exe'
  else
    'cscript.exe //nologo'
