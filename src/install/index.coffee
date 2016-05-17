#
# Запуск установки клиента Directum
#
options = require './options'

unless admin
  echo """
    Скрипт установки клиента Directum должен запускаться
    от пользователя с правами локального администратора!
    (Shift + Right click/Run as...)
    """
  exit 1

sh.run """
    "#{require './client'}" /S "/v /passive #{options}"
  """
