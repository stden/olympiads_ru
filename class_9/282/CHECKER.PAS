uses testlib;
var q:longint;
    s:string;
begin
if ouf.seekeof then quit(_WA,'����⭮, ���� �� ������');
q:=ouf.readinteger;
if q<>1543 then quit(_WA,'');
q:=ouf.readlongint;
str(q,s);
quit(_OK,'���� ������, ᤥ���� '+s+' 室��');

end.