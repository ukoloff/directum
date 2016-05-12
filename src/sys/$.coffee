#
# jQuery для бедных ;-)
#
module.exports =
$ = (selector)->
  selector = String selector
  switch selector.substring 0, 1
    when '#'
      [dom.getElementById selector.substring 1]
    when '.'
      toArray dom.getElementsByTagName selector.substring 1
    else
      toArray dom.getElementsByTagName selector

toArray = (array)->
  z for z in array
