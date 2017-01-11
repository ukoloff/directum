t = without ->
    li '' + @
tE = without ->
    li style: 'color: red;', @
container = false

log = $ '#log'
.pop()

append = (html)->
  unless container
    log.innerHTML = do without -> div()
    container = log.firstChild
    log.innerHTML = ''
  container.innerHTML = html
  log.appendChild x while x = container.firstChild
  return

testX = (fabric)->
  try
    append t fabric().GetAbsolutePathName '.'
  catch e
    append tE "Error: #{e.message}"

CLSID = 'Scripting.FileSystemObject'

testX ->
  wsh.CreateObject CLSID

testX ->
  new ActiveXObject CLSID
