wnd.onunload = ->
  echo 'Bye!' if DEBUG
  exit 0

css = require "../css"

style = $('style')[0]
if style.styleSheet
  style.styleSheet.cssText = css
else
  style.innerHTML = ''
  style.appendChild dom.createTextNode css

months = ->
  for i in [0..11]
    ('' + new Date 0, i).split(/\s+/)[1]

bo2.innerHTML = (require './body.html') months()

head = $ '#head'
  .shift()
rbs = $ 'input', head

do setTabs = ->
  for r in rbs
    r.onclick = setTabs
    r.parentElement.className = r.checked and 'active' or ''
    r.blur()

lab = $ 'label', head
  .shift()

popup = $ 'div', lab
  .pop()

lab.onmouseover = ->
  popup.className = ''

lab.onmouseout = ->
  popup.className = 'hide'

for a, i in $ 'a', lab
  a.onclick = do (i)-> ->
    rbs[rbs.length - i - 1].click()
    # popup.className = 'hide'
    false

# require './scroll'
require './self'
require './test'
