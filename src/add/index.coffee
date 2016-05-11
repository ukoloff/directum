html = require './html'

dom.open()
dom.write html
  c: require './css'
dom.close()
