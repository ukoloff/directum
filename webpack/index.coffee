webpack = require 'webpack'
cmdize = require './cmdize'

@entry =
  adduser: "./src/add"
  blockusers: "./src/block"
  ca: "./src/ca"
  install: "./src/install"
  loadphoto: "./src/photo"

@output =
  path: "tmp",
  filename: "[name].js"
  sourcePrefix: ''

values = (map)->
  v for k, v of map

@module =
  noParse: values
    min: /[.]min[.]/
  loaders: values
    coffee:
      test: /[.]coffee$/
      loader: "coffee-loader"
    litcoffee:
      test: /[.](litcoffee|coffee[.]md)$/
      loader: "coffee-loader?literate"
    styl:
      test: /[.]styl$/
      loader: 'raw!stylus?compress'

brk = (s)->
  s.split ' '

@resolve =
  extensions: brk " .js .coffee .litcoffee .coffee.md .styl"

stringify = (rec)->
  res = {}
  for k, v of rec
    res[k] = switch typeof v
      when 'string'
        JSON.stringify v
      when 'object'
        stringify v
      else
        v
  res

@plugins = values
  cmdize: new cmdize
  defines: new webpack.DefinePlugin
    PACKAGE: stringify require '../package'
  globals: new webpack.ProvidePlugin require './autoload'
