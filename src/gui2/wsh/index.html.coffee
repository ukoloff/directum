###
Run under WScript
###

module.exports = without (s)->
  html ->
    head ->
      title "#{PACKAGE.name} v#{PACKAGE.version}"
      coffeescript ->
        document.$ = window
        return
    body ->
