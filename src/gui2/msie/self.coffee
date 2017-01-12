###
Output myself
###

t = without ->
  text @

s = fs.OpenTextFile wsh.ScriptFullName, 1
  .ReadAll()
s = t s
.replace /\r\n?|\n/g, '<br>'

$ 'pre'
.pop()
.innerHTML = s
