###
Run under WScript
###

module.exports = without (s)->
  html ->
    head ->
      coffeescript ->
        document.$ = window
        return
    body ->
