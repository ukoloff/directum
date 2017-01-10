###
Run under WScript
###

module.exports = without (s)->
  html ->
    head ->
      title "#{PACKAGE.name} v#{PACKAGE.version}"
      style()
      script "document.$=window"
    body()
