module.exports =
without ->
  div id: 'head', ->
    for i in [0..11]
      label for: ".#{i}", ->
        input
          id: ".#{i}"
          type: 'radio'
          name: 'tab'
          value: i
          checked: 1==i
        text ' ', ('' + new Date 0, i).split(/\s+/)[1]
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
