//
// Удаление Directum v4.6.1 и установка v4.9.1
//

var $={};
Init();
needAdmin();
goW();
killLnk();
unInstall();
msiInstall();
putXML();

//--[Functions]

function Init()
{
 $.sh=new ActiveXObject("WScript.Shell");
 $.fso=WScript.CreateObject("Scripting.FileSystemObject");
}

// Перезапуститься в wscript (убрать консоль)
function goW()
{
 WScript.Interactive=false;

 if(WScript.FullName.replace(/^.*[\/\\]/, '').match(/^w/i)) return;
 $.sh.Run('wscript //B "'+WScript.ScriptFullName+'"', 0, false);
 WScript.Quit();
}

// Выделить кусочек текста из исходного кода
function readSnippet(name)
{
 var f=$.fso.OpenTextFile(WScript.ScriptFullName, 1);	//ForReading
 var on, R='';
 while(!f.AtEndOfStream)
 {
  var s=f.ReadLine();
  if(!on)
  {
   if(s.match(/^\s*\/\*[-\s]*\[([.\w]+)\][-\s]+$/i) && (RegExp.$1==name)) on=1;
   continue;
  }
  if(s.match(/^[-\s]+\*\/\s*$/)) break;
  R+=s+'\n';
 }
 f.Close();
 return R;
}

function isAdmin()
{
 try{
  $.sh.RegRead('HKEY_USERS\\S-1-5-20\\Environment\\TMP');
  return true;
 }catch(e){};
}

function needAdmin()
{
 if(isAdmin()) return;
 WScript.Interactive=true;
 $.sh.PopUp('Administrative priveleges required!', 10);
 WScript.Quit();
}

function unlink(f)
{
 try{ $.fso.DeleteFile(f+'/Directum.lnk'); }catch(e){}
}

function killLnk()
{
 var Key="SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\ProfileList";
 var Paths=['Desktop', 'Рабочий стол',
    'Application Data\\Microsoft\\Internet Explorer\\Quick Launch'];

 var R=GetObject("winmgmts:\\\\.\\root\\default:StdRegProv");
 var M=R.Methods_.Item("EnumKey");
 var PI=M.InParameters.SpawnInstance_(); 
 PI.hDefKey=0x80000002;	// HKLM
 PI.sSubKeyName=Key;
 var Us=VBArray(R.ExecMethod_(M.Name, PI).sNames).toArray();

 for(var i in Us)
 {
  var S=Us[i];
  var Path=$.sh.RegRead('HKLM\\'+Key+'\\'+S+'\\ProfileImagePath');
  Path=$.sh.ExpandEnvironmentStrings(Path);
  for(var j in Paths) unlink(Path+'/'+Paths[j]);
 }

 unlink($.sh.SpecialFolders('AllUsersDesktop'));
}

function unInstall()
{
 $.sh.Run('msiexec /X {C8CD9C47-E330-452D-BB4C-A0F064F2135B} /passive',
    1, true);
}

function msiInstall()
{

 $.sh.Run('msiexec /I "'+
    $.fso.GetParentFolderName(WScript.ScriptFullName)+
    '\\Client.msi" '+
    readSnippet('Run').replace(/[\n\r]/g, ' '),
 1, true);
}

function putXML()
{
 var F=$.sh.RegRead('HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\Common AppData')+
    '/NPO Computer/IS-Builder/SystemInfo.xml';

 var X=$.fso.CreateTextFile(F, true);
 X.Write(readSnippet('XML'));
 X.Close();
}

/*--[Run]------------------------------------------------------------
/passive
DIRCODE=DIRECTUM
DIRLOGPATH=\\Directum\Log\4.9.1 
DIRPROFILELOGPATH=\\Directum\Log\4.9.1\Profile
DIRADMINMAIL=directum@ekb.ru 
DIRSCDESKTOP=1
DIRSCADMINUTIL=0 
DIR_SC_AUTORUN=0
-------------------------------------------------------------------*/

/*--[XML]------------------------------------------------------------
<?xml version="1.0" encoding="windows-1251" standalone="yes"?>
<Settings><SystemList><SettingGroup
 Code="DIRECTUM"
 Server="Directum"
 Database="Directum"
/></SystemList></Settings>
-------------------------------------------------------------------*/

//--[EOF]------------------------------------------------------------
