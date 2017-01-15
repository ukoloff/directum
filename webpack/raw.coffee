###
Hand-made raw loader for Webpack
###

module.exports = exports = (content)->
  @cacheable?()
  @value = content  # What for?
  "module.exports = #{JSON.stringify content}"

exports.seperable = true;
