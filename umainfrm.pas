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
    function GetDivisible: integer;
    function GetDivisor: integer;
    procedure CheckCalcAllowed;
  public
    property Divisor : integer read GetDivisor;
    property Divisible : integer read GetDivisible;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.bCalcClick(Sender: TObject);
var
  iDi, iDr : integer;
  L, iTmp  : integer;
  iRes     : integer;
  sDi, sDr : string;
  shift    : string;
  sTmp     : string;
  sDummy   : string;
  bAdded   : boolean;
begin
  mStat.Lines.Clear;
  iDi:=Divisible;
  iDr:=Divisor;
  if iDr=0 then  // always check to control exception
    raise Exception.Create('Can''t divide by zero!');
  sDi:=IntToStr(iDi);
  sDr:=IntToStr(iDr);
  L:=sDr.Length;
  Shift:='';
  iRes:=0;
  bAdded:=true;
  mStat.Lines.Add(Format('%d : %d = %d', [iDi, iDr, iDi div iDr]));
  while sDi.Length>=L do begin
    if (NOT bAdded) AND (iRes=0) then
      Shift:=Shift+Shift.Create(' ', L);
    bAdded:=false;
    sTmp:=sDi.Substring(0, L);
    sDi:=sDi.Remove(0, L);
    iTmp:=sTmp.ToInteger;
    if iTmp<iDr then begin // if number has equal ranks but less than divisor, add one more
      if sDi.Length=0 then
        Break;
      sTmp:=sTmp+sDi.Substring(0,1);
      iTmp:=sTmp.ToInteger;
      sDi:=sDi.Remove(0, 1);
      bAdded:=true
    end;
    sDummy:=sDummy.Create('-', sTmp.Length);
    iRes:=iTmp div iDr;
    mStat.Lines.Add(shift+IntToStr(iDr*iRes));
    mStat.Lines.Add(shift+sDummy);
    iRes:=iTmp-(iDr*iRes);
    iTmp:=sTmp.Length;
    sTmp:=IntToStr(iRes);
    if (sTmp.Length<iTmp) then
      Shift:=Shift+Shift.Create(' ', iTmp-sTmp.Length);
    mStat.Lines.Add(shift+sTmp);
    if iRes>0 then
      sDi:=sTmp+sDi
  end
end;

procedure TMainForm.CheckCalcAllowed;
begin
  bCalc.Enabled:=(Divisor>0) AND (Divisible>=Divisor)
end;

procedure TMainForm.eDivisibleChange(Sender: TObject);
begin
  CheckCalcAllowed
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  CheckCalcAllowed
end;

function TMainForm.GetDivisible: integer;
begin
  Result:=StrToIntDef(eDivisible.Text,0)
end;

function TMainForm.GetDivisor: integer;
begin
  Result:=StrToIntDef(eDivisor.Text,0)
end;

end.
