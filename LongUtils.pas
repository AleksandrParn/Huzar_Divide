unit LongUtils;

interface

// Aleksandr Pern: this unit has been made using help of algorythms of S. Okulov's book

const
  luBase = 10000;   // order
  luMaxDig = 1000; // max elements

type
  TLongArray = array[0..luMaxDig] of integer;

  function StrToLongArray(s : string) : TLongArray;
  function LongArrayToStr(A : TLongArray) : string;
  function LongArrDivide(const A, B : TLongArray; var Rem : TLongArray) : TLongArray;
  function LongArrMult(const A, B : TLongArray) : TLongArray;
  function LongArrSub(const A, B : TLongArray) : TLongArray;
  function IsZeroArray(A : TLongArray) : boolean;
  function ArrayEqual(const A, B : TLongArray) : boolean;
  function MoreArray(const A, B: TLongArray) : Boolean;

implementation

uses SysUtils;

function ArrayEqual(const A, B : TLongArray) : boolean;
var
  I : Integer;
begin
  Result:=False;
  if A[0]=B[0] then begin
    I:=1;
    while (I<=A[0]) And (A[I]=B[I]) Do
     Inc(I);
   Result:=(I=A[0]+1)
  end;
End;

function MoreArray(const A, B: TLongArray) : Boolean;
var
  I : Integer;
begin
  if A[0]<B[0] then
    Result:=false
  else if A[0]>B[0] then
    Result:=True
  else begin
    I:=A[0];
    while (I>0) and (A[I]=B[I]) do
      Dec(I);
    if i=0 then
      Result:=false
    else if A[I]>B[I] then
      Result:=true
    else
      Result:=False
  End
end;

function IsZeroArray(A : TLongArray) : boolean;
var
  I : integer;
begin
  Result:=true;
  for I:=A[0] downto 1 do
    if A[I]<>0 then begin
      Result:=false;
      Break
    end
end;

function StrToLongArray(S : string) : TLongArray;
var
  c  : char;
  I  : integer;
  J  : integer;
begin
  FillChar(Result,Sizeof(Result),0);
  for I := 0 to S.Length-1 do begin
    C:=S.Chars[I];
    if CharInSet(C, ['0'..'9']) then begin
      for J := Result[0] downto 1 do begin
        Result[J+1] := Result[J+1]+(Integer(Result[J])*10) div luBase;
        Result[J]   := (Integer(Result[J])*10) mod luBase;
      end;
      Result[1] := Result[1]+Ord(C)-Ord('0');
      if Result[Result[0]+1]>0 then
        inc(Result[0]);
    end
  end
end;

function LongArrayToStr(A : TLongArray) : string;
var
  ls : string;
  s  : string;
  I  : integer;
begin
  ls:=IntToStr(luBase div 10);
  Result:=IntToStr(A[A[0]]);
  for i := A[0]-1 downto 1 do begin
    s:=IntToStr(A[I]);
    while s.Length<ls.Length do
      s := '0'+s;
    Result:=Result+s
  end
end;

function More(const A, B: TLongArray; shift : Integer): Byte;
var
  i: Integer;
begin
  If A[0]>(B[0]+shift) then
    More:=0
  Else If A[0]<(B[0]+shift) then
    More:=1
  Else begin
    i:=A[0];
    while (i>shift) And (A [i] =B [i-shift] ) do
      Dec (i) ;
    If i=shift then begin
      More:=0;
      For i:=1 To shift do
        If A[i]>0 then
          Exit;
      More:=2;
    end
    Else
      More:=Byte(A[i]<B[i-shift])
  end
end;

procedure Mul(const A: TLongArray; const K : integer; var C: TLongArray);
var
  i: Integer;
begin
  FillChar(C, SizeOf(C), 0);
  If K=0 then
    Inc(C[0])
  Else begin
    For i:=1 To A[0] do begin
      C[i+1]:=(A[i]*K+C[i] ) Div luBase;
      C[i]:=(LongInt(A[i])*K+C[i]) Mod luBase;
    end;
    If C[A[0]+1]>0 then
      C[0]:=A[0]+1
    Else
      C[0]:=A[0]
  end
end;

procedure Sub(var A: TLongArray; const B: TLongArray; sp: Integer);
var
  i,j : Integer;
begin
  For i:= 1 To B[0] do begin
    Dec (A[i+sp], B[i]) ;
    j:=i;
    while (A[j+sp]<0) and (j<=A[0]) do begin
      Inc(A[j+sp], luBase);
      Dec(A[j+sp+1]);
      Inc(j)
    end
  end;
  i:=A[0];
  while (i>1) and (A[i]=0) do
    Dec(i);
  A[0]:=i
end;

function FindNext(var Rem: TLongArray; const B : TLongArray; sp: Integer) : integer;
var
  iMin, iMax : integer;
  C        : TLongArray;
begin
  iMin:=0;
  iMax:=luBase;
  while iMax-1>iMin do begin
    Mul(B,(iMax+iMin) Div 2, C);
    case More(Rem, C, sp) of
      0 : iMin:=(iMin+iMax) div 2;
      1 : iMax:= (iMax+iMin) div 2;
      2 : begin
            iMax:=(iMax+iMin) div 2;
            iMin:=iMax
          end;
    end;
  end;
  Mul(B, (iMax+iMin) div 2, C);

  if More(Rem,C,0) =0 then
    Sub(Rem, C, sp)
  else begin
    Sub(C, Rem, sp);
    Rem:=C
  end;
  Result:=(iMax+iMin) div 2
end;

procedure GetDiv(const A, B: TLongArray; var Res, Rem : TLongArray) ;
var
  sp : Integer;
begin
  Rem:=A;
  sp:=A[0]-B[0];
  If More(A,B,sp)=1 then
    Dec(sp);
  Res[0]:=sp+1;
  while sp>=0 do begin
    Res[sp+1]:=FindNext(Rem,B,sp);
    Dec(sp);
  end;
end;
function LongArrDivide(const A, B : TLongArray; var Rem : TLongArray) : TLongArray;
begin
  FillChar(Result, SizeOf(Result), 0);
  Result[0]:=1;
  FillChar(Rem, SizeOf(Rem), 0);
  Rem[0]:=1;
  Case More(A, B, 0) Of
     0 : GetDiv(A,B, Result, Rem);
     1 : Rem:=A;
     2 : Result[1]:=1;
  end
end;

function LongArrMult(const A, B : TLongArray) : TLongArray;
var
  I, J : integer;
  D    : integer;
Begin
  FillChar(Result, SizeOf(Result), 0);
  for I:=1 to A[0] do
    for J:=1 to B[0] do begin
      D:=(A[I]*B[J])+Result[I+J-1];
      Inc(Result[I+J], D Div luBase);
      Result[I+J-1]:=D mod luBase
    end;
  Result[0]:=A[0]+B[0] ;
  while (Result[0]>1) AND (Result[Result[0]]=0) do
    dec(Result[0])
end;

function LongArrSub(const A, B : TLongArray) : TLongArray;
begin
  Result:=A;
  Sub(Result, B, 0)
end;

end.
