window.onunload = ->
  echo 'Bye!'
  exit 0

document.getElementsByTagName('body')[0].innerHTML = do without ->
  h1 'Превед'
  text 'Медвед'
