###
Run under WScript
###

module.exports = without (s)->
  (tag "!DOCTYPE", true) html: true
  html ->
    head ->
      title "#{PACKAGE.name} v#{PACKAGE.version}"
      style()
      script "document.$=window"
    body()
