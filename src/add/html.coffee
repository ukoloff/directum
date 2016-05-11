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

      p id: false

      div id: 'Footer', ->
        div id: 'C', ->
          raw '&copy; ОАО &laquo;'
          a
            href: 'http://ekb.ru'
            target: '_blank'
            onClick: 'this.blur()'
            "Уралхиммаш"
          raw '&raquo;, 2013 - ', new Date().getFullYear(), ' '
          a
            id: 'github'
            href: PACKAGE.homepage
            target: '_blank'
            'Исходный код'
