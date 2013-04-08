//
// Сжать Log-файлы MS SQL
//

var Z=new ActiveXObject("ADODB.Connection");
Z.Provider='SQLOLEDB';
Z.Open("Integrated Security=SSPI;Data Source=(local)");
//Z.DefaultDatabase='master';

var L=[];

/*--[List]-----------------------------------------------------------
Select 
 D.name As DB, F.name, F.filename
From sysdatabases D, sysaltfiles F
Where D.dbid=F.dbid
 And F.status&64=64
-------------------------------------------------------------------*/
for(var Rs=Z.Execute(readSnippet('List')), N=0; !Rs.EOF; Rs.MoveNext(), N++)
{
 var r={};
 for(var E=new Enumerator(Rs.Fields); !E.atEnd(); E.moveNext())
  r[E.item().name]=E.item().value;
 L.push(r);
}

for(var i in L)
{
 var r=L[i];
 WScript.Echo(r.DB, r.name, r.filename);
 Z.DefaultDatabase=r.DB;
 Z.Execute("DBCC ShrinkFile('"+r.name+"')");
}

//--[Functions]

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

//--[EOF]------------------------------------------------------------
