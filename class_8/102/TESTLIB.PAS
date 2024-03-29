{TESTLIB: ������⥪� ��� �஢������ �ணࠬ�}
{Copyright (c) ��⮭ ��堭��}

{����� 1.0 ��� olympiads.ru}

{��� ��᫥����� ���������: 30/03/97}
{�������� ���� ⨯ १����: "���筮 ��୮" (30/03/97)}
{�㭪�� ReadInteger ᭮�� ࠡ�⠥�}

{$A-,B-,D+,E+,F+,G+,I-,L+,N+,O-,P+,Q-,R+,S+,T-,V+,X+,Y+}
{$M 65520, 0, 0}

 (* ��ଠ� ����᪠ ������饩 �ணࠬ��, �ᯮ�����饩 TESTLIB:

    CHECK <Input_File> <Output_File> <Answer_File> [<Result_File> [-xml]],

    �� �⮬ � 䠩� Result_File ���� ����ᠭ १���� �஢�ન,
    �᫨ �� �����.

    �᫨ ����� 䠩� � १���⮬ �஢�ન, � �뢮� �� ��࠭ ��
    �ந��������, � ��� ������ ������ ���� �㫥��!!!

  *)

unit TESTLIB;

(* ================================================================= *)
                              interface
(* ================================================================= *)

const EofChar = #$1A;
      NumberBefore = [#10,#13,' ',#09];
      NumberAfter  = [#10,#13,' ',#09];
      Blanks       = [#10,#13,' ',#09];

type REAL = EXTENDED; {!!!!!!!!}

type CharSet = set of char;
     TMode   = (_Input, _Output, _Answer);
     TResult = (_OK, _WA, _PE, _3, _4, _Fail, _pc, _Dirt,_fl);
               {_OK - �� ��୮, _PC - ���筮 ��୮,
                _WA - ������ �⢥�,
                _PE - �ଠ� �뢮��,
                _Fail - ����� �� ᫮������
                _Dirt - ��� ����७���� �ᯮ�짮�����
                _fl - � ��, �� � _Fail, ��� ᮢ���⨬���
                      � �।��騬� ����ﬨ}

const ResultXml : array[TResult] of string =
  ('accepted','wrong-answer','presentation-error','unknown',
   'unknown','fail','partially-correct','unknown','fail');

type
     InStream = object
                    cur: char; {⥪�騩 ᨬ���, =EofChar, �᫨ �����}
                    f: TEXT; {䠩�}
                    name: string; {��� 䠩��}
                    mode: TMode;
                    opened: boolean;

                    {��� ���७���� �ᯮ�짮�����}
                    constructor init (fname: string; m: TMode);

                    function CurChar: char; {�뤠�� cur}
                    function ReadChar: char; {�뤠�� cur}
                    procedure NextChar;     {���室�� �� ᫥�. ᨬ���}

                    function seekeof: boolean;
                    function seekEoln: boolean;


                    function eof : boolean;  { == cur = EofChar}

                    {�ய�᪠�� ᨬ���� ��������� ������⢠}
                    {�� ��ࠡ��뢠�� �訡��}
                    procedure skip (setof: CharSet);

                    {��⠥� ᫮�� (�� ᨬ�����). ��। ᫮��� �ய�᪠����
                     �� ᨬ���� �� Before. �ਧ����� ���� ᫮�� ����
                     ���� ����� 䠩��, ���� ᨬ��� �� After. �᫨ ReadWord
                     ���몠���� �� ����� 䠩�� ��� ᫮�� ���⮥, � �� �
                     ����蠥��� � �訡��� _PE}
                    {�᫨ ᫮�� ��⮨� �����, 祬 �� 255 ᨬ����� =>
                     ��室�� � �訡��� _PE}
                    function ReadWord (Before, After: CharSet): string;

                    {��⠥� 楫�� integer}
                    {�� �訡�� ��室�� � _PA}
                    function ReadInteger: integer;

                    {��⠥� ������� 楫��}
                    {�� �訡�� ��室�� � _PA}
                    function ReadLongint: longint;

                    {��⠥� ����⢥����}
                    {�� �訡�� ��室�� � _PA}
                    function ReadReal: real;

                    {��⠥� ��ப� (�� ᨬ����� #13, #10),
                     ⥪�饩 ����樥� �⠭������ ���� ᨬ��� ᫥�. ��ப�}
                    {�᫨ ��ப� ��⮨� �����, 祬 �� 255 ᨬ����� =>
                     ��室�� � �訡��� _PA}
                    function ReadString: string;

                    {��� ����७���� �ᯮ�짮�����}
                    procedure QUIT (res: TResult; msg: string);
                    procedure close;

                end;


procedure QUIT (res: TResult; msg: string);

{��ॢ���� �᫮ � ��ப� � �����頥� १����}
function itoa(q:longint):string;

var inf, ouf, ans: InStream;
    ResultName: string; {��� 䠩�� ��� १����}
    xmlflag:boolean;

(* ================================================================= *)
                              implementation
(* ================================================================= *)

{uses crt;}

procedure QUIT (res: TResult; msg: string);
var RESFILE: Text;
    ErrorName: string;

    procedure scr (color: word; msg: string);
    begin
       if ResultName = '' then {�᫨ �� ᮧ������ 䠩� � १-⮬}
       begin
          {TextColor (color); }write (msg); {TextColor (LightGray);}
       end;
    end;

begin
   if res=_fl then res:=_fail;
   if (res = _OK) then
   begin
      ouf.skip (Blanks);
      if not ouf.eof then QUIT (_Dirt, '����� ���ଠ�� � ��室��� 䠩��');
   end;

   case res of
      _Fail: begin {sound (100); delay (30); nosound;}
                   ErrorName := '�����';
                   Scr ({LightRed}0, ErrorName);
             end;

      _Dirt: begin
                   ErrorName := 'PE ������ �ଠ� �뢮��';
                   Scr ({LightCyan}0, ErrorName);
                   res := _PE;
                   msg := '����� ���ଠ�� � ��室��� 䠩��';
             end;

      _PE: begin
              ErrorName := 'PE ������ �ଠ� �뢮��';
              Scr ({LightRed}0, ErrorName);
           end;

      _OK: begin
              ErrorName := 'ok';
              Scr ({LightGreen}0, ErrorName);
           end;

      _PC: begin
              ErrorName := 'PC ����筮-���� �⢥�';
              Scr ({Yellow}0, ErrorName);
           end;

      _WA: begin
              ErrorName := 'WA ������ �⢥�';
              {TextColor (LightRed); }scr ({LightRed}0, ErrorName);
           end;

      else QUIT (_Fail, '��������� ��� ???');
   end;

   if (ResultName <> '') and not(xmlflag) then
   begin
      assign (RESFILE, ResultName); {������� 䠩� � १���⮬ �஢�ન}
      rewrite (ResFile);
      if IORESULT <> 0 then QUIT (_Fail, '���������� ᮧ���� 䠩� १���⮢');
      writeln (ResFile, '.Testlib Result Number = ', ord (res));
      writeln (ResFile, '.Result name (optional) = ', ErrorName);
      writeln (ResFile, '.Check Comments = ', msg);
      close (ResFile);
      if IORESULT <> 0 then QUIT (_Fail, '���������� ᮧ���� 䠩� १���⮢');
   end;

   if (ResultName <> '') and (xmlflag) then begin
     assign (RESFILE, ResultName);
     rewrite(ResFile);
     writeln (ResFile,'<?xml version="1.0" encoding="cp866"?>');
     writeln (ResFile,'<!-- Problem exchange format 0.1 -->');
     writeln (ResFile,'<result outcome="',ResultXml[res],'">',msg,'</result>');
     close(ResFile);

   end;

   Scr ({LightGray}0, ' ' + msg + ' ');
   writeln;

   if Res = _Fail then HALT (ord (res));

   close (inf.f); close (ouf.f); close (ans.f);

   if xmlflag then halt(0);

   {TextColor (LightGray);}

   if (res = _OK) or (ResultName <> '') then HALT (0)
                                        else HALT (ord (res));
end;

constructor Instream.init (fname: string; m: TMode);
begin
   name := fname;
   mode := m;
   assign (f, fname);
   {$I-} reset (f);
   if IORESULT <> 0 then
   begin
      if mode = _Output then QUIT (_PE, ' ��������� 䠩� ' + fname);
              (*          else QUIT (_Fail, '��������� 䠩� '); *)
       cur := EofChar; {��� ��㣨� 䠩��� - �����}
   end
   else
      if system.eof (f) then cur := EofChar
                        else begin cur := ' '; nextchar end;
   opened := true;

end;

function InStream.curchar: char;
begin
   curchar := cur
end;

function InStream.readchar: char;
begin
   readchar := cur;
   nextchar;
end;

procedure InStream.nextchar;
begin
   if cur = EofChar then {��祣� �� ������}
   else if system.eof (f) then cur := EofChar
   else begin
      {$I-} read (f, cur);
      if IORESULT <> 0 then Quit (_Fail, '�訡�� �⥭�� ' + name);
   end;
end;

procedure InStream.QUIT (res: TResult; msg: string);
begin
   if mode = _Output then TESTLIB.QUIT (res, msg)
   {�訡�� �� �⥭�� input ��� answer - �� ⮫쪮 -Fail}
   else TESTLIB.QUIT (_Fail, msg + ' (' + name + ')');
end;

function InStream.ReadWord (Before, After: CharSet): string;
var i: integer;
    res: string;
begin
   while cur in Before do nextchar;

(*
   if (cur in After) then
      QUIT (_PE, '����� "' + cur +'" ���������: ᫮�� ��� �᫮');
*)
   if cur = EofChar then QUIT (_PE, ' ���������� ����� 䠩��');

   i := 0;
   while not ((cur IN AFTER) or (cur = EofChar))  do
   begin
      inc (i);
      if i > 255 then QUIT (_PE, ' ���誮� ������� ��ப� �� �室��� 䠩��');
      res [i] := cur;
      nextchar
   end;
   res [0] := chr (i);
   ReadWord := res
end;


function InStream.ReadInteger: integer;
var res: longint;
begin
   res := ReadLongint;
   if (res < -32768) or (res > 32767) then
     QUIT (_PE, ' ���誮� ����讥 �᫮ (��������� 楫��)');
   ReadInteger := res
end;


function InStream.ReadReal: real;
var help: string;
    res: real;
    code: integer;
begin
   help := ReadWord (NumberBefore, NumberAfter);
   val (help, res, code);
   if code <> 0 then QUIT (_PE, ' ����� "' + help + '" ��������� ����⢥����');
   ReadReal := res
end;

function InStream.ReadLongint: longint;
var help: string;
    res: longint;
    code: integer;
begin
   help := ReadWord (NumberBefore, NumberAfter);
   val (help, res, code);
   if code <> 0 then QUIT (_PE, ' ����� "' + help + '" ��������� ��. 楫��');
   ReadLongint := res
end;

procedure InStream.skip (setof: CharSet);
begin
   while (cur in setof) and (cur <> eofchar) do nextchar;
end;

function InStream.seekeof: boolean;
begin
   while (cur in Blanks) do nextchar;
   seekeof := cur = EofChar;
end;

function InStream.eof : boolean;
begin
   eof := cur = EofChar
end;

function InStream.seekEoln: boolean;
begin
  while (cur in [' ', #9]) do nextchar;
  if cur = #13 then begin
    nextchar;
    if cur = #10 then nextchar;
    seekEoln := true;
  end else seekEoln := eof;
end;

function InStream.ReadString: string;
var res: string;
begin
   res := ReadWord ([], [#10,#13]);
   nextchar; {�ண��⨫� ᨬ��� #13}

   if cur = #10 then nextchar; {�᫨ �� ��� �⮨� #10 => �ய�᪠�� ���}
   readstring := res
end;

procedure InStream.close;
begin
   if opened then system.close (f)
end;


function itoa(q:longint):string;
var s:string;
begin
str(q,s);
itoa:=s;
end;



BEGIN {�������������}
   if (ParamCount < 3) or (ParamCount > 5) then
      Quit (_fail, '�ணࠬ�� ������ ����᪠���� � ��ࠬ��ࠬ�: <INPUT-FILE> <OUTPUT-FILE> <ANSWER-FILE> [<Result_File>'+
       '[-xml]]');

   if ParamCount >= 4 then ResultName := ParamStr (4)
                     else ResultName := '';
   if ParamCount = 5 then xmlflag:=true
                     else xmlflag:=false;
   if xmlflag then begin
     assign(output,'nul');
     rewrite(output);
     end;

   inf.opened := false;
   ouf.opened := false;
   ans.opened := false;

   inf.init (ParamStr (1), _Input);
   ouf.init (ParamStr (2), _Output);
   ans.init (ParamStr (3), _Answer);
END.
