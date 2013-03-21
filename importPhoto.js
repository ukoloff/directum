//
// Import user photo from AD to Directum
//

var $={Dir:{	// Global variable
 Server:'Dir9',		// Directum server
 DB:	'Directum'	// Directum database
}};

//WScript.Interactive=false;
goDB();
readUser();
goJpg();

//--[Functions]

function goDir()
{
 WScript.Echo("Connecting to Directum...");

 var lp=new ActiveXObject("SBLogon.LoginPoint");
 $.Dir.App=lp.GetApplication("ServerName="+$.Dir.Server+
    ";DBName="+$.Dir.DB+";IsOSAuth=1");
}

function goSQL()
{
 WScript.Echo("Connecting to MS SQL...");

 var SQL=new ActiveXObject("ADODB.Connection");
 SQL.Provider='SQLOLEDB';
 SQL.Open("Integrated Security=SSPI;Data Source="+$.Dir.Server);
 SQL.DefaultDatabase='['+$.Dir.DB+']';
 $.SQL=new ActiveXObject("ADODB.Command");
 $.SQL.ActiveConnection=SQL;
}

function goAD()
{
 WScript.Echo("Connecting to Active Directory...");

 $.AD={Domain: (new ActiveXObject("ADSystemInfo")).DomainShortName};
 $.AD.rootDSE=GetObject("LDAP://rootDSE");
 $.AD.baseDN=$.AD.rootDSE.Get('rootDomainNamingContext');

 $.AD.h=new ActiveXObject("ADODB.Connection");
 $.AD.h.Provider = "ADsDSOObject";
 $.AD.h.Open("Active Directory Provider");

 $.AD.cmd=new ActiveXObject("ADODB.Command");
 $.AD.cmd.ActiveConnection=$.AD.h;
 $.AD.cmd.Properties("Page Size")=1000;
 $.AD.cmd.Properties("Searchscope")=2; // ADS_SCOPE_SUBTREE
}

function goDB()
{
 goDir();
 goSQL();
 goAD();
}

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

function readUser()
{
/*--[List]-----------------------------------------------------------
Select
 Lgn.UserLogin, Prs.Analit
From
 MBAnalit As Wrk,
 MBAnalit As Prs,
 MBAnalit As Usr,
 MBUser As Lgn
Where Wrk.Vid=(Select Vid From MBVidAn Where Kod='РАБ')
 And Wrk.Persona=Prs.Analit And Wrk.Polzovatel=Usr.Analit
 And Usr.Dop=Lgn.UserLogin
 And Lgn.UserType='П' And Lgn.NeedEncode='W'
Order By 1
-------------------------------------------------------------------*/
 WScript.Echo("Getting user list...");

 $.U={};
 $.SQL.CommandText=readSnippet('List');
 for(var Rs=$.SQL.Execute(); !Rs.EOF; Rs.MoveNext())
  $.U[Rs('UserLogin').value]=Rs('Analit').value;
}

// Найти пользователя по имени в AD и вернуть все его данные
function u2obj(u)
{
 $.AD.cmd.CommandText="<LDAP://"+$.AD.baseDN+
    ">;(&(objectCategory=user)(sAMAccountName="+
    u.replace(/[()*\\]/g, '\\$&')+"));*;subTree";
 var Rs=$.AD.cmd.Execute();
 if(!Rs.EOF) return GetObject(Rs(0).Value);
}

function rnd(N)
{
 for(var S=''; S.length<(N||12); )
 {
  var n=Math.floor(62*Math.random());
  S+=String.fromCharCode('Aa0'.charCodeAt(n/26)+n%26);
 }
 return S;
}

function objOS()
{
 var os={};
 os.fso=new ActiveXObject("Scripting.FileSystemObject");
 os.sh=new ActiveXObject("WScript.Shell");
 os.tmpPath=os.sh.ExpandEnvironmentStrings('%TEMP%/');
 os.tmp=function()
 {
  do var n=this.tmpPath+rnd(); while(this.fso.FileExists(n));
  return n;
 };
 return os;
}

function storeJpg(Analit, File)
{
 var Prs=$.Dir.App.ReferencesFactory.ПРС.GetObjectById(Analit);
 WScript.Echo(Prs.Наименование);
 Prs.Requisites('Текст').LoadFromFile(File);
 Prs.Save();
}

function goJpg()
{
 WScript.Echo("Processing photos...");

 for(var u in $.U)
 {
  var AD=u2obj(u);
  if(!AD) continue;
  var J=AD.thumbnailPhoto;
  if(typeof(J)==typeof({}.x)) J=AD.jpegPhoto;
  if(typeof(J)==typeof({}.x)) continue;

  if(!$.os) $.os=objOS();

  var Path=$.os.tmp();

  var Stream=WScript.CreateObject("adodb.stream");
  Stream.Type=1;	//adTypeBinary
  Stream.Open();
  Stream.Write(J);
  Stream.SaveToFile(Path, 2);	//adSaveCreateOverWrite
  Stream.Close();

  storeJpg($.U[u], Path);

  $.os.fso.DeleteFile(Path);
 }
}

//--[EOF]------------------------------------------------------------
