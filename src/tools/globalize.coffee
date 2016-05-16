#
# Сделать экспорт из модуля глобальными переменными
#

module.exports = (module)->
  do ->
    @[k] = v for k, v of module
    return
