uses testlib;
var a,b:longint;
begin
while not ans.seekeof do begin
  a:=ans.readlongint;
  if ouf.seekeof then quit(_WA,'�� �� �᫠');
  b:=ouf.readlongint;
  if a<>b then quit(_WA,'�뢥���� ����୮� �᫮ ��� �᫮ �ய�饭�');
  end;
if not ouf.seekeof then quit(_WA,'�뢥���� ��譨� �᫠');
quit(_OK,'');
end.
