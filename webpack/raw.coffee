###
Hand-made raw loader for Webpack
###
parse = require 'querystring'
  .parse

module.exports = (content)->
  @cacheable?()
  fragments = split content,
    Math.max 10, Number(parse(@query.replace /^[?]?/, '').wrap)or 80

  if fragments.length > 1
    out = "var t = #{JSON.stringify fragments.shift()}\n"
    while fragments.length > 1
      out += "t += #{JSON.stringify fragments.shift()}\n"

  "#{out or ''}module.exports = #{
      out and "t + " or ''
    }#{JSON.stringify fragments.shift() or ''}"

# Split string at that position(s)
split =(s, at)->
  len = s.length
  i = n = Math.ceil len / at
  sum = 0
  stop = 0
  while i--
    start = stop
    s.substring start, stop = Math.round (sum += len)/n
