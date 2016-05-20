#
# Поиск подразделений
#

# Код подразделения
@id = (user)->
  return unless user
  while user = GetObject user.Parent
    return unless user.ou
    continue unless i = user.l
    return i if /^\d+$/.test i
    return

# Список подразделений по коду
@list = (id)->
  return [] unless id
  cmd = mssql.command """
    Select
     Dep.Analit, Dep.Kod, Dep.NameAn
    From
     MBVidAn As Z, MBAnalit As Dep
    Where
     Z.Kod='ПОД' And Z.Vid=Dep.Vid And Dep.NomPodr=?
    Order By 3
    """
  assign cmd, 0, id
  mssql.execute cmd
