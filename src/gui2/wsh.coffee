###
Run under WScript
###

d = ie().Document


d.open()
d.write """
<#{tag = 'script'}><!--
#{
fs.OpenTextFile wsh.ScriptFullName, 1
.ReadAll()
}
//--></#{tag}>
"""
