#
# Отображение процесса подключения к серверам
#
steps = require './steps'

window = dom.parentWindow

require './loop'
.push ->
  window.alert 'Превед, медвед!'


t = without ->
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th x for x in '№ Операция Время Результат'.split ' '
      tbody ->
        for z, i in @
          tr
            class: if i & 1 then 'odd' else 'even'
            ->
              td align: 'right', i+1
              td z.title
              td align: 'right'
              td align: 'center'

interior.innerHTML = t steps
