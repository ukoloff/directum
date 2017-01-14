###
Scroll header if needed (MSIE 6)
###

selector = '#head'

needFix = ->
  for list in dom.styleSheets
    for rule in list.rules or list.cssRules when selector == rule.selectorText
      return 'absolute' == rule.style.position
  return

if needFix()
  head = $ selector
    .shift()
  setInterval ->
    head.style.top = dom.documentElement.scrollTop
  , 100
