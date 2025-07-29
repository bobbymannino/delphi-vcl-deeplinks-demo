unit FormMain_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormMain = class(TForm)
    LabelOutput: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses UtilDeeplinks, NetEncoding;

procedure TFormMain.FormCreate(Sender: TObject);
var
  Payload: string;
begin
  RegisterDeeplink('myapp', 'Deeplinks Demo', ParamStr(0));

  if ParamCount < 1 then
    Exit;

  Payload := ExtractAfterProtocol(ParamStr(1), 'myapp');

  // This will decode things like '%20' to a space
  LabelOutput.Caption := TNetEncoding.URL.Decode(Payload);
end;

end.
