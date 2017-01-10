###
Run under WScript
###

d = ie().Document
d.open()
d.write do require './index.html'
d.close()

w = d.$

do ->
  @window = w
  @document = d

s = fs.OpenTextFile wsh.ScriptFullName, 1
  .ReadAll()

d.$ = wsh

w.eval s

require './start'

loop
  wsh.Sleep 100
