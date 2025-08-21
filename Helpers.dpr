program Helpers;

uses
  Vcl.Forms,
  untPrincipal in 'src\untPrincipal.pas' {Form1},
  StringHelper in 'src\StringHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
