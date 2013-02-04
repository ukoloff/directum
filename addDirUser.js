//
//
//

var $={Dir:{			// Global variable
    Server: 'Dir9',		// Directum server
    DB: 	'Directum'	// Directum database
}};

//goW();
$.doc=newDoc();
startPage();

while(!$.closed && !$.window.welcome) WScript.Sleep(300);

if($.closed) WScript.Quit();

changePage('connect');
$.window.startSpinner();
sysInit();
countDown();

//--[Functions]

// Перезапуститься в wscript (убрать консоль)
function goW()
{
 WScript.Interactive=false;

 if(WScript.FullName.replace(/^.*[\/\\]/, '').match(/^w/i)) return;
 (new ActiveXObject("WScript.Shell")).Run('wscript //B "'+
    WScript.ScriptFullName+'"', 0, false);
 WScript.Quit();
}

// Переделать спецсимволы в HTML-коды
function html(S)
{
 S=''+S;
 var E={'&':'amp', '>':'gt', '<':'lt', '"':'quot'};
 for(var Z in E)
   S=S.split(Z).join('&'+E[Z]+';');
 return S;
}

// Открыть MSIE
function newDoc()
{
 var ie=WScript.CreateObject('InternetExplorer.Application');
 ie.AddressBar=false;
 ie.StatusBar=false;
 ie.ToolBar=false;
 ie.MenuBar=false;
 ie.Visible=true;
 ie.Navigate('about:blank');
 while(ie.Busy) WScript.Sleep(100);
 $.ie=ie;
 return ie.Document;
}

// Открыть стартовую страницу
function startPage()
{
 $.doc.open();
 $.doc.write(readSnippet('html'));
 $.doc.close();

 $.window=$.doc.parentWindow;
 $.doc.body.onunload=function(){ $.closed=1; }
 $.interior=$.doc.getElementById('Interior');
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

// Запустить обратный отсчёт до закрытия окна
function countDown()
{
 $.window.countDown($.ie);
 WScript.Quit();
}

// Выполнить один шаг инициализации
function doIt(Name, Fun)
{
 if(!$.stepN)$.stepN=1;

 var S=$.window.newStep();
 var t=$.interior.getElementsByTagName('table')[0];
 var r=t.insertRow();
 var c=r.insertCell();
 c.innerHTML=($.stepN++)+'. '+Name;
 c.noWrap=1;
 (S.Time=r.insertCell()).innerHTML='0.0';
 S.Time.align='Right';
 (S.Res=r.insertCell()).innerHTML='<BR />';
 $.window.Step=S;

 function updTime(Txt)
 {
  S.Res.innerHTML=Txt;
  $.window.Step=0;
  S.Time.innerHTML=(((new Date()).getTime()-S.ctime.getTime())/1000).toFixed(3);
 }

 try{ 
  Fun();
 }catch(e)
 {
  updTime(e.description);
  countDown();
 }
 if($.closed) WScript.Quit();
 updTime('Ok');
}

// Переключить содержимое окна на новое
function changePage(N)
{
 $.interior.innerHTML=readSnippet(N);
}

function sqlFetch()
{
 var X=[];
 for(var Rs=$.SQL.Execute(); !Rs.EOF; Rs.MoveNext())
 {
  var r={};
  for(var E=new Enumerator(Rs.Fields); !E.atEnd(); E.moveNext())
   r[E.item().name]=E.item().value;
  X.push(r);
 }
 return X;
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

// Найти код подразделения пользователя AD
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

// Найти все подразделения с указанным кодом
function findDepts(depId)
{
/*--[Depts.sql]------------------------------------------------------
Select
 Dep.Kod, Dep.NameAn
From
 MBVidAn As Z, MBAnalit As Dep
Where
 Z.Kod='ПОД' And Z.Vid=Dep.Vid And Dep.NomPodr=? 
Order By 2
-------------------------------------------------------------------*/
 $.SQL.CommandText=readSnippet('Depts.sql');
 $.SQL(0)=depId;
 return sqlFetch();
}

// Подключиться ко всем БД
function sysInit()
{
 var lp, SQL;
 doIt('Инициализация клиента Directum', function()
 { lp=new ActiveXObject("SBLogon.LoginPoint"); });

 doIt('Подключение к серверу Directum', function()
 {
  $.Dir.App=lp.GetApplication("ServerName="+$.Dir.Server+
    ";DBName="+$.Dir.DB+";IsOSAuth=1");
 });

 doIt('Проверка поддержки фотографий', function()
 {
  $.Dir.Photo=!!$.Dir.App.ReferencesFactory.ПРС.
    GetComponent().FindRequisite('Текст');
 });

 doIt('Подключение к серверу MS SQL', function()
 {
  SQL=new ActiveXObject("ADODB.Connection");
  SQL.Provider='SQLOLEDB';
  SQL.Open("Integrated Security=SSPI;Data Source="+$.Dir.Server);
  $.SQL=new ActiveXObject("ADODB.Command");
  $.SQL.ActiveConnection=SQL;
 });

 doIt('Выбор базы данных MS SQL', function()
 {
  SQL.DefaultDatabase='['+$.Dir.DB+']';
 });

 doIt('Подключение к Active Directory', function()
 {
  $.AD={};
  $.AD.rootDSE=GetObject("LDAP://rootDSE");
  $.AD.baseDN=$.AD.rootDSE.Get('rootDomainNamingContext');

  $.AD.h=new ActiveXObject("ADODB.Connection");
  $.AD.h.Provider = "ADsDSOObject";
  $.AD.h.Open("Active Directory Provider");

  $.AD.cmd=new ActiveXObject("ADODB.Command");
  $.AD.cmd.ActiveConnection=$.AD.h;
  $.AD.cmd.Properties("Page Size")=1000;
  $.AD.cmd.Properties("Searchscope")=2; // ADS_SCOPE_SUBTREE
 });

 doIt('Поиск пользователей Directum', function()
 {
/*--[user.sql]-------------------------------------------------------
Select U.Analit, U.Kod, X.UserKod, X.UserLogin, X.UserName
From MBAnalit As U, MBUser As X
Where
 U.Vid=(Select Vid from MBVidAn Where Kod='ПОЛ')
 And U.Dop=X.UserKod
 And X.UserStatus<>'О' And X.UserType='П'
 And X.UserCategory='О' And X.NeedEncode='W'
 And U.Analit not In
    (Select Polzovatel From MBAnalit Where
     Polzovatel is not Null
     And Vid=(Select Vid from MBVidAn Where Kod='РАБ'))
-------------------------------------------------------------------*/
  $.SQL.CommandText=readSnippet('user.sql');
  $.u=sqlFetch();
 });

 doIt('Поиск пользователей в AD', function()
 {
  for(var i in $.u)
  {
   var u=$.u[i];
   u.AD=u2obj(u.UserLogin);
  }
 });

 doIt('Поиск подразделений', function()
 {
  for(var i in $.u)
  {
   var u=$.u[i];
   u.Dept=depID(u.AD);
   u.Depts=u.Dept? findDepts(u.Dept) : [];
   WScript.Echo(u.UserKod, u.UserName, u.AD? u.AD.displayName:'-', u.Dept, u.Depts.length);
  }
 });

}

//--[Snippets]

/*--[html]-----------------------------------------------------------
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Автоматическая генерация персон, работников и контактов</title>

<style>

body	{
 background:	#A0C0E0 URL(about:blank) no-repeat fixed;
 margin:	0;
 padding:	0.3ex;
 color:		black;
 font-family:	Verdana, Arial, sans-serif;
 text-align:	justify;
}

#Footer {
 position: fixed;
 bottom: 0;
 left: 0;
 width: 100%;
 font-size: 87%;
 white-space:nowrap;
 border-top: 1px dashed navy;
}

* html #Footer {
 position: absolute;
 left: expression(eval(document.documentElement.scrollLeft));
 width: expression(eval(document.documentElement.clientWidth));
 top: expression(document.documentElement.clientHeight-this.offsetHeight+document.documentElement.scrollTop); 
 background: lime;
}

#C {
 background:	#B0D0F0;
}

#D {
 display:	none;
 background:	yellow;
 text-align:	center;
}

.Flip #C {
 display:	none;
}

.Flip #D {
 display:	block;
}

H1	{
 text-align:	right;
}

#pg1Btn {
 text-align:	right;
}

THead, TFoot {
 background:	white;
}

#Spinner {
 text-align:	center;
 padding:	0.3ex;
}

#Spinner Span {
 padding:	0 0.5ex;
 margin:	0 0.2ex;
 x-width:	1ex;
 border:	1px solid #EEEEEE;
}

</style>

<script>

function Welcome(B)
{
 B.disabled=true;
 window.welcome=1;
}

function startSpinner()
{
 var S='';
 for(var i=0; i<9; i++) S+='<Span>&nbsp;</Span>';
 var z=document.getElementById('Spinner');
 z.innerHTML=S;
 z=z.children;
 var N=0;
 var ntr=setInterval(function()
 {
  N++;
  var z=document.getElementById('Spinner');
  if(!z) return clearInterval(ntr);
  z=z.children;
  var L=z.length;
  var X=Math.round((Math.sin(N/3)/2+0.5)*L);
  for(var i=L-1; i>=0; i--)
  {
   var C=Math.round(Math.sqrt(Math.abs((i-X)/L))*255).toString(16);
   if(1==C.length)C='0'+C;
   z[i].style.borderColor='#'+C+C+C;
  }
  if(window.Step) window.Step.Time.innerHTML=
    (((new Date()).getTime()-window.Step.ctime.getTime())/1000).toFixed(1);
 }, 50);
}
 
function stopSpinner()
{
 var z=document.getElementById('Spinner');
 if(z) z.parentElement.removeChild(z);
}

function countDown(ie)
{
 stopSpinner();
 var z=document.getElementById('D');
 z.parentElement.className='Flip';
 z.getElementsByTagName('A')[0].onclick=function()
 {
  this.blur();
  clearInterval(ntr);
  z.parentElement.className='';
  return false;
 }
 var q=z.getElementsByTagName('span')[0];
 var Stop=(new Date()).getTime()+q.innerHTML*1000;
 var ntr=setInterval(function(){
  var n=Math.ceil((Stop-(new Date()).getTime())/1000);
  q.innerHTML=n;
  if(n>0) return;
  clearInterval(ntr);
  ie.Quit();
 }, 100);
}

function newStep()
{
 return {ctime: new Date()};
}

// Фокус на кнопку "нАчать"
setTimeout(function()
{
 document.getElementsByTagName('input')[0].focus();
}, 0);

</script>

</head><body>
<Div id='Footer'>
<Div id='C'>
&copy; ОАО "<A hRef='http://ekb.ru' Target='_blank'
onClick='this.blur()'>Уралхиммаш</A>", 2013
</Div>
<Div id='D'><A hRef='#'>Отменить</A> закрытие окна через
<Span>10</Span>
с
</Div>
</Div>
<H1>Настройка пользователей Directum
</H1>

<Div id='Interior'>
Эта программа помогает с первоначальной настройкой пользователей
системы электронного документооборота "Directum". Точнее говоря, она:
<UL>
<LI>Создаёт записи в справочниках Персоны и Работники
<LI>Обновляет данные в справочниках Пользователи и Контакты из Active Directory
<LI>Генерирует пользователей SQL
</UL>
<Div id='pg1Btn'>
<Input Type='Button' Value=' нАчать! &gt;&gt; ' onClick='Welcome(this)' />
</Div>
<HR />
Пользователей требуется создать в самом Directum:
<OL>
<LI>Откройте оснастку "Пользователи"
<LI>Добавьте новую запись (Ctrl+N)
<LI>Укажите имя (учётную запись в домене)
<LI>Введите какое-нибудь полное имя (можно ту же учётную запись)
<LI>Убедитесь, что выбрана "Windows-аутентификация"
<LI>Проверьте, что статус пользователя не "Отключён"
<LI>Возвращайтесь сюда и нажимайте кнопку "нАчать"
</OL>
<Center>Удачи!</Center>

</Div>

<Div><BR /></Div>
</body></html>
-------------------------------------------------------------------*/

/*--[connect]--------------------------------------------------------
<Table Border CellSpacing='0'>
<THead><TR><TH>Операция</TH>
<TH>Время</TH>
<TH Width='100%'>Результат</TH>
</TR></THead>
<TBody></TBody>
</Table>

<Div id='Spinner'></Div>
</Div>
-------------------------------------------------------------------*/

//--[EOF]------------------------------------------------------------
