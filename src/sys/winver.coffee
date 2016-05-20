#
# Windows version
#

keys =
  ver:  'CurrentVersion'
  name: 'ProductName'
  build: 'CurrentBuildNumber,CurrentBuild'
  sp: 'CSDVersion'
  ex: 'BuildLabEx,BuildLab'

for k, v of keys
  for n in v.split ','
    try
      @[k] = sh
        .RegRead "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\#{n}"
      break
