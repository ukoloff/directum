if WScript?
  echo "Загрузка пользовательских сертификатов Directum v#{PACKAGE.version}"
  require './run'
else
  require './feed'
