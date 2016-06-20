#
# Есть ли админские права
#
module.exports = do ->
  n = 16
  while n--
    try
      sh.RegRead k = "HKLM\\#{do rnd}"
    catch
      try
        sh.RegWrite k, new Date
        sh.RegDelete k
        return true
      catch
        return false
