html = require './html'

dom.open()
dom.write html
  c: require './css'
  z: argv[0]
  me: wsh.ScriptFullName
dom.close()

dom.body.onunload = ->
  exit 1

while true
  wsh.Sleep 100
