html = require './html'

dom.open()
dom.write html
  c: require './css'
  z: argv[0]
  me: wsh.ScriptFullName
dom.close()

do require './opener'

require './validate'

evloop.start()
