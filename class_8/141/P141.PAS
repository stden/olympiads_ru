const nmax=100;

var a:array[1..nmax] of integer;
    n:integer;
    i,j,g:integer;

    f1,f2:text;

begin
assign(f1,'input.txt');
reset(f1);
assign(f2,'output.txt');
rewrite(f2);
                                  {�⥭�� �室��� ������}
read(f1,n);
for i:=1 to n do read(f1,a[i]);
                                  {����஢�� ���ᨢ�}

for i:=1 to n do begin            {�����ࠥ� �᫮ �� i-�� ����}

  g:=i;                           {��⠥�, �� ᠬ�� �����쪮� �᫮,
                                   ���஥ ��� ����⨫���, �⮨� �� ���� i}

  for j:=i+1 to n do              {��ॡ�ࠥ� �� �᫠ � i+1 �� ���� ���ᨢ�}
    if a[j]<a[g] then g:=j;       {�᫨ ��諨 �᫮, ���஥ �����,
                                   祬 �, �� 㦥 �������, ���������� ���}

                                  {���塞 ���⠬� �᫠, ���騥 �� i-�� �
                                   �� g-�� ����� }
                                  {�᫨ a[i]=x, a[g]=y, � ��᫥ �믮������
                                   �������: }
  if i<>g then begin
    a[i]:=a[i]+a[g];                {a[i]=x+y, a[g]=y}
    a[g]:=a[i]-a[g];                {a[i]=x+y, a[g]=(x+y)-y=x}
    a[i]:=a[i]-a[g];                {a[i]=(x+y)-x=y}
                                  {�� ���� ��᫥ �⮣� a[i]=y, a[g]=x
                                   ����� ���祭�� �ந��襫}
    end;

  end;

                                  {�뢮��� १����}
for i:=1 to n do
  write(f2,a[i],' ');
close(f1);
close(f2);
end.

