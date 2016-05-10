Program Run;

Uses
  SysUtils,
  Windows,
  ShellApi;

{ $R *.RES}

Const Exts='js;vbs;bat;cmd;lnk;url';

Procedure runLink;
Var
  X, R: String;
  i: Integer;
Begin
  R:=Exts;
  Repeat
   i:=Pos(';', R);
   if 0=i Then i:=1+Length(R);
   X:=ChangeFileExt(ParamStr(0), '.'+Copy(R, 1, i-1));
   if FileExists(X) Then
   Begin
    ShellExecute(0, Nil, PChar(X), Nil, Nil, sw_Show);
    Exit;
   End;
   R:=Copy(R, i+1, Length(R));
  Until Length(R)=0;
End;

Begin
 runLink;
End.
