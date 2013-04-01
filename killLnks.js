//
// Найти все ярлыки Directum и уничтожить
//

var Key="SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList";

var R=GetObject("winmgmts:\\\\.\\root\\default:StdRegProv");
var M=R.Methods_.Item("EnumKey");
var PI=M.InParameters.SpawnInstance_(); 
PI.hDefKey=0x80000002;	// HKLM
PI.sSubKeyName=Key;
var Us=VBArray(R.ExecMethod_(M.Name, PI).sNames).toArray();

var Sh=new ActiveXObject("WScript.Shell");

for(var i in Us)
{
 var S=Us[i];
 var Path=Sh.RegRead('HKLM\\'+Key+'\\'+S+'\\ProfileImagePath');
 Path=Sh.ExpandEnvironmentStrings(Path);
 WScript.Echo(Path);
}

//--[EOF]------------------------------------------------------------
