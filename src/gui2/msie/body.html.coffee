module.exports =
without ->
  div
    id: 'head'
    "#{PACKAGE.name}@#{PACKAGE.version}"
  h1 'Превед'
  text 'Медвед'

  ul id: 'log'

  pre()
