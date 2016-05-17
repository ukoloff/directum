#
# Ждём выхода из бруазуера
#

module.exports =
q = []

dom.body.onunload = ->
  q.unshift ->
    exit 1

loop
  do fn while fn = q.shift()
  wsh.Sleep 100
