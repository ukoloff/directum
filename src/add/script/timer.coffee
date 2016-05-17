#
# Отображение процесса подключения
#

@Timer = (cell)->
  start = new Date

  do draw = ->
    cell.innerHTML = ((new Date - start)/1000).toFixed 2

  h = setInterval draw, 100

  stop: ->
    clearInterval h
    do draw
