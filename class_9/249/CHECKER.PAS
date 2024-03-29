{�஢������ �ணࠬ�� ��� ����� "���⨭�"
� ��㫨஢�� "���஢��"}

uses testlib;

const nmax=100;
      lmax=50;

    rm:array[1..32] of char =('�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�');
    rb:array[1..32] of char =('�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�','�','�','�','�',
                              '�','�','�','�','�');

    sp:set of char = ['!','"','(',')','-',',',' ','?',':',';','.',#13,#10];
            {�������⥫� ����� ᫮����}
    ep:set of char = ['!','?','.']; {����� �।�������}


var n:integer;
    a:array[1..nmax] of byte;
    words:array[1..nmax] of string[lmax];
    uk:byte;
    q:array[1..nmax] of byte;
                   {����� �㤥� �뢥����� ⥪�� � ��������஢ ᫮�}
    dots:array[0..nmax] of boolean;
                   {=true, �᫨ ��᫥ i-�� ᫮�� ���� �窠, false - �᫨ ���}
    srm:set of char;
    srb:set of char;
    bnp:boolean;  {=true �᫨ �।������� ���-����� ��稭����� �� � ����让 �㪢�}

procedure read_input;
   var i:integer;
   begin
   bnp:=false;
   uk:=0;
   srm:=[];
   srb:=[];
   for i:=1 to 32 do begin
       srm:=srm+[rm[i]];
       srb:=srb+[rb[i]];
       end;
   n:=inf.readinteger;
   for i:=1 to n do
     a[i]:=inf.readinteger;
   end;

function upcase2(c:char):char;
   var i:integer;
   begin
   c:=upcase(c);
   if c in srm then
     for i:=1 to 32 do
       if c=rm[i] then begin
         c:=rb[i];
         break;
         end;
   upcase2:=c;
   end;

function find_nom(w:string):integer;
  var i:integer;
  begin
  for i:=1 to length(w) do w[i]:=upcase2(w[i]);
  for i:=1 to uk do
    if w=words[i] then begin
      find_nom:=i;
      exit;
      end;
  inc(uk);
  words[uk]:=w;
  find_nom:=uk;
  end;

procedure read_output;
   var w:string[lmax];
       bd:boolean;  {��砫� ������ �।�������?}
       i,j:integer;
       nw:integer;  {����� ᫮��}
       c:char;

   begin
   w:='';
   nw:=0;
   bd:=true;
   c:=' ';
   while nw<n do begin
      while (c in sp) do begin
        if c in ep then bd:=true;
        c:=ouf.readchar;
        end;
      if bd then dots[nw]:=true else dots[nw]:=false;
      inc(nw);
      w:='';
      while (not(c in sp)) and (not ouf.eof) do begin
         w:=w+c;
         c:=ouf.readchar;
         if length(w)=lmax then quit(_Fl,'����� � ��室��� 䠩�� ������� lmax');
         end;
      if bd and not(w[1] in srb) then bnp:=true;
      bd:=false;
      q[nw]:=find_nom(w);
      end;
   dots[n]:=true;
   end;

procedure test_length;
  var i:integer;
      s:string;
  begin
  for i:=1 to n do
    if a[i]<>(length(words[q[i]]) mod 2) then begin
      str(i,s);
      quit(_WA,'����� ᫮�� ����� '+s+' �� ᮮ⢥���� ���: '+words[q[i]]);
      end;
  end;

procedure test;
  var q1,q2,q3:integer;
      w1,w2,w3:integer;
      i,j:integer;
      s1,s2:string;
      qq:boolean;
  begin
  q1:=0;
  q2:=1;
  q3:=0;
  while q1<>n do begin
    while not dots[q2] do inc(q2);
    inc(q1);
    inc(q3);
    for i:=q1 to q2-1 do
      for j:=i+1 to q2 do
        if q[i]=q[j] then begin
           str(i-q1+1,s1);
           str(j-q1+1,s2);
           s1:=s1+' � '+s2;
           str(q3,s2);
           quit(_Wa,'��������� ᫮�� ����� '+s1+' � �।������� '+s2+':'+words[q[i]]);
           end;
    w1:=0;
    w2:=1;
    w3:=0;
    while w3+1<q3 do begin
      while not dots[w2] do inc(w2);
      inc(w1);
      inc(w3);
      if w2-w1=q2-q1 then begin
         qq:=true;
         for i:=0 to w2-w1 do
           if q[i+w1]<>q[i+q1] then qq:=false;
         if qq then begin
           str(w3,s1);
           str(q3,s2);
           quit(_WA,'��������� �।������� ����� '+s1+' � '+s2);
           end;
         end;
      w1:=w2;
      w2:=w2+1;
      end;
    q1:=q2;
    q2:=q1+1;
    end;
  end;


procedure read_spaces;
  var c:char;
  begin
  c:=' ';
  while (not (ouf.eof)) and (c in sp) do
    c:=ouf.readchar;
  end;



begin
read_input;
read_output;
test_length;
test;
read_spaces;
if bnp then quit(_Ok,'������� �।������� ��稭����� �� � ��������� �㪢�');
quit(_ok,'');
end.
