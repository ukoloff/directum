#
# Отключить проверку сертификатов
#

sh.RegWrite 'HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\CertificateRevocation',
  0, 'REG_DWORD'
