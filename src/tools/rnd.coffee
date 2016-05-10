module.exports = (N = 12)->
  s = ''
  while s.length < N
    n = Math.floor 62*Math.random()
    s += String.fromCharCode 'Aa0'.charCodeAt(n/26) + n % 26
  s
