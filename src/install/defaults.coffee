#
# Настройки для установки Directum по умолчанию
#
# Известные ключи:
#
# code:
# server:
# database:
# logpath:
# profilelogpath:
# adminmail:
# scdesktop:
# scadminutil:
# _sc_autorun:
#
module.exports = yaml.safeLoad """
  scdesktop: 1
  scadminutil: 0
  _sc_autorun: 0
  """
