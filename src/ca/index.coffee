if wsh
  echo "Загрузка пользовательских сертификатов Directum v#{
    PACKAGE.version} <#{PACKAGE.homepage}>\n"
  require './run'
else
  globalize require './feed'
