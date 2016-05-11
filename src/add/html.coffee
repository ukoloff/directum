#
# Начальная страница
#
module.exports = without ->
  html ->
    head ->
      meta
        'http-equiv': "Content-Type"
        content: "text/html; charset=windows-1251"
      title 'Автоматическая генерация персон, работников и контактов'
      style @c
    body ->
      h1 'Настройка пользователей Directum'
      div id: false
