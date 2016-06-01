#
# Шаблон страницы подключения к серверам
#
module.exports = without ->
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
              td align: 'right', br
              td align: 'center', br
