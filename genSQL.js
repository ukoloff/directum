//
// Generate SQL users for Directum
//

var $={Dir:{	// Global variable
 Server:'Dir9',		// Directum server
 DB:	'Directum'	// Directum database
}};

//WScript.Interactive=false;
goDB();
readUsers();
Process();

//--[Functions]

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

function readUsers()
{
/*--[List]-----------------------------------------------------------
Select UserLogin
From MBUser
Where
 UserType='П'
 And NeedEncode='W'
 And UserCategory='О'
Order By 1
-------------------------------------------------------------------*/
 WScript.Echo("Getting user list...");

 $.U=[];
 $.SQL.CommandText=readSnippet('List');
 for(var Rs=$.SQL.Execute(); !Rs.EOF; Rs.MoveNext())
  $.U.push(Rs(0).value);
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

function Process()
{
 for(var i in $.U)
 {
  var u=$.U[i];
  if(!u2obj(u)) continue;
  WScript.Echo(u);
 }
}

//--[EOF]------------------------------------------------------------
