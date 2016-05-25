#
# Есть ли админские права
#
module.exports = do ->
  try
    sh.RegRead 'HKEY_USERS\\S-1-5-20\\'
    true
  catch
