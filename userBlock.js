//
// Блокирует пользователей Directum и удаляет их из пользователей SQL
//

var $={Dir:{	// Global variable
 Server:'Di1',		// Directum server
 DB:	'Directum'	// Directum database
}};

goDB();
BlockFromAD();

/*--[XPOL]-----------------------------------------------------------
Update MBAnalit
Set Sost='З'
From MBUser As U, MBAnalit As A, MBVidAn As R
Where U.UserStatus='О' And U.NeedEncode='W'
 And A.Dop=U.UserKod And A.Sost<>'З'
 And A.Vid=R.Vid And R.Kod='ПОЛ'
-------------------------------------------------------------------*/
Action('XPOL', 'Закрытие неактивных записей справочника Пользователи');

/*--[EPOL]-----------------------------------------------------------
Update MBAnalit
Set Sost='Д'
From MBUser As U, MBAnalit As A, MBVidAn As R
Where U.UserStatus<>'О' And U.NeedEncode='W'
 And A.Dop=U.UserKod And A.Sost='З'
 And A.Vid=R.Vid And R.Kod='ПОЛ'
-------------------------------------------------------------------*/
Action('EPOL', 'Открытие заново активированных записей справочника Пользователи');

/*--[RAB]------------------------------------------------------------
Update W
Set Sost=U.Sost
From MBAnalit As U, MBAnalit As W, MBVidAn As R, MBUser As X
Where R.Kod='РАБ' And W.Vid=R.Vid
 And W.Polzovatel=U.Analit And W.Sost<>U.Sost
 And U.Dop=X.UserKod And X.NeedEncode='W'
-------------------------------------------------------------------*/
Action('RAB', 'Копирование статуса строк справочника Пользователи в справочник Работники');

/*--[PRS]------------------------------------------------------------
Update P
Set Sost=W.Sost
From MBAnalit As P, MBAnalit As W, MBVidAn As R
Where R.Kod='РАБ' And W.Vid=R.Vid
 And W.Persona=P.Analit
 And W.Sost<>P.Sost
-------------------------------------------------------------------*/
Action('PRS', 'Копирование статуса строк справочника Работники в справочник Персоны');

killUsers();
killLogins();

WScript.Echo("That's all folks!");

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

function Action(SQL, Note)
{
 WScript.Echo(Note+"...");
 $.SQL.CommandText=readSnippet(SQL);
 $.SQL.Execute();
}

/*--[qUsers]---------------------------------------------------------
Select
 name 
From sysusers
Where name in
 (Select UserKod
  From MBUser
  Where UserStatus='О' And NeedEncode='W')
-------------------------------------------------------------------*/
function killUsers()
{
 WScript.Echo('Удаление пользователей SQL...');
 dbGo('qUsers', function(R)
 {
  WScript.Echo('user:', R.name);
  try{$.SQL.ActiveConnection.sp_dropuser(R.name); } catch(e){};
 });
}

/*--[DDL]------------------------------------------------------------
Create Table #Do(
 main NVarChar(255)
)
-------------------------------------------------------------------*/
/*--[DML]------------------------------------------------------------
Insert Into #Do(main) Values(?+'\')
-------------------------------------------------------------------*/
/*--[qLogins]--------------------------------------------------------
Select name
From master..syslogins
Where name in
 (Select (Select main From #Do)+UserLogin Collate Cyrillic_General_CI_AS
  From MBUser
  Where UserStatus='О' And NeedEncode='W')
-------------------------------------------------------------------*/
function killLogins()
{
 WScript.Echo('Удаление логинов SQL...');
 $.SQL.CommandText=readSnippet('DDL');
 $.SQL.Execute();
 $.SQL.CommandText=readSnippet('DML');
 $.SQL(0)=$.AD.Domain;
 $.SQL.Execute();
 dbGo('qLogins', function(R)
 {
  WScript.Echo('login:', R.name);
  try{$.SQL.ActiveConnection.sp_revokelogin(R.name);} catch(e){};
 });
}

//--[EOF]------------------------------------------------------------
