program test_div;

uses
  Vcl.Forms,
  umainfrm in 'umainfrm.pas' {MainForm},
  LongUtils in 'LongUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
