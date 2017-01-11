wnd.onunload = ->
  echo 'Bye!'
  exit 0

css = require "./css"

style = dom.getElementsByTagName('style')[0]
if style.styleSheet
  style.styleSheet.cssText = css
else
  style.appendChild dom.createTextNode css

bo2.innerHTML = do require './body.html'

require './test'
