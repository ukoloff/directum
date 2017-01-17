###
Run under WScript
###

t = require './index.html'

others.d =
d = ie().Document
d.open()
d.write t require '../css/minimal'
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
