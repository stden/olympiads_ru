{$A+,B-,D+,E+,F-,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
Uses Testlib;
var
  o, a : longint;
begin
  a := ans.readlongint;
  o := ouf.readlongint;
  if (o = -1) and (a = -1) then quit(_OK, '��� �� �������');
  if o = a then quit(_OK, ':-)');
  if o < -1 then quit(_PE, '����祭� ����⥫쭮� �᫮ <-1');
  if o = -1 then quit(_WA, '����祭 �⢥� -1 �� ����稨 ���');
  if a = -1 then quit(_WA, '����祭� ������⥫쭮� �᫮ �� ������⢨� ���');
  if o > a then quit(_WA, '�� ��⨬��쭮');
  if o < a then quit(_WA, '���� ⠪�� ����� �� �������');
end.