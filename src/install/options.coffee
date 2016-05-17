#
# Собрать опции из всех источников
#

opts = [require './defaults']

yml = do (path = wsh.ScriptFullName)->
  fs.BuildPath fs.GetParentFolderName(path), "#{fs.GetBaseName path}.yml"

if fs.FileExists yml
  yml = yaml.safeLoad fs.OpenTextFile(yml).ReadAll()
  opts.push yml
  opts.push yml[argv[0]]

opts.push require './srvdb'

r = {}
for z in opts when 'object' == typeof z
  for k, v of z when 'object' != typeof v
    r["DIR#{k.toUpperCase()}"] = v

module.exports = ("#{n}=#{r[n]}" for n in Object.keys(r).sort()).join ' '
