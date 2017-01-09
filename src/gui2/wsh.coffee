###
Run under WScript
###

d = ie().Document

d.MyAtTr = 'Try #1'

d.open()
d.MyAtTr = "Another try"
d.write """
<#{tag = 'script'}><!--
#{
fs.OpenTextFile wsh.ScriptFullName, 1
.ReadAll()
}
//--></#{tag}>
"""

echo 'Attr =', d.MyAtTr
