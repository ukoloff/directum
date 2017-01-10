###
Run in browser
###

do ->
  @WScript = document.$

try
  delete document.$
catch
  document.$ = 0

require './start'
