#
# Собственно генерация пользователей а также всего, что понадобится впредь (ц)
#

users = require './cb'

t = without ->
  ths =
    '№': false
    Пользователь: false
    ПОЛ: 'Обновление пользователя Directum'
    ПРС: 'Генерация персоны'
    РАБ: 'Генерация работника'
    КНТ: 'Настройка контакта'
    SQL: 'Генерация пользователя SQL'
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th title: v, k for k, v of ths
      tbody ->
        for u, i in @
          tr ->
            td align: 'right', i+1
            td u.AD.sAMAccountName
            td() for i in [1..5]

interior.innerHTML = t users

perform = ->
  popup "Hi!"

require './loop'
.push perform
