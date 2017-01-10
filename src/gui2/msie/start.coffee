wnd.onunload = ->
  echo 'Bye!'
  exit 0

css = require "./css"

style = dom.getElementsByTagName('style')[0]
if style.styleSheet
  style.styleSheet.cssText = css
else
  style.appendChild dom.createTextNode css

dom.body.innerHTML = do require './body.html'

testX = (fabric)->
  alert try
    fabric().GetAbsolutePathName '.'
  catch e
    "Error: #{e.message}"

CLSID = 'Scripting.FileSystemObject'

testX ->
  wsh.CreateObject CLSID

testX ->
  new ActiveXObject CLSID
