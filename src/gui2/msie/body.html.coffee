module.exports =
without ->
  div id: 'head', ->
    for z, i in 'One Two Three'.split ' '
      label for: ".#{i}", ->
        input
          id: ".#{i}"
          type: 'radio'
          name: 'tab'
          value: i
          checked: 1==i
        text ' ', z
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
