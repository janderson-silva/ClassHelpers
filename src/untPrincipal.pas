unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, StringHelper;

type
  TForm1 = class(TForm)
    edtTexto: TEdit;
    lblTexto: TLabel;
    btnTest: TButton;
    btnReverse: TButton;
    btnRemoveSpaces: TButton;
    btnCapitalize: TButton;
    btnOnlyNumbers: TButton;
    btnWordCount: TButton;
    btnIsEmpty: TButton;
    edtNumero: TEdit;
    lblNumero: TLabel;
    btnToInteger: TButton;
    procedure btnTestClick(Sender: TObject);
    procedure btnReverseClick(Sender: TObject);
    procedure btnRemoveSpacesClick(Sender: TObject);
    procedure btnCapitalizeClick(Sender: TObject);
    procedure btnOnlyNumbersClick(Sender: TObject);
    procedure btnWordCountClick(Sender: TObject);
    procedure btnIsEmptyClick(Sender: TObject);
    procedure btnToIntegerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnTestClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Teste Reverse: ' + S.Reverse);
end;

procedure TForm1.btnReverseClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Resultado: ' + S.Reverse);
end;

procedure TForm1.btnRemoveSpacesClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Resultado: ' + S.RemoveSpaces);
end;

procedure TForm1.btnCapitalizeClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Resultado: ' + S.Capitalize);
end;

procedure TForm1.btnOnlyNumbersClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Resultado: ' + S.OnlyNumbers);
end;

procedure TForm1.btnWordCountClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  ShowMessage('Palavras: ' + IntToStr(S.WordCount));
end;

procedure TForm1.btnIsEmptyClick(Sender: TObject);
var
  S: String;
begin
  S := edtTexto.Text;
  if S.IsEmpty then
    ShowMessage('Texto está vazio')
  else
    ShowMessage('Texto não está vazio');
end;

procedure TForm1.btnToIntegerClick(Sender: TObject);
var
  S: String;
begin
  S := edtNumero.Text;
  ShowMessage('Resultado: ' + IntToStr(S.ToIntegerDef));
end;

end.
