wnd.onunload = ->
  echo 'Bye!'
  exit 0

dom.getElementsByTagName('body')[0].innerHTML = do without ->
  h1 'Превед'
  text 'Медвед'

css = require "./css"

style = dom.getElementsByTagName('style')[0]
if style.styleSheet
  style.styleSheet.cssText = css
else
  style.appendChild dom.createTextNode css
