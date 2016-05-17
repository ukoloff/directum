#
# Слияние объектов
#
module.exports = ->
  r = {}
  for z in arguments when 'object' == typeof z
    for k, v of z when 'string' == typeof k
      r[k] = v
  r
