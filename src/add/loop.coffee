#
# Ждём выхода из бруазуера
#

dom.body.onunload = ->
  exit 1

while true
  wsh.Sleep 100
