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
      coffeescript ->
        setTimeout ->
          z = document.getElementsByTagName('input')
          z[z.length - 1].focus()
    body ->
      h1 'Настройка пользователей Directum'

      div ->
        text """
Эта программа помогает с первоначальной настройкой пользователей
системы электронного документооборота "Directum". Точнее говоря, она:
        """
        ul ->
          li 'Создаёт записи в справочниках Персоны и Работники'
          li 'Обновляет данные в справочниках Пользователи и Контакты из Active Directory'
          li 'Генерирует пользователей SQL'
          li 'Копирует фотографии пользователей при возможности'

        form -> center ->
          z = (@z or '').split '/'
          for n, i in ['Сервер', 'База данных']
            label n, ' ', ->
              input
                value: z[i] or 'Directum'
                required: true
            text ' '

          input
            type: 'submit'
            value: ' нАчать! >> '

        hr()
        text 'Пользователей требуется создать в самом Directum:'
        ol ->
          li 'Откройте оснастку "Пользователи"'
          li 'Добавьте новую запись (Ctrl+N)'
          li 'Укажите имя (учётную запись в домене)'
          li 'Введите какое-нибудь полное имя (можно ту же учётную запись)'
          li 'Убедитесь, что выбрана "Windows-аутентификация"'
          li 'Если есть поле NetBIOS (Domain), введите туда что угодно'
          li 'Проверьте, что статус пользователя не "Отключён"'
          li 'Возвращайтесь сюда и нажимайте кнопку "нАчать"'
        center 'Удачи!'

      p()
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
