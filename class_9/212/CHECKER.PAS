uses testlib;
var s:string;

begin
s:=ouf.readstring;
if ans.readstring=s then quit(_OK,'');
if (s='URA') or (s='NO') then quit(_WA,'');
quit(_PE,'� ��室��� 䠩�� �������⨬�� ᮮ�饭��');
end.