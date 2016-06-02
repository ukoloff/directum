#
# Поиск исполняемого файла SBLauncher
#
module.exports = do ->
  res = ''
  for x in ['(x86)', '']
    p = sh.ExpandEnvironmentStrings "%ProgramFiles#{x}%"
    continue unless p
    try
      p = fs.GetFolder fs.BuildPath p, 'DIRECTUM Company'
    catch
      continue
    each p.SubFolders, (f)->
      p = fs.BuildPath f.Path, 'SBLauncher.exe'
      res = p if fs.FileExists p
  res
