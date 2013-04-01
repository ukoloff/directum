//
// Найти все ярлыки Directum и уничтожить
//

var Key="SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList";
var Paths=['Desktop', 'Рабочий стол',
    'Application Data\\Microsoft\\Internet Explorer\\Quick Launch'];

var R=GetObject("winmgmts:\\\\.\\root\\default:StdRegProv");
var M=R.Methods_.Item("EnumKey");
var PI=M.InParameters.SpawnInstance_(); 
PI.hDefKey=0x80000002;	// HKLM
PI.sSubKeyName=Key;
var Us=VBArray(R.ExecMethod_(M.Name, PI).sNames).toArray();

var Sh=new ActiveXObject("WScript.Shell");
var fso=new ActiveXObject("Scripting.FileSystemObject");

for(var i in Us)
{
 var S=Us[i];
 var Path=Sh.RegRead('HKLM\\'+Key+'\\'+S+'\\ProfileImagePath');
 Path=Sh.ExpandEnvironmentStrings(Path);
 for(var j in Paths)
  unlink(Path+'/'+Paths[j]);
}

function unlink(f)
{
 try{ fso.DeleteFile(f+'/Directum.lnk'); }catch(e){}
}

//--[EOF]------------------------------------------------------------
