uses testlib;
type mas=array[1..100,1..100] of integer;
var a:mas;
    ss,sum,x,y,z,n,m,st,fin,i,j:longint;

begin
 ss:=ouf.readlongint;
 if ans.readlongint<>ss then quit(_wa,'���ࠢ��쭠� �������쭠� ����� ���');
 n:=inf.readinteger; m:=inf.readinteger;
 st:=inf.readinteger; fin:=inf.readinteger;
 for i:=1 to n do
  for j:=1 to n do
   a[i,j]:=-1;
 for i:=1 to m do
  begin
   x:=inf.readinteger;
   y:=inf.readinteger;
   z:=inf.readinteger;
   a[x,y]:=z;
  end;
 x:=ouf.readinteger;
 if x<>st then quit(_wa,'������ ����');
 sum:=0;
 while not ouf.seekeof do
  begin
    y:=ouf.readinteger;
    if a[x,y]=-1 then quit(_wa,'������ ����');
    sum:=sum+a[x,y];
    x:=y;
  end;
 if x<>fin then quit(_wa,'������ ����');
 if sum<>ss then quit(_wa,'������ ����');
 quit(_ok,'');
end.