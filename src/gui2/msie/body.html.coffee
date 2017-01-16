module.exports =
without ->
  div id: 'head', ->
    for z, i in 'One Two Three'.split ' '
      active = 1==i
      label for: ".#{i}", class: active and 'active', ->
        input
          id: ".#{i}"
          type: 'radio'
          name: 'tab'
          value: i
          checked: active
        text ' ', z
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
