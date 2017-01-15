###
Hand-made raw loader for Webpack
###
parse = require 'querystring'
  .parse

module.exports = (content)->
  @cacheable?()
  console.log 'WRAP', Math.max 10, Number(parse(@query.replace /^[?]?/, '').wrap)or 80
  "module.exports = #{JSON.stringify content}"
