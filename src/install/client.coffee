#
# Поиск инсталлятора клиента Directum
#

module.exports =
z = fs.BuildPath fs.GetParentFolderName(wsh.ScriptFullName), 'Client.exe'

unless fs.FileExists z
  echo "Client.exe не найден"
  exit 1
