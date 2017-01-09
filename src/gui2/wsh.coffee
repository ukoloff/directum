###
Run under WScript
###

wnd = 0

d = ie().Document

d.MyAtTr = 'Try #1'

d.open()

d.MyAtTr = "Another try"
d.MyCB = (w)->
  wnd = w

t = without (s)->
  script -> raw "<!--\n", s, '\n//-->'

s = fs.OpenTextFile wsh.ScriptFullName, 1
  .ReadAll()

d.write t s

echo 'Attr =', d.MyAtTr
wnd.alert 'А так?'
