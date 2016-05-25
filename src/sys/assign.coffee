#
# M$ способ присваивания свойств OLE-объектам
#
module.exports =
assign =
  new Function 'o,k,v', 'o(k)=v'

# Массовое присвоение из масива
assign.a =
arr = (obj, array)->
  for z, i in array
    assign obj, i, z
  obj

# Массовое присвоение из списка
assign.l = (obj, list...)->
  arr obj, list

# Массовое присвоение из объекта
assign.o = (obj, rec)->
  for k, v in rec
    assign obj, k, v
  obj
