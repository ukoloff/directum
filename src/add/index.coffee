html = require './html'

dom.open()
dom.write html
  c: require './css'
  z: argv[0]
dom.close()
