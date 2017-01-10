wnd.onunload = ->
  echo 'Bye!'
  exit 0

dom.getElementsByTagName('body')[0].innerHTML = do without ->
  h1 'Превед'
  text 'Медвед'
