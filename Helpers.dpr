program Helpers;

uses
  Vcl.Forms,
  ColorHelper in 'src\ColorHelper.pas',
  DatabaseHelperExample in 'src\DatabaseHelperExample.pas' {frmDatabaseExample},
  DateTimeHelper in 'src\DateTimeHelper.pas',
  FDQueryHelper in 'src\FDQueryHelper.pas',
  FieldHelper in 'src\FieldHelper.pas',
  IntegerHelper in 'src\IntegerHelper.pas',
  IntegerHelperSimple in 'src\IntegerHelperSimple.pas',
  StringHelper in 'src\StringHelper.pas',
  untPrincipal in 'src\untPrincipal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmDatabaseExample, frmDatabaseExample);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmDatabaseExample, frmDatabaseExample);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
