#
# Windows version
#

reg = ->
  for n in arguments
    try
      return sh
      .RegRead "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\" + n
  return

@ver  = reg 'CurrentVersion'
@name = reg 'ProductName'
@build =
build = reg 'CurrentBuildNumber', 'CurrentBuild'
@sp = reg 'CSDVersion'
@ex = reg('BuildLabEx', 'BuildLab') or build
