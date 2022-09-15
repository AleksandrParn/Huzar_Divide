unit umainfrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    mStat: TMemo;
    Panel1: TPanel;
    eDivisible: TEdit;
    eDivisor: TEdit;
    bCalc: TButton;
    procedure eDivisibleChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bCalcClick(Sender: TObject);
  private
    procedure CheckCalcAllowed;
    procedure DoCalc;
  public
  end;

var
  MainForm: TMainForm;

implementation

uses LongUtils;

{$R *.dfm}

procedure TMainForm.bCalcClick(Sender: TObject);
begin
  DoCalc
end;

procedure TMainForm.CheckCalcAllowed;
begin
  bCalc.Enabled:=(Length(eDivisible.Text)>0) AND
                 ((Length(eDivisible.Text)>Length(eDivisor.Text))
                  OR
                  (((Length(eDivisible.Text)=Length(eDivisor.Text)) AND (StrToIntDef(eDivisible.Text[1],0)>StrToIntDef(eDivisor.Text,0))))
                 )
end;

procedure TMainForm.DoCalc;
var
  iDi, iDr : TLongArray;
  iTmp, A  : TLongArray;
  I, L     : integer;
  iRes     : TLongArray;
  sDi, sDr : string;
  shift    : string;
  sTmp     : string;
  sDummy   : string;
  bAdded   : boolean;
begin
  mStat.Lines.Clear;
  sDi:=eDivisible.Text;
  sDi:=sDi.Trim;
  iDi:=StrToLongArray(sDi);
  sDr:=eDivisor.Text;
  sDr:=sDr.Trim;
  iDr:=StrToLongArray(sDr);

  if IsZeroArray(iDr) then  // always check to control exception
    raise Exception.Create('Can''t divide by zero!');
  L:=sDr.Length;
  Shift:='';
  FillChar(iRes,SizeOf(iRes),0);
  bAdded:=true;
  mStat.Lines.Add(Format('%s : %s = %s', [sDi, sDr, LongArrayToStr(LongArrDivide(iDi, iDr, A))]));
  while sDi.Length>=L do begin
    if (NOT bAdded) AND IsZeroArray(iRes) then
      Shift:=Shift+Shift.Create(' ', L);
    bAdded:=false;
    sTmp:=sDi.Substring(0, L);
    sDi:=sDi.Remove(0, L);
    iTmp:=StrToLongArray(sTmp);
    if MoreArray(iDr, iTmp) then begin // if number has equal ranks but less than divisor, add one more
      if sDi.Length=0 then
        Break;
      sTmp:=sTmp+sDi.Substring(0,1);
      iTmp:=StrToLongArray(sTmp);
      sDi:=sDi.Remove(0, 1);
      bAdded:=true
    end;
    sDummy:=sDummy.Create('-', sTmp.Length);
    iRes:=LongArrDivide(iTmp, iDr, A);
    mStat.Lines.Add(shift+LongArrayToStr(LongArrMult(iDr,iRes)));
    mStat.Lines.Add(shift+sDummy);
    iRes:=LongArrSub(iTmp, LongArrMult(iDr, iRes));
    i:=sTmp.Length;
    sTmp:=LongArrayToStr(iRes);
    if (sTmp.Length<i) then
      Shift:=Shift+Shift.Create(' ', i-sTmp.Length);
    mStat.Lines.Add(shift+sTmp);
    if NOT IsZeroArray(iRes) then
      sDi:=sTmp+sDi
  end
end;

procedure TMainForm.eDivisibleChange(Sender: TObject);
begin
  CheckCalcAllowed
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  CheckCalcAllowed
end;

end.
