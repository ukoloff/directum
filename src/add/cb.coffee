#
# Нарисовать список пользователей с крыжиками
#

users = require './steps'
.users

t = without ->
  table
    border: true
    cellspacing: 0
    ->
      thead ->
        th x for x in '№,Пользователь,Имя,Таб. №,Подразделение'.split ','
      tbody ->
        for u, i in @
          tr
            class: if i & 1 then 'odd' else 'even'
            ->
              td align: 'right', i+1
              td u.AD.sAMAccountName
              td u.AD.displayName
              td u.AD.employeeId
              td switch u.Depts.length
                when 0
                  -> center '-'
                when 1
                  u.Depts[0].NameAn
                else
                  -> select ->
                    for z in u.Depts
                      option
                        value: z.Kod
                        z.NameAn
                    text u.Depts.length

interior.innerHTML = t users
