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
  w.alert 'Callback called!'

t = without (s)->
  html ->
    head ->
    body ->

s = fs.OpenTextFile wsh.ScriptFullName, 1
  .ReadAll()

d.write t s
d.close()

# echo 'Attr =', d.MyAtTr
# wnd.alert 'А так?'

js = d.createElement 'script'
source = d.createTextNode s
js.appendChild source
d.getElementsByTagName('head')[0].appendChild js
