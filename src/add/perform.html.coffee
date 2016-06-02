#
# Шаблон итоговой страницы
#
module.exports = without ->
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th z for z in '№ Пользователь'.split ' '
        th title: z.title, z.id for z in @steps
      tbody ->
        for u, i in @users
          tr
            class: if i & 1 then 'odd' else 'even'
            ->
              td align: 'right', i+1
              td u.AD.sAMAccountName
              td align: 'center', br for i in [1..5]
  center()
