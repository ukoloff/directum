
// Скрипт для автоматической генерации персоны, работника и контакта

var user='grehova';
var Generate=1;		// Генерировать пользователя SQL

var Server='Directum';
var DB='Directum';

WScript.Echo("Поиск пользователя '"+user+"' в Active Directory...");
var adU=getUser(user);
if(!adU) Abort("Пользователь не найден!");
user=adU.sAMAccountName;			// Каноническое имя пользователя
WScript.Echo("Соединение с Directum...");
var D=goDirectum();
WScript.Echo("Соединение с SQL...");
var Q=goSQL();
var Cmd=new ActiveXObject("ADODB.Command");
var Rs;
Cmd.ActiveConnection=Q;

WScript.Echo("Поиск пользователя '"+user+"' в Directum");
Cmd.CommandText="Select Usr.Analit, Usr.Kod From MBVidAn As Z, MBAnalit As Usr " +
    "Where Z.Kod='ПОЛ' And Z.Vid=Usr.Vid And Dop=?";
Cmd(0)=user;
Rs=Cmd.Execute();
if(Rs.EOF) Abort("Пользователь не найден!");
var uID=Rs(0).Value;
var uKod=Rs(1).Value;

if(Generate)
{
 WScript.Echo("Генерация пользователя '"+user+"' в SQL");
 var e;
 try{ Q.sp_grantlogin("LAN\\"+user);    }catch(e){};
 try{ Q.sp_adduser("LAN\\"+user, user); }catch(e){};
}

WScript.Echo("Поиск работника в Directum");
Cmd.CommandText="Select Wrk.Analit From MBVidAn As Z, MBAnalit As Wrk "+
    "Where Z.Kod='РАБ' And Z.Vid=Wrk.Vid And Wrk.Polzovatel=?"
Cmd(0)=uID;
Rs=Cmd.Execute();
if(!Rs.EOF) Abort("Работник уже существует!");

WScript.Echo("Поиск подразделения в Directum");
Cmd.CommandText="Select Dep.Kod, Dep.NameAn From MBVidAn As Z, MBAnalit As Dep "+
    "Where Z.Kod='ПОД' And Z.Vid=Dep.Vid And Dep.NomPodr=? ";
Cmd(0)=depID(adU);
Rs=Cmd.Execute();
if(Rs.EOF) Abort("Подразделение не найдено!");
var depKod=Rs(0).Value;
WScript.Echo('Подразделение='+Rs(1));

WScript.Echo("Добавление персоны");
//WScript.Quit();
var Prs=D.ReferencesFactory.ПРС.GetComponent();
Prs.Open();
Prs.Insert();
Prs.Дополнение=adU.sn;		//Фамилия
Prs.Дополнение2=adU.givenName;	//Имя
Prs.Дополнение3=adU.middleName;	//Отчество
Prs.Строка2=adU.mail;		//Личный e-mail
Prs.Save();

WScript.Echo("Добавление работника");
var Wrk=D.ReferencesFactory.РАБ.GetComponent();
Wrk.Open();
Wrk.Insert();
Wrk.Персона=Prs.Код;
Wrk.Пользователь=uKod;
Wrk.Подразделение=depKod;
Wrk.Строка=adU.title;		//Должность
Wrk.Дополнение4=adU.telephoneNumber;
Wrk.Дополнение3=adU.employeeID	//Табельный номер
Wrk.Дополнение=adU.sn+' '+adU.givenName+' '+adU.middleName; //Фамилия И.О.
Wrk.Save();

WScript.Echo("Заполнение поля E-mail в Контакте");
var Knt=D.ReferencesFactory.КНТ.GetComponent();
Knt.Open();
if(!Knt.Locate('Персона', Prs.Код)) 
  WScript.Echo("Контакт не найден! :-(");
else
{
  Knt.Строка2=adU.mail;		//Личный e-mail
  Knt.Save();
}

WScript.Echo("Готово!");

function goDirectum()
{
 var lp=new ActiveXObject("SBLogon.LoginPoint");
 var D=lp.GetApplication("ServerName="+Server+";DBName="+DB+";IsOSAuth=1");
 return D;
}

function goSQL()
{
 var Conn=new ActiveXObject("ADODB.Connection");
 Conn.Provider='SQLOLEDB';
 Conn.Open("Integrated Security=SSPI;Data Source="+Server);
 Conn.DefaultDatabase=DB;
 return Conn;
}

function getUser(u)
{
 var ADS_SCOPE_SUBTREE = 2;

 var Conn=new ActiveXObject("ADODB.Connection");
 var Cmd=new ActiveXObject("ADODB.Command");
 Conn.Provider = "ADsDSOObject";
 Conn.Open("Active Directory Provider");
 Cmd.ActiveConnection=Conn;

 Cmd.Properties("Page Size")=1000;
 Cmd.Properties("Searchscope")=ADS_SCOPE_SUBTREE;

 Cmd.CommandText=
     "SELECT * FROM 'LDAP://dc=lan,dc=uxm' WHERE objectCategory='user' "+
     "And sAMAccountName='"+u.replace("'", "")+"'";
 var Rs=Cmd.Execute();
 if(Rs.EOF) return;
 return GetObject(Rs.Fields(0).Value);
}

function depID(user)
{
 if(!user) return;
 while(user=GetObject(user.Parent))
 {
  if(!user.ou) return;
  var i=user.l;
  if(!i) continue;
  if(!i.match(/^\d+$/)) return;
  return i;
 }
}

function Abort(S)
{
 WScript.Echo(S);
 WScript.Quit();
}

//--[EOF]--------------------------------------------------------------------
