wnd.onunload = ->
  echo 'Bye!'
  exit 0

css = require "./css"

style = $('style')[0]
if style.styleSheet
  style.styleSheet.cssText = css
else
  style.appendChild dom.createTextNode css

bo2.innerHTML = do require './body.html'
do setTabs = ->
  for r in $ 'input', $('#head')[0]
    r.onclick = setTabs
    r.parentElement.className = r.checked and 'active' or ''
    r.blur()
    # r.parentElement.blur()

# require './scroll'
require './self'
require './test'
