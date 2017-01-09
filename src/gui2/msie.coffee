###
Run in browser
###

# alert 'Превед, медвед!\n' + document.MyAtTr
document.MyCB window

tT = without ->
  title 'Заголовок!!!'
tB = without ->
  h1 'Превед'
  text "медвед..."

setTimeout ->
  document.getElementsByTagName('head')[0]
  .innerHTML = do tT

  # alert document.body
  document.getElementsByTagName('body')[0]
  .innerHTML = do tB
