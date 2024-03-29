{$A+,B-,D+,E-,F-,G-,I+,L+,N+,O-,P-,Q-,R-,S+,T-,V+,X+}
{$M 16384,0,655360}

{ ������ ������⢠ ࠧ������ �᫠ N �� ࠧ���� ᫠����� }
Program Addends;

{
  ����� a[i,j] -- ������⢮ ࠧ������ �᫠ i �� ᫠�����, �� �ॢ���騥 j
  ����� ���� ᫥���騥 ४��७�� ᮮ⭮襭��:
    a[0,j] = 1 ��� j>=0 (i=0)
    a[i,0] = 0 ��� i>=1 (j=0)
    a[i,j] = a[i,j-1]+a[i-j,j-1] ��� i,j>0
}

{
  ������� ������ � 10^9 �� N<=212 (          995645336 ��ਠ�⮢),
  � LongInt      --       �� N<=225 (         2114965120 ��ਠ�⮢),
  � Comp         --       �� N<=769 (9031248611609428980 ��ਠ�⮢),
  ��, ��稭�� � N=705, ��᫥���� ���� ᮤ�ঠ� �訡�� (�� ������ � 10^18)
}

Const MaxN = 1000;

Var A : Array [0..MaxN] Of Comp;
    N,i,j : Integer;

Begin
  assign(input,'c.in');
  reset(input);
  assign(output,'c.out');
  rewrite(output);

  Read(N);
  FillChar(A,SizeOf(A),0); A[0]:=1;
  For j:=1 To N Do
  Begin
    For i:=N DownTo j Do {Inc(A[i],A[i-j]);} A[i]:=A[i]+A[i-j];
    {WriteLn(j,' - ',A[j]:0:0);}
  End;
  WriteLn(A[N]:0:0);
End.