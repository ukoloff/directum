0</*! ::
@echo off
start wscript.exe //e:javascript "%~f0" %*
goto :EOF */0;

WScript.Interactive = false

sh = new ActiveXObject("WScript.Shell")
fs = new ActiveXObject("Scripting.FileSystemObject")
host = new ActiveXObject("WScript.Network").ComputerName

Folder = '\\\\Directum\\Log\\5.2.1\\Upgrade'
Exe = 'DIRECTUM Company/DIRECTUM 4.9.1/SBLauncher.exe'

z = log()
z.WriteLine('---')
z.WriteLine('date: ' + new Date)
z.WriteLine('host: ' + host)
z.WriteLine('path: ' + fs.GetParentFolderName(drctm = exe()))
z.WriteLine('win:')
v = winVer()
for(var k in v)
  z.WriteLine('  '+k+': '+v[k])
z.Close()

if(!drctm)
  WScript.Quit(0);

sh.run('MsiExec.exe /X{237210BE-6775-4274-961B-2A9833F662C9} /passive /norestart', 1, true)

z = log()
z.WriteLine('---')
z.WriteLine('removed: ' + new Date)
z.Close()

sh.run('"' + fs.BuildPath(fs.GetParentFolderName(WScript.ScriptFullName), 'install.bat') + '"')

function log()
{
  return fs.OpenTextFile(fs.BuildPath(Folder, host.toLowerCase()+'.yml'),
    8, true)
}

function exe()
{
  platforms =  ' (x86)'.split(' ')
  names = Exe.split('/')
  for(var i = platforms.length - 1; i>=0; i--){
    p = sh.ExpandEnvironmentStrings("%ProgramFiles" + platforms[i] + "%")
    for(var j = 0; j < names.length; j++)
      p = fs.BuildPath(p, names[j])
    if(fs.FileExists(p))
      return p
  }
}

function winVer()
{
  var i, k, keys, len, n, r, ref, v;
  keys = {
    ver: 'CurrentVersion',
    name: 'ProductName',
    build: 'CurrentBuildNumber,CurrentBuild',
    sp: 'CSDVersion',
    ex: 'BuildLabEx,BuildLab'
  }
  r = {};
  for (k in keys) {
    v = keys[k];
    ref = v.split(',');
    for (i = 0, len = ref.length; i < len; i++) {
      n = ref[i];
      try {
        r[k] = sh.RegRead("HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\" + n);
        break;
      } catch (undefined) {}
    }
  }
  return r;
}
