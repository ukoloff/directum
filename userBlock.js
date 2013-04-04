//
// Блокирует пользователей Directum и удаляет их из пользователей SQL
//

var $={Dir:{	// Global variable
 Server:'Di1',		// Directum server
 DB:	'Directum'	// Directum database
}};

goDB();
X();

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

function dbGo(SQL, F)
{
 $.SQL.CommandText=readSnippet(SQL);
 for(var Rs=$.SQL.Execute(), N=0; !Rs.EOF; Rs.MoveNext(), N++)
 {
  var r={};
  for(var E=new Enumerator(Rs.Fields); !E.atEnd(); E.moveNext())
   r[E.item().name]=E.item().value;
  if(false===F(r, N)) break;
 }
}

/*--[List]-----------------------------------------------------------
Select
 UserKod, UserName, UserLogin
From MBUser
Where
 NeedEncode='W'
 And UserStatus<>'О'
 And UserCategory='О'
-------------------------------------------------------------------*/
function X()
{
 dbGo('List', function(R)
 {
  WScript.Echo(R.UserLogin, '\t', R.UserName);
 });
}

//--[EOF]------------------------------------------------------------
