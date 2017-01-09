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

d.write """
<#{tag = 'script'}><!--
#{
fs.OpenTextFile wsh.ScriptFullName, 1
.ReadAll()
}
//--></#{tag}>
"""

echo 'Attr =', d.MyAtTr
wnd.alert 'А так?'
