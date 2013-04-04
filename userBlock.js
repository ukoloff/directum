//
// Блокирует пользователей Directum и удаляет их из пользователей SQL
//

var $={Dir:{	// Global variable
 Server:'Di1',		// Directum server
 DB:	'Directum'	// Directum database
}};

goDB();
BlockFromAD();

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

// Найти пользователя по имени в AD и вернуть все его данные
function u2obj(u)
{
 $.AD.cmd.CommandText="<LDAP://"+$.AD.baseDN+
    ">;(&(objectCategory=user)(sAMAccountName="+
    u.replace(/[()*\\]/g, '\\$&')+"));*;subTree";
 var Rs=$.AD.cmd.Execute();
 if(!Rs.EOF) return GetObject(Rs(0).Value);
}

/*--[List]-----------------------------------------------------------
Select
 UserID, UserKod, UserName, UserLogin
From MBUser
Where
 NeedEncode='W'
 And UserStatus<>'О'
 And UserCategory='О'
-------------------------------------------------------------------*/
function BlockFromAD()
{
 WScript.Echo("Looking Directum users in AD...");

 var U=[];
 dbGo('List', function(R)
 {
  var iu=u2obj(R.UserLogin);
  if(iu && iu.userAccountControl&2)
    U.push(R.UserID);
 });
/*--[Block]----------------------------------------------------------
Update MBUser
Set
 UserStatus='О'
Where UserID=?
-------------------------------------------------------------------*/
 $.SQL.CommandText=readSnippet('Block');
 for(var i in U)
 {
  $.SQL(0)=U[i];
  $.SQL.Execute();
 }
}

//--[EOF]------------------------------------------------------------
