window.onunload = ->
  WScript.Echo 'Bye!'
  WScript.Quit 0

document.title = 'Превед, медвед!'

WScript.Echo """
  WScript from MSIE:
  Я тут!
  """
