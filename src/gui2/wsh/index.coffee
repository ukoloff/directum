###
Run under WScript
###

others.d =
d = ie().Document
d.open()
d.write do require './index.html'
d.close()
d.body.innerHTML = ''

others.w =
w = d.$

s = fs.OpenTextFile wsh.ScriptFullName, 1
  .ReadAll()

d.$ = wsh

w.eval s

require './start'

loop
  wsh.Sleep 100
