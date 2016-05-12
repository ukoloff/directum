if wsh
  echo "Загрузка пользовательских сертификатов Directum v#{PACKAGE.version} <#{PACKAGE.homepage}>\n"
  require './run'
else
  # Установим глобальные функции
  do ->
    for k, v of require './feed'
      @[k] = v
