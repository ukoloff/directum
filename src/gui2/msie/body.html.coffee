module.exports =
without ->
  div
    class: 'header'
    "#{PACKAGE.name}@#{PACKAGE.version}"
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
