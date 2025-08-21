unit DatabaseHelperExample;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, 
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSAcc,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait,
  FDQueryHelper, FieldHelper, System.JSON, System.Generics.Collections, System.Math;

type
  TfrmDatabaseExample = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    Memo1: TMemo;
    btnTestarFDQueryHelper: TButton;
    btnTestarFieldHelper: TButton;
    btnExemplosAvancados: TButton;
    btnCriarDadosDemo: TButton;
    procedure btnTestarFDQueryHelperClick(Sender: TObject);
    procedure btnTestarFieldHelperClick(Sender: TObject);
    procedure btnExemplosAvancadosClick(Sender: TObject);
    procedure btnCriarDadosDemoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Log(const AMessage: string);
    procedure ConfigurarBanco;
    procedure CriarTabelasDemo;
    procedure InserirDadosDemo;
    procedure ExemplosBasicosFDQuery;
    procedure ExemplosConversaoJSON;
    procedure ExemplosParametros;
    procedure ExemplosAgregacao;
    procedure ExemplosBasicosField;
    procedure ExemplosValidacao;
    procedure ExemplosFormatacao;
    procedure ExemplosDataHora;
  end;

var
  frmDatabaseExample: TfrmDatabaseExample;

implementation

{$R *.dfm}

procedure TfrmDatabaseExample.FormCreate(Sender: TObject);
begin
  ConfigurarBanco;
end;

procedure TfrmDatabaseExample.ConfigurarBanco;
begin
  // Configuração para banco Access de exemplo
  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('Database=C:\temp\exemplo.mdb');
  FDConnection1.Params.Add('DriverID=MSAcc');
  FDConnection1.LoginPrompt := False;
  
  try
    FDConnection1.Connected := True;
    Log('✓ Conexão com banco estabelecida');
  except
    on E: Exception do
      Log('✗ Erro ao conectar: ' + E.Message);
  end;
end;

procedure TfrmDatabaseExample.Log(const AMessage: string);
begin
  Memo1.Lines.Add(FormatDateTime('hh:nn:ss', Now) + ' - ' + AMessage);
  Application.ProcessMessages;
end;

procedure TfrmDatabaseExample.btnCriarDadosDemoClick(Sender: TObject);
begin
  Log('=== CRIANDO DADOS DE DEMONSTRAÇÃO ===');
  CriarTabelasDemo;
  InserirDadosDemo;
  Log('✓ Dados de demonstração criados com sucesso!');
end;

procedure TfrmDatabaseExample.CriarTabelasDemo;
begin
  // Criar tabela Clientes
  FDQuery1.ExecSQL(
    'CREATE TABLE Clientes (' +
    'ID AUTOINCREMENT PRIMARY KEY, ' +
    'Nome TEXT(100), ' +
    'Email TEXT(100), ' +
    'Telefone TEXT(20), ' +
    'CPF TEXT(14), ' +
    'DataNascimento DATE, ' +
    'Salario CURRENCY, ' +
    'Ativo YESNO, ' +
    'DataCadastro DATETIME)'
  );
  
  // Criar tabela Vendas
  FDQuery1.ExecSQL(
    'CREATE TABLE Vendas (' +
    'ID AUTOINCREMENT PRIMARY KEY, ' +
    'ClienteID INTEGER, ' +
    'Produto TEXT(100), ' +
    'Quantidade INTEGER, ' +
    'ValorUnitario CURRENCY, ' +
    'DataVenda DATETIME, ' +
    'Descricao MEMO)'
  );
  
  Log('✓ Tabelas criadas');
end;

procedure TfrmDatabaseExample.InserirDadosDemo;
var
  I: Integer;
  Nomes: TArray<string>;
  Produtos: TArray<string>;
begin
  Nomes := ['João Silva', 'Maria Santos', 'Pedro Oliveira', 'Ana Costa', 'Carlos Ferreira'];
  Produtos := ['Notebook', 'Mouse', 'Teclado', 'Monitor', 'Webcam'];
  
  // Inserir clientes
  for I := 0 to High(Nomes) do
  begin
    FDQuery1.ExecSQL('INSERT INTO Clientes (Nome, Email, Telefone, CPF, DataNascimento, Salario, Ativo, DataCadastro) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [
      Nomes[I],
      LowerCase(Nomes[I].Replace(' ', '.')) + '@email.com',
      '(11) 9999-' + Format('%.4d', [1000 + I]),
      Format('%.3d.%.3d.%.3d-%.2d', [100 + I, 200 + I, 300 + I, 10 + I]),
      EncodeDate(1980 + I, 1 + I, 1 + I),
      2000 + (I * 500),
      I mod 2 = 0,
      Now - I
    ]);
  end;
  
  // Inserir vendas
  for I := 0 to 19 do
  begin
    FDQuery1.ExecSQL('INSERT INTO Vendas (ClienteID, Produto, Quantidade, ValorUnitario, DataVenda, Descricao) VALUES (?, ?, ?, ?, ?, ?)', [
      (I mod 5) + 1,
      Produtos[I mod 5],
      1 + (I mod 3),
      100 + (I * 50),
      Now - I,
      'Venda de ' + Produtos[I mod 5] + ' para cliente'
    ]);
  end;
  
  Log('✓ Dados inseridos');
end;

procedure TfrmDatabaseExample.btnTestarFDQueryHelperClick(Sender: TObject);
begin
  Log('=== TESTANDO FDQUERY HELPER ===');
  ExemplosBasicosFDQuery;
  ExemplosConversaoJSON;
  ExemplosParametros;
  ExemplosAgregacao;
end;

procedure TfrmDatabaseExample.ExemplosBasicosFDQuery;
begin
  Log('--- Exemplos Básicos FDQuery ---');
  
  // Abrir query de forma fluente
  FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE Ativo = ?', [True]);
  
  Log(Format('Clientes ativos: %d', [FDQuery1.RecordCount]));
  Log(Format('Query vazia?: %s', [BoolToStr(FDQuery1.IsEmpty, True)]));
  Log(Format('Tem registros?: %s', [BoolToStr(FDQuery1.HasRecords, True)]));
  
  // Navegar pelos registros
  FDQuery1.FirstRecord.ForEach(
    procedure(Query: TFDQuery)
    begin
      Log(Format('Cliente: %s - Email: %s', [
        Query.StringValue('Nome'),
        Query.StringValue('Email')
      ]));
    end
  );
end;

procedure TfrmDatabaseExample.ExemplosConversaoJSON;
begin
  Log('--- Conversão para JSON ---');
  
  FDQuery1.OpenSQL('SELECT TOP 2 ID, Nome, Email, Salario FROM Clientes');
  
  // Registro atual como JSON
  Log('JSON do primeiro registro:');
  Log(FDQuery1.ToJSON);
  
  // Todos os registros como array JSON
  Log('JSON Array de todos os registros:');
  Log(FDQuery1.ToJSONArray);
  
  // Apenas campos específicos
  Log('JSON com campos específicos:');
  Log(FDQuery1.ToJSONArray(['Nome', 'Email']));
end;

procedure TfrmDatabaseExample.ExemplosParametros;
begin
  Log('--- Trabalho com Parâmetros ---');
  
  // Método tradicional vs Helper
  FDQuery1
    .SetSQL('SELECT * FROM Clientes WHERE Salario >= ? AND Ativo = ? AND DataNascimento > ?')
    .SetParam('Salario', 2500.0)
    .SetParam('Ativo', True)
    .SetParam('DataNascimento', EncodeDate(1982, 1, 1))
    .Open;
  
  Log(Format('Clientes com salário >= 2500: %d', [FDQuery1.RecordCount]));
  
  // Debug de parâmetros
  Log('Parâmetros da query:');
  Log(FDQuery1.DebugParams);
end;

procedure TfrmDatabaseExample.ExemplosAgregacao;
begin
  Log('--- Funções de Agregação ---');
  
  FDQuery1.OpenSQL('SELECT ClienteID, ValorUnitario, Quantidade FROM Vendas');
  
  // Usando helpers para agregação
  Log(Format('Soma valores unitários: %.2f', [FDQuery1.Sum('ValorUnitario')]));
  Log(Format('Média valores unitários: %.2f', [FDQuery1.Average('ValorUnitario')]));
  Log(Format('Valor mínimo: %s', [VarToStr(FDQuery1.Min('ValorUnitario'))]));
  Log(Format('Valor máximo: %s', [VarToStr(FDQuery1.Max('ValorUnitario'))]));
  
  // Contagem condicional
  Log(Format('Vendas com valor > 200: %d', [
    FDQuery1.Count(function(Query: TFDQuery): Boolean
    begin
      Result := Query.FloatValue('ValorUnitario') > 200;
    end)
  ]));
end;

procedure TfrmDatabaseExample.btnTestarFieldHelperClick(Sender: TObject);
begin
  Log('=== TESTANDO FIELD HELPER ===');
  ExemplosBasicosField;
  ExemplosValidacao;
  ExemplosFormatacao;
  ExemplosDataHora;
end;

procedure TfrmDatabaseExample.ExemplosBasicosField;
var
  NomeField, EmailField, SalarioField: TField;
begin
  Log('--- Exemplos Básicos Field ---');
  
  FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE ID = 1');
  
  NomeField := FDQuery1.FieldByName('Nome');
  EmailField := FDQuery1.FieldByName('Email');
  SalarioField := FDQuery1.FieldByName('Salario');
  
  // Verificações de estado
  Log(Format('Nome vazio?: %s', [BoolToStr(NomeField.IsEmpty, True)]));
  Log(Format('Email tem valor?: %s', [BoolToStr(EmailField.HasValue, True)]));
  
  // Conversões seguras
  Log(Format('Nome: %s', [NomeField.AsStringDef('Sem nome')]));
  Log(Format('Salário: R$ %.2f', [SalarioField.AsFloatDef(0)]));
  
  // Operações de string
  Log(Format('Nome em maiúsculo: %s', [NomeField.UpperCase]));
  Log(Format('Email em minúsculo: %s', [EmailField.LowerCase]));
  Log(Format('Nome sem espaços: %s', [NomeField.RemoveSpaces]));
end;

procedure TfrmDatabaseExample.ExemplosValidacao;
var
  EmailField, CPFField, TelefoneField: TField;
begin
  Log('--- Validações ---');
  
  FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE ID = 1');
  
  EmailField := FDQuery1.FieldByName('Email');
  CPFField := FDQuery1.FieldByName('CPF');
  TelefoneField := FDQuery1.FieldByName('Telefone');
  
  // Validações específicas
  Log(Format('Email válido?: %s', [BoolToStr(EmailField.IsEmail, True)]));
  Log(Format('CPF válido?: %s', [BoolToStr(CPFField.IsCPF, True)]));
  Log(Format('Telefone válido?: %s', [BoolToStr(TelefoneField.IsPhone, True)]));
  
  // Validações de conteúdo
  Log(Format('Email contém @?: %s', [BoolToStr(EmailField.ContainsText('@'), True)]));
  Log(Format('Nome começa com "João"?: %s', [BoolToStr(FDQuery1.FieldByName('Nome').StartsWithText('João'), True)]));
end;

procedure TfrmDatabaseExample.ExemplosFormatacao;
var
  CPFField, TelefoneField, SalarioField: TField;
begin
  Log('--- Formatação ---');
  
  FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE ID = 1');
  
  CPFField := FDQuery1.FieldByName('CPF');
  TelefoneField := FDQuery1.FieldByName('Telefone');
  SalarioField := FDQuery1.FieldByName('Salario');
  
  // Formatações específicas brasileiras
  Log(Format('CPF formatado: %s', [CPFField.FormatCPF]));
  Log(Format('Telefone formatado: %s', [TelefoneField.FormatPhone]));
  Log(Format('Salário como moeda: %s', [SalarioField.FormatCurrency(2)]));
  Log(Format('Salário como número: %s', [SalarioField.FormatNumber(2)]));
  
  // Hash e codificação
  Log(Format('MD5 do nome: %s', [FDQuery1.FieldByName('Nome').ToMD5]));
  Log(Format('Base64 do email: %s', [FDQuery1.FieldByName('Email').ToBase64]));
end;

procedure TfrmDatabaseExample.ExemplosDataHora;
var
  DataNascField, DataCadastroField: TField;
begin
  Log('--- Data e Hora ---');
  
  FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE ID = 1');
  
  DataNascField := FDQuery1.FieldByName('DataNascimento');
  DataCadastroField := FDQuery1.FieldByName('DataCadastro');
  
  // Operações com data
  Log(Format('Idade: %d anos', [DataNascField.Age]));
  Log(Format('Ano de nascimento: %d', [DataNascField.YearOf]));
  Log(Format('É aniversário hoje?: %s', [BoolToStr(DataNascField.IsToday, True)]));
  Log(Format('Nasceu em fim de semana?: %s', [BoolToStr(DataNascField.IsWeekend, True)]));
  
  // Formatações de data
  Log(Format('Data nascimento curta: %s', [DataNascField.ToShortDateString]));
  Log(Format('Data nascimento longa: %s', [DataNascField.ToLongDateString]));
  Log(Format('Data cadastro relativa: %s', [DataCadastroField.ToRelativeString]));
  Log(Format('ISO string: %s', [DataCadastroField.ToISOString]));
  
  // Cálculos de data
  Log(Format('Dias desde nascimento: %d', [DataNascField.DaysSince(Now)]));
  Log(Format('Próximo aniversário em: %d dias', [Trunc(DataNascField.AddYears(1) - Now)]));
end;

procedure TfrmDatabaseExample.btnExemplosAvancadosClick(Sender: TObject);
var
  VendasCSV: string;
  JSONArray: string;
begin
  Log('=== EXEMPLOS AVANÇADOS ===');
  
  // Converter query para JSON
  FDQuery1.OpenSQL('SELECT ID, Nome, Email FROM Clientes WHERE Ativo = ?', [True]);
  JSONArray := FDQuery1.ToJSONArray;
  Log('JSON Array de clientes: ' + JSONArray);
  
  // Exportar para CSV
  FDQuery1.OpenSQL('SELECT Produto, Quantidade, ValorUnitario FROM Vendas');
  VendasCSV := FDQuery1.ToCSV(';', True);
  Log('Vendas exportadas para CSV:');
  Log(Copy(VendasCSV, 1, 200) + '...');
  
  // Trabalho com transações fluente
  FDQuery1.InTransaction(
    procedure(Query: TFDQuery)
    begin
      Query.ExecSQL('UPDATE Clientes SET Salario = Salario * 1.1 WHERE Ativo = ?', [True]);
      Log('✓ Salários dos clientes ativos aumentados em 10% (dentro de transação)');
    end
  );
  
  // Operações em lote com ForEach
  FDQuery1.OpenSQL('SELECT ID, Nome, Salario FROM Clientes WHERE Ativo = ?', [True])
    .ForEachRecord(
      procedure(Query: TFDQuery; Index: Integer)
      begin
        if Index < 3 then  // Mostrar apenas os 3 primeiros
          Log(Format('Registro %d: %s - Novo salário: R$ %.2f', [
            Index + 1,
            Query.StringValue('Nome'),
            Query.FloatValue('Salario')
          ]));
      end
    );
  
  // Busca simples por campo
  FDQuery1.First;
  while not FDQuery1.Eof do
  begin
    if FDQuery1.FloatValue('Salario') > 3000 then
    begin
      Log(Format('Encontrado cliente com salário > 3000: %s', [FDQuery1.StringValue('Nome')]));
      Break;
    end;
    FDQuery1.Next;
  end;
  
  Log('✓ Exemplos avançados concluídos');
end;

end.
