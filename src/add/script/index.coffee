setTimeout ->
  $ 'input'
  .pop()
  .focus()

  dom.forms[0].onsubmit = ->
    false
