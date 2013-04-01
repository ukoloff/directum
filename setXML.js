//
// Установка списка систем
//

var Sh=new ActiveXObject("WScript.Shell");
var F=Sh.RegRead('HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Explorer\\Shell Folders\\Common AppData')+
    '/NPO Computer/IS-Builder/SystemInfo.xml';

WScript.Echo(F);

// Выделить кусочек текста из исходного кода
function readSnippet(name)
{
 var f=WScript.CreateObject("Scripting.FileSystemObject").
    OpenTextFile(WScript.ScriptFullName, 1);	//ForReading
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

/*--[XML]------------------------------------------------------------
<?xml version="1.0" encoding="windows-1251" standalone="yes"?>
<Settings><SystemList><SettingGroup
 Code="DIRECTUM"
 Server="Di1"
 Database="Directum"
/></SystemList></Settings>
-------------------------------------------------------------------*/

//--[EOF]------------------------------------------------------------
