module.exports =
without ->
  div id: 'head', ->
    label (-> raw '&hellip;'), -> div class: 'hide', ->
      for tab in @ by -1
        a href: "#", tab
    for tab, i in @
      label for: ".#{i}", ->
        input
          id: ".#{i}"
          type: 'radio'
          name: 'tab'
          value: i
          checked: 1==i
        text ' ', tab
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
