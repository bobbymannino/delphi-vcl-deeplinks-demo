program DeeplinksDemo;

uses
  Vcl.Forms,
  FormMain_u in 'Forms\FormMain_u.pas' {FormMain},
  UtilDeeplinks in 'Utils\UtilDeeplinks.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
