###
Run under WScript
###

module.exports = without ->
  (tag "!DOCTYPE", true) html: true
  html ->
    head ->
      title "#{PACKAGE.name} v#{PACKAGE.version}"
      style -> raw @
      script "document.$=window"
    body -> div 'Превед, медвед!'

