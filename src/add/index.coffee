html = require './html'

dom.open()
dom.write html
  c: require './css'
  z: argv[0]
dom.close()

$ 'input'
.pop()
.focus()

do require './opener'

require './validate'
try require './users'

evloop.start()
