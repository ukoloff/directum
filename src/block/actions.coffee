#
# Чистый SQL
#
action = (title, sql)->
  echo title
  mssql.command sql
  .Execute()

action 'Закрытие неактивных записей справочника Пользователи',
  """
    Update MBAnalit
    Set Sost='З'
    From MBUser As U, MBAnalit As A, MBVidAn As R
    Where U.UserStatus='О' And U.NeedEncode='W'
      And A.Dop=U.UserKod And A.Sost<>'З'
      And A.Vid=R.Vid And R.Kod='ПОЛ'
  """
action 'Открытие заново активированных записей справочника Пользователи',
  """
    Update MBAnalit
    Set Sost='Д'
    From MBUser As U, MBAnalit As A, MBVidAn As R
    Where U.UserStatus<>'О' And U.NeedEncode='W'
      And A.Dop=U.UserKod And A.Sost='З'
      And A.Vid=R.Vid And R.Kod='ПОЛ'
  """

action 'Копирование статуса строк справочника Пользователи в справочник Работники',
  """
    Update W
    Set Sost=U.Sost
    From MBAnalit As U, MBAnalit As W, MBVidAn As R, MBUser As X
    Where R.Kod='РАБ' And W.Vid=R.Vid
      And W.Polzovatel=U.Analit And W.Sost<>U.Sost
      And U.Dop=X.UserKod And X.NeedEncode='W'
  """

action 'Копирование статуса строк справочника Работники в справочник Персоны',
   """
    Update P
    Set Sost=W.Sost
    From MBAnalit As P, MBAnalit As W, MBVidAn As R
    Where R.Kod='РАБ' And W.Vid=R.Vid
      And W.Persona=P.Analit
      And W.Sost<>P.Sost
   """
