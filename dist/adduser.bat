0</*! :: See https://github.com/ukoloff/directum
@echo off
start wscript.exe //e:javascript "%~f0" %* Directum/Directum
goto :EOF */0;
!function(n){function t(r){if(e[r])return e[r].exports;var o=e[r]={exports:{},id:r,loaded:!1};return n[r].call(o.exports,o,o.exports,t),o.loaded=!0,o.exports}var e={};return t.m=n,t.c=e,t.p="",t(0)}([function(n,t,e){(function(n,t,r,o){var i;i=e(28),n.open(),n.write(i({c:e(56),z:t[0]})),n.close(),r("input").pop().focus(),e(24)(),e(20),e(32),o.start()}).call(t,e(16),e(9),e(12),e(18))},function(n,t){n.exports="undefined"!=typeof WScript&&null!==WScript?WScript:null},,function(n,t){n.exports=new ActiveXObject("WScript.Shell")},function(n,t){n.exports=function(n,t){var e,r,o;for("function"!=typeof t&&(o=[]),r=0,e=new Enumerator(n);!e.atEnd();){if(o)o.push(e.item());else if(!1===t(e.item(),r++))return;e.moveNext()}return o}},function(n,t){n.exports=new ActiveXObject("Scripting.FileSystemObject")},function(n,t,e){(function(n){var t,e,r;e=this.h,this.connect=function(n,t){return this.h=e=new ActiveXObject("ADODB.Connection"),e.Provider="SQLOLEDB",e.Open("Integrated Security=SSPI;Data Source="+n),t&&r(t),e},this.use=r=function(n){return e.DefaultDatabase="["+n+"]"},this.command=function(n){var t;return t=new ActiveXObject("ADODB.Command"),t.ActiveConnection=e,t.CommandText=n,t},this.fields=t=function(t){var e;if(!t.EOF)return e={},n(t.Fields,function(n){e[n.name]=n.value}),e},this.execute=function(n,e){var r,o,i,u;for(o=0,"function"!=typeof e&&(i=[]),u=n.Execute();!u.EOF;)if(r=t(u),u.MoveNext(),i)i.push(r);else if(!1===e(r,o++))return;return i}}).call(t,e(4))},function(n,t){var e,r,o=[].slice;n.exports=r=new Function("o,k,v","o(k)=v"),r.a=e=function(n,t){var e,o,i,u;for(e=o=0,i=t.length;i>o;e=++o)u=t[e],r(n,e,u);return n},r.l=function(){var n,t;return t=arguments[0],n=2<=arguments.length?o.call(arguments,1):[],e(t,n)},r.o=function(n,t){var e,o,i,u;for(u=e=0,i=t.length;i>e;u=++e)o=t[u],r(n,o,u);return n}},function(n,t,e){(function(t){n.exports=function(n){return null==n&&(n=0),t.Quit(n)}}).call(t,e(1))},function(n,t,e){(function(t,e){n.exports=t(e.Arguments)}).call(t,e(4),e(1))},function(n,t){n.exports=function(n){var t,e;for(null==n&&(n=12),e="";e.length<n;)t=Math.floor(62*Math.random()),e+=String.fromCharCode("Aa0".charCodeAt(t/26)+t%26);return e}},function(n,t,e){(function(n,t){var e,r,o,i,u,c;u=o=c=e=i=this.h,this.connect=function(){return this.info=u=new ActiveXObject("ADSystemInfo"),this.dc=o=u.DomainShortName,this.rootDSE=c=GetObject("LDAP://rootDSE"),this.base=e=c.Get("rootDomainNamingContext"),this.h=i=new ActiveXObject("ADODB.Connection"),i.Provider="ADsDSOObject",i.Open("Active Directory Provider"),i},this.cmd=r=function(t){var e;return e=new ActiveXObject("ADODB.Command"),e.ActiveConnection=i,n.o(e.Properties,{"Page Size":1e3,Searchscope:2}),e.CommandText=t,e},this.user=function(n){var t;return t=r("<LDAP://"+e+">;(&(objectCategory=user)(sAMAccountName="+n.replace(/[()*\\]/g,"\\$&")+"));*;subTree").Execute(),t.EOF?void 0:GetObject(t(0).Value)},this.photo=function(n){var e,r;if(null!=n.thumbnailPhoto)n=n.thumbnailPhoto;else{if(null==n.jpegPhoto)return;n=n.jpegPhoto}return e=new ActiveXObject("ADODB.Stream"),e.Type=1,e.Open(),e.Write(n),e.SaveToFile(r=t(),2),e.Close(),r}}).call(t,e(7),e(14))},function(n,t,e){(function(t){var e,r;n.exports=e=function(n,e){switch(null==e&&(e=t),n=String(n),n.substring(0,1)){case"#":return[e.getElementById(n.substring(1))];case".":return r(e.getElementsByTagName(n.substring(1)));default:return r(e.getElementsByTagName(n))}},r=function(n){var t,e,r,o;for(r=[],t=0,e=n.length;e>t;t++)o=n[t],r.push(o);return r}}).call(t,e(16))},,function(n,t,e){(function(t,e,r){var o;o=t.ExpandEnvironmentStrings("%TEMP%"),n.exports=function(){var n,t,i;for(n=t=1;16>=t;n=++t)if(!e.FileExists(i=e.BuildPath(o,r())))return i;throw Error("Cannot create temporary file")}}).call(t,e(3),e(5),e(10))},function(n,t){var e,r,o,i;i=o=e=0,this.init=r=function(){return this.lp=o=new ActiveXObject("SBLogon.LoginPoint")},this.connect=function(n,t){return o||r(),this.app=e=o.GetApplication("ServerName="+n+";DBName="+t+";IsOSAuth=1")},this.photo=function(n,t){var e;if(t)return e=n.Requisites("�����"),e.LoadFromFile(t),e.Extension="jpg",n.�����="��"}},function(n,t,e){(function(t,e){n.exports="undefined"!=typeof t&&null!==t?e().Document:document}).call(t,e(1),e(47))},function(n,t,e){var r;!function(){function o(n){return String(n).replace(/[&<>"]/g,function(n){return x[n]})}function i(n){var t,e;for(t=0;t<n.length;t++)null!=(e=n[t])&&("function"==typeof e?e.call(y):E+=o(e))}function u(n){var t,e;for(t=0;t<n.length;t++)null!=(e=n[t])&&(E+=o(e))}function c(n){var t,e;for(t=0;t<n.length;t++)null!=(e=n[t])&&(E+=e)}function a(n,t){function e(n,t){null!=t&&!1!==t&&(E+=" "+o(n),!0!==t&&(E+='="'+o(t)+'"'))}function r(n,t){for(var o in t)"object"==typeof t[o]?r(n+o+"-",t[o]):e(n+o,t[o])}function u(o){E+="<"+n;var u=o[0];if("object"==typeof u){for(var c in u)"data"==c&&"object"==typeof u[c]?r("data-",u[c]):e(c,u[c]);o=S.call(o,1)}if(E+=">",t&&o.length)throw new SyntaxError("<"+n+"> must have no content!");t||(i(o),E+="</"+n+">")}return function(){u(arguments)}}function l(){function n(){E+=t++?'<comment level="'+t+'">':"<!-- ",i(arguments),E+=--t?"</comment>":" -->"}var t=0;return function(){n.apply(this,arguments)}}function f(){if(1!=arguments.length||"function"!=typeof arguments[0])throw new SyntaxError("Usage: coffeescript -> code");E+="<script><!--\n("+arguments[0].toString()+")()\n//-->\n</script>"}function s(){function n(n){for(var t in D)if(n==D[t])return!0}function t(t,e){return a(t,null==e?n(String(t).toLowerCase()):e)}return function(n,e){return t(n,e)}}function p(n){i("object"==typeof n?S.call(arguments,1):arguments)}function d(){var n=[];for(var t in w)n.push(t+"=this."+t);return"var "+n.join(",")}function h(n,t,e){function r(){a&&i();try{var t=y,e=E;return y=this,E="",u(),n.apply(this,arguments),E}finally{y=t,E=e}}function o(){var n=t.id;return null==n&&(n=""),n=String(n).split(/\W+/).join("/").replace(/^\/+|\/+$/g,""),n.length||(n=++O),t.id=n,e&&(n+="["+e+"]"),n}function i(){var e;n=n.toString(),c=!/[\r\n]/.test(n),n=d()+"\nreturn "+n,c||(n+="\n//# sourceURL=eval://withOut/"+(e=o())+".wo"),n=new Function(n).call(w),c||(n.displayName="<"+e+">",t.displayName="{{"+e+"}}")}function u(){return c||!1===m.bp?void 0:m.bp?!0:e&&"number"==typeof t.bp?e==t.bp:t.bp}if("function"!=typeof n)throw new TypeError("Call: withOut.compile(function)");var c,a=!0;return t.id=null,r}function v(n){function t(){return e.apply(this,arguments)}var e=h(n,t);return t}function m(n){function t(n){return e.apply(n,arguments)}var e=h(n,t);return t}function g(n){var t,e=[];for(var r in n)"object"==typeof(t=n[r])?e.push.apply(e,g(t)):e.push(t);return e}function b(n){function t(n){return e.apply(n,arguments)}function e(){var n="";o||r();for(var t in i)n+=i[t].apply(this,arguments);return n}function r(){var n,e=t.id;for(var r in i){if("function"!=typeof(n=i[r])&&"function"!=typeof(n=JST[n]))throw new Error("JST['"+i[r]+"'] not found or incorrect!");i[r]=h(n,t,Number(r)+1)}t.id=e,o=!0}var o,i=g(S.call(arguments));return t.id=null,t}var y,A="a abbr acronym address applet article aside audio b bdo big blockquote body button canvas caption center cite code colgroup command datalist dd del details dfn dir div dl dt em embed fieldset figcaption figure font footer form frameset h1 h2 h3 h4 h5 h6 head header hgroup html i iframe ins keygen kbd label legend li map mark menu meter nav noframes noscript object ol optgroup option output p pre progress q rp rt ruby s samp script section select small source span strike strong style sub summary sup table tbody td textarea tfoot th thead time title tr tt u ul video wbr xmp".split(" "),D="area base basefont br col frame hr img input link meta param".split(" "),x={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;"},S=[].slice,w={},O=0,E="";w.print=w.text=function(){u(arguments)},w.raw=function(){c(arguments)},w.tag=s(),w.notag=function(){p.apply(this,arguments)},w.comment=l(),w.blackhole=function(){},w.coffeescript=function(){f.apply(this,arguments)};for(var N in A)w[A[N]]=a(A[N]);w.$var=a("var");for(var N in D)w[D[N]]=a(D[N],!0);m.$compile=m,m.compile=v,m.renderable=v,m.JSTs=b,"undefined"!=typeof n&&n.exports?n.exports=m:(r=function(){return m}.call(t,e,t,n),!(void 0!==r&&(n.exports=r)))}()},function(n,t,e){(function(t,e,r){var o;n.exports=o=[],o.start=function(){var n;for(e.body.onunload=function(){return o.unshift(function(){return t(1)})};;){for(;n=o.shift();)n();r.Sleep(100)}}}).call(t,e(8),e(16),e(1))},function(n,t,e){(function(t){n.exports=t("div").shift()}).call(t,e(12))},function(n,t,e){(function(n){var r,o;r=n.forms[0],this.test=o=function(){var n,e,o,i,u,c;for(c="s d".split(" "),e=o=0,u=c.length;u>o;e=++o)if(i=c[e],n=r[e],!/^\w+$/.test(t[i]=n.value.replace(/^\s+|\s+$/g,"")))return n.focus(),n.select(),!1;return!0},r.onsubmit=function(){return o()&&e(26),!1}}).call(t,e(16))},function(n,t,e){(function(t,e,r){n.exports=function(){var n,o,i,u,c,a;for(c="",u=["(x86)",""],n=0,o=u.length;o>n;n++)if(a=u[n],i=t.ExpandEnvironmentStrings("%ProgramFiles"+a+"%")){try{i=e.GetFolder(e.BuildPath(i,"DIRECTUM Company"))}catch(l){continue}r(i.SubFolders,function(n){return i=e.BuildPath(n.Path,"SBLauncher.exe"),e.FileExists(i)?c=i:void 0})}return c}()}).call(t,e(3),e(5),e(4))},function(n,t,e){(function(t,r,o){var i,u,c,a,l,f,s,p,d,h,v;for(h=e(23).users,s=e(25),r.innerHTML=s({users:h,sys:t.app.Connection.SystemInfo}),e(24)(),i=o("input",r).pop(),p=o("tbody",r).pop(),u=function(){var n,t,e,r;for(e=p.rows,r=[],n=0,t=e.length;t>n;n++)f=e[n],r.push(v=o("input",f.cells[0]).pop());return r}(),o("input",o("tfoot",r)[0]).pop().onclick=function(){var n,t,e;for(n=this.checked,t=0,e=u.length;e>t;t++)v=u[t],v.disabled||(v.checked=n);return d()},d=function(){var n,t;for(n=0,t=u.length;t>n;n++)if(v=u[n],v.checked&&!v.disabled)return void(i.disabled=!1);return i.disabled=!0},a=0,l=u.length;l>a;a++)v=u[a],v.onclick=d;c=function(){var t,e,r,i,c,a,l;for(n.exports=a=[],c=p.rows,t=r=0,i=c.length;i>r;t=++r)f=c[t],u[t].checked&&!u[t].disabled&&(l=h[t],e=l.Depts.length>1?o("select",f).pop().selectedIndex:0,l.Dept=l.Depts[e],a.push(l));return a},i.onclick=function(){return c().length?e(29):void 0}}).call(t,e(15),e(19),e(12))},function(n,t,e){(function(t,r,o,i){var u,c,a,l;l=e(20),n.exports=c=[],u=function(n,t){return c.push({title:n,fn:t})},u("������������� ������� Directum",function(){return t.init()}),u("����������� � ������� Directum",function(){return t.connect(l.s,l.d)}),u("����������� � ������� MS SQL",function(){return r.connect(l.s)}),u("����� ���� ������ MS SQL",function(){return r.use(l.d)}),u("����������� � Active Directory",function(){return o.connect()}),a=[],u("����� ������������� Directum",function(){return c.users=a=r.execute(r.command("Select U.Analit, U.Kod, X.UserKod, X.UserLogin, X.UserName\nFrom MBAnalit As U, MBUser As X\nWhere\n U.Vid=(Select Vid from MBVidAn Where Kod='���')\n And U.Dop=X.UserKod\n And X.UserStatus<>'�' And X.UserType='�'\n And X.UserCategory='�' And X.NeedEncode='W'\n And U.Analit not In\n    (Select Polzovatel From MBAnalit Where\n     Polzovatel is not Null\n     And Vid=(Select Vid from MBVidAn Where Kod='���'))"))}),u("����� ������������� � AD",function(){var n,t,e,r;for(e=[],n=0,t=a.length;t>n;n++)r=a[n],e.push(r.AD=o.user(r.UserLogin));return e}),u("����� �������������",function(){var n,t,e,r;for(e=[],n=0,t=a.length;t>n;n++)r=a[n],e.push(r.Depts=i.list(r.Dept=i.id(r.AD)));return e})}).call(t,e(15),e(6),e(11),e(49))},function(n,t,e){(function(t,e){n.exports=function(){var n,r,o,i,u;for(o=t("a"),i=[],n=0,r=o.length;r>n;n++)u=o[n],u.target&&i.push(function(n){return u.onclick=function(){return e.run(n),!1}}(u.href));return i}}).call(t,e(12),e(3))},function(n,t,e){(function(t){n.exports=t(function(){var n;return n={ServerVersion:"������ �������",ClientVersion:"������ �������",Name:"������������",ServerName:"������",DatabaseName:"���� ������",Code:"��� �������"},ul(function(){var t,e,r;e=[];for(t in n)r=n[t],e.push(li(function(){return b(r)},": ",this.sys[t]));return e}),table({border:!0,cellspacing:0},function(){return thead(function(){var n,t,e,r,o;for(e="�,������������,���,���. �,���������,���,�������������".split(","),r=[],n=0,t=e.length;t>n;n++)o=e[n],r.push(th(o));return r}),tbody(function(){var n,t,e,r,o,i;for(r=this.users,o=[],n=t=0,e=r.length;e>t;n=++t)i=r[n],o.push(tr({"class":1&n?"odd":"even"},function(){var t,e,r;return td({align:"right",nowrap:"true"},function(){return label(n+1," ",function(){return input({type:"checkbox",disabled:!i.Depts.length})})}),td(function(){return i.AD?a({href:"https://ekb.ru/omz/dc/user/?u="+i.AD.sAMAccountName,target:"_blank"},i.AD.sAMAccountName):text(i.UserLogin)}),td(null!=(t=i.AD)?t.displayName:void 0),td(null!=(e=i.AD)?e.employeeId:void 0),td(null!=(r=i.AD)?r.title:void 0),td(i.Dept),td(function(){switch(i.Depts.length){case 0:return function(){return center("-")};case 1:return i.Depts[0].NameAn;default:return function(){return select(function(){var n,t,e,r;for(e=i.Depts,n=0,t=e.length;t>n;n++)r=e[n],option({value:r.Analit},r.NameAn);return!1})}}}())}));return o}),tfoot(function(){return td({align:"right"},function(){return label("* ",function(){return input({type:"checkbox"})})}),td({colspan:6},"��� ���������")})}),div({"class":"text-right"},function(){return input({type:"button",disabled:!0,value:" ������������! >> "})})})}).call(t,e(17))},function(n,t,e){(function(n,t,r,o,i,u){var c,a,l,f,s;c=e(23),a=e(27),f=n(function(){return b(this.message)}),t.innerHTML=a(c),l=r("tbody",t).pop(),s=o.parentWindow,i.push(function(){var n,t,r,o,i,a,p,d,h;for(i=a=0,p=c.length;p>a;i=++a){d=c[i],n=l.rows[i].cells,h=s.Timer(n[2]);try{d.fn(),n[3].innerHTML="+"}catch(o){t=o,n[3].innerHTML=f(t),r=!0;break}finally{h.stop()}}return r&&u(1),e(22)})}).call(t,e(17),e(19),e(12),e(16),e(18),e(8))},function(n,t,e){(function(t){n.exports=t(function(){return table({border:!0,cellspacing:0},function(){return thead(function(){var n,t,e,r,o;for(e="� �������� ����� ���������".split(" "),r=[],n=0,t=e.length;t>n;n++)o=e[n],r.push(th(o));return r}),tbody(function(){var n,t,e,r,o;for(r=[],n=t=0,e=this.length;e>t;n=++t)o=this[n],r.push(tr({"class":1&n?"odd":"even"},function(){return td({align:"right"},n+1),td(o.title),td({align:"right"},br),td({align:"center"},br)}));return r})})})}).call(t,e(17))},function(n,t,e){(function(t){n.exports=t(function(){return html(function(){return head(function(){return meta({"http-equiv":"Content-Type",content:"text/html; charset=windows-1251"}),title("�������������� ��������� ������, ���������� � ���������"),style(this.c),coffeescript(function(){return this.Timer=function(n){var t,e,r;return r=new Date,(t=function(){return n.innerHTML=((new Date-r)/1e3).toFixed(2)})(),e=setInterval(t,100),{stop:function(){return clearInterval(e),t()}}}})}),body(function(){return h1("��������� ������������� Directum"),div(function(){return text('��� ��������� �������� � �������������� ���������� �������������\n������� ������������ ���������������� "Directum". ������ ������, ���:'),ul(function(){return li("������ ������ � ������������ ������� � ���������"),li("��������� ������ � ������������ ������������ � ��������"),li("���������� ������������� SQL"),li("�������� ���������� �������������")}),form(function(){return center(function(){var n,t,e,r,o,i;for(i=(this.z||"").split("/"),o=["������","���� ������"],n=t=0,e=o.length;e>t;n=++t)r=o[n],label(r," ",function(){return input({value:i[n]||"Directum",required:!0})}),text(" ");return input({type:"submit",value:" ������! >> "})})}),hr(),text("������������� ��������� ������� � ����� Directum:"),ol(function(){return li('�������� �������� "',function(){return a({href:"#"},"������������")},'"'),li("�������� ����� ������ (Ctrl+N)"),li("������� ��� (������� ������ � ������)"),li("������� �����-������ ������ ��� (����� �� �� ������� ������)"),li('���������, ��� ������� "Windows-��������������"'),li("���� ���� ���� NetBIOS (Domain), ������� ���� ��� ������"),li('���������, ��� ������ ������������ �� "��������"'),li('������������� ���� � ��������� ������ "������"')}),center("�����!")}),p(),div({id:"Footer"},function(){return a({id:"github",href:"https://github.com/ukoloff/directum",target:"_blank"},"Source"),raw("&copy; ��� &laquo;"),a({href:"http://ekb.ru",target:"_blank"},"����������"),raw("&raquo;, 2013 - ",(new Date).getFullYear())})})})})}).call(t,e(17))},function(n,t,e){(function(n,t,r){var o,i,u,c,a;a=e(22),i=e(31),u=e(30),n.innerHTML=u({steps:i,users:a}),c=t("tbody",n).pop(),r.push(function(){var n,t,e,r,u,l,f,s,p,d,h,v;for(r=u=0,f=a.length;f>u;r=++u)for(v=a[r],d=c.rows[r],p=l=0,s=i.length;s>l;p=++l){h=i[p],n=d.cells[2+p];try{h.fn(v),n.innerHTML="+"}catch(e){t=e,n.innerHTML="#",n.title=t.message}}return o()}),o=function(){return t("center",n).pop().innerHTML="That's all folks!"}}).call(t,e(19),e(12),e(18))},function(n,t,e){(function(t){n.exports=t(function(){return table({border:!0,cellspacing:0},function(){return thead(function(){var n,t,e,r,o,i,u,c;for(o="� ������������".split(" "),n=0,e=o.length;e>n;n++)c=o[n],th(c);for(i=this.steps,u=[],t=0,r=i.length;r>t;t++)c=i[t],u.push(th({title:c.title},c.id));return u}),tbody(function(){var n,t,e,r,o,i;for(r=this.users,o=[],n=t=0,e=r.length;e>t;n=++t)i=r[n],o.push(tr({"class":1&n?"odd":"even"},function(){var t,e;for(td({align:"right"},n+1),td(i.AD.sAMAccountName),e=[],n=t=1;5>=t;n=++t)e.push(td({align:"center"},br));return e}));return o})}),center()})}).call(t,e(17))},function(n,t,e){(function(t,e,r,o,i,u){var c,a,l;n.exports=l=[],a=function(n,t,e){return l.push({id:n,title:t,fn:e})},a("���","���������� ������������ Directum",function(n){var i,u;return u=t.command("Update MBUser\nSet\n  UserName=?,\n  Domain = ?\nWhere UserLogin=?"),e.l(u,n.AD.cn,r.dc,n.UserLogin).Execute(),i=o.app.ReferencesFactory.���.GetObjectById(n.Analit),i.����������3=n.AD.cn,i.Save(),n.Kod=i.���}),a("���","��������� �������",function(n){var t,e;return t=o.app.ReferencesFactory.���.GetComponent(),t.Open(),t.Insert(),t.����������=n.AD.sn,t.����������2=n.AD.givenName,t.����������3=n.AD.middleName,t.������2=n.AD.mail,o.photo(t,e=r.photo(n.AD)),t.Save(),e&&i.DeleteFile(e),n.PrsKod=t.���}),c=function(n){return o.app.ReferencesFactory.���.GetObjectById(n).���},a("���","��������� ���������",function(n){var t;return t=o.app.ReferencesFactory.���.GetComponent(),t.Open(),t.Insert(),t.�������=n.PrsKod,t.������������=n.Kod,t.�������������=c(n.Dept.Analit),t.������=n.AD.title,t.����������4=n.AD.telephoneNumber,t.����������3=n.AD.employeeID,t.����������=n.AD.sn+" "+n.AD.givenName+" "+n.AD.middleName,t.Save()}),a("���","��������� ��������",function(n){var t;if(t=o.app.ReferencesFactory.���.GetComponent(),t.Open(),t.OpenRecord(),!t.Locate("�������",n.PrsKod))throw Error("������� �� ������");return t.������2=n.AD.mail,t.Save()}),a("SQL","��������� ������������ SQL",function(n){var o,i;return t.h.sp_grantlogin(i=r.dc+"\\"+n.UserLogin),o=t.command("Select Count(*) as N\nFrom sysusers U Inner Join master..syslogins L\n  On U.sid=L.sid\n  Where U.name=? And L.name=?"),e.l(o,n.UserLogin,i),t.execute(o).pop().N||(o=t.command("Exec sp_adduser ?, ?"),e.l(o,i,n.UserLogin).Execute()),u?void 0:(o=t.command("Exec sp_revokelogin ?"),e.l(o,i).Execute())})}).call(t,e(6),e(7),e(11),e(15),e(5),e(53))},function(n,t,e){(function(n,t,r,o,i){var u;u=e(20),o("a",i).shift().onclick=function(){return n&&u.test()&&t.push(function(){return r.Run('"'+n+'" -S='+u.s+" -D="+u.d+" -CT=Reference -F=SYSTEM_USERS")}),!1}}).call(t,e(21),e(18),e(3),e(12),e(19))},,,,,,,,,,,,,,,function(n,t,e){(function(t){n.exports=function(){var n;for(n=new ActiveXObject("InternetExplorer.Application"),n.ToolBar=!1,n.StatusBar=!1,n.Visible=!0,n.Navigate("about:blank");n.Busy;)t.Sleep(100);return n}}).call(t,e(1))},,function(n,t,e){(function(n,t){this.id=function(n){var t;if(n)for(;n=GetObject(n.Parent);){if(!n.ou)return;if(t=n.l){if(/^\d+$/.test(t))return t;return}}},this.list=function(e){var r;return e?(r=n.command("Select\n  Dep.Analit,\n  Dep.Kod,\n  Dep.NameAn\nFrom\n  MBVidAn As Z,\n  MBAnalit As Dep\nWhere\n  Z.Kod='���'\n  And Z.Vid=Dep.Vid\n  And Dep.NomPodr=?\nOrder By 3"),t.l(r,e),n.execute(r)):[]}}).call(t,e(6),e(7))},,,,function(n,t,e){(function(t){var e;e=t.command("Select\nCount(*) As N\nFrom master..syslogins\nWhere name = SYSTEM_USER"),n.exports=t.execute(e).shift().N>0}).call(t,e(6))},,,function(n,t){n.exports='body{background:#a0c0e0 url("about:blank") no-repeat fixed;margin:0;padding:.3ex;color:#000;font-family:Verdana,Arial,sans-serif;text-align:justify}h1{text-align:right}.text-right{text-align:right}#Footer{position:fixed;bottom:0;left:0;width:100%;font-size:87%;border-top:1px dashed #000080;background:#b0d0f0;}#Footer #github{float:right}table{width:100%}thead,tfoot{background:#fff}th{text-align:center}.Even{background:#cce}.Odd{background:#aac}'}]);