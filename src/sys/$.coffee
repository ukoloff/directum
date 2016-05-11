#
# jQuery для бедных ;-)
#
module.exports =
$ = (selector)->
  selector = String selector
  toArray switch selector.substring 0, 1
    when '#'
      [dom.getElementById selector.substring 1]
    when '.'
      dom.getElementsByTagName selector.substring 1
    else
      dom.getElementsByTagName selector

toArray = (array)->
  z for z in array
