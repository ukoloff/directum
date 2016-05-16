#
# Отображение процесса подключения к серверам
#

interior.innerHTML = do without ->
  table
    border: true
    cellspacing: 0
    -> thead ->
      th x for x in 'Операция Время Результат'.split ' '
    tbody

window = dom.parentWindow

window.xyz()
