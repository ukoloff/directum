//
// Найти все ярлыки Directum и уничтожить
//

var R=GetObject("winmgmts:\\\\.\\root\\default:StdRegProv");
var M=R.Methods_.Item("EnumKey");
var PI=M.InParameters.SpawnInstance_(); 
PI.hDefKey=0x80000002;	// HKLM
PI.sSubKeyName="SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList";
var PO=VBArray(R.ExecMethod_(M.Name, PI).sNames).toArray();

WScript.Echo(PO.join('\n'));

//--[EOF]------------------------------------------------------------
