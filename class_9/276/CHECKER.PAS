uses testlib;
const nmax=20;

var a:array[1..nmax,1..nmax] of integer;
    b:array[1..nmax] of integer;
    c:array[1..nmax+1] of integer;
    an,ou:integer;
    i,j:integer;
    n:integer;

begin
n:=inf.readinteger;
for i:=1 to n do
  for j:=1 to n do
    a[i,j]:=inf.readinteger;

for i:=1 to n do
  for j:=1 to n do begin
    if i=j then if a[i,i]<>0 then quit(_FAIL,'�訡�� � ���: �� 0 �� ������� ���������');
    if a[i,j]<>a[j,i] then quit(_WA,'�訡�� � ���: ����� �� ᨬ����筠');
    end;

fillchar(b,sizeof(b),0);
for i:=1 to n+1 do
  c[i]:=ouf.readinteger;
if c[1]<>c[n+1] then quit(_WA,'���� �� ������ � ��砫��� ���設�');
ou:=0;
for i:=1 to n do begin
  if a[c[i],c[i+1]]=0 then quit(_WA,'���� ��室�� �� ���������饬� ॡ��');
  ou:=ou+a[c[i],c[i+1]];
  end;
for i:=1 to n do
  begin
  if b[c[i]]<>0 then quit(_WA,'���� ��室�� �१ ���� ���設� ����� ������ ࠧ�');
  b[c[i]]:=1;
  end;
an:=ans.readinteger;
if an<ou then quit(_WA,'������ �� ���砩訩 ����');
if an=ou then quit(_OK,'');
if an>ou then quit(_FAIL,'������� �襭�� ����, 祬 � ���');
end.


