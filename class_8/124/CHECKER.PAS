uses testlib;

const nmax=100;

var a,b,c:array[1..nmax] of integer;
    n,i,j:integer;
    o:integer;

begin
n:=inf.readinteger;
for i:=1 to n do
  a[i]:=inf.readinteger;
for i:=1 to n do
  b[i]:=inf.readinteger;
for i:=1 to n do
  c[i]:=a[i]*b[i];
j:=1;
for i:=2 to n do
  if c[i]>c[j] then j:=i;

o:=ouf.readinteger;
if (o<1) or (o>n) then quit(_PE,'��࠭�� ����� ���');
if c[j]=c[o] then quit(_OK,'');
if c[j]<c[o] then quit(_FL,'Bug in checker');
quit(_WA,'��室 �� �⮩ ��� �� ���ᨬ����');
end.

