# 🗃️ Database Helpers para Delphi

Helpers poderosos para **TFDQuery** e **TField** que simplificam drasticamente o trabalho com banco de dados no Delphi.

## 📋 Características

### 🔍 **FDQueryHelper**
- **Execução fluente** de SQL com parâmetros
- **Conversões automáticas** para JSON, CSV, arrays
- **Navegação simplificada** nos registros
- **Validações e verificações** rápidas
- **Funções de agregação** (Sum, Count, Min, Max, Average)
- **Transações fluentes** com rollback automático
- **Debug avançado** de SQL e parâmetros

### 🏷️ **FieldHelper**
- **Conversões seguras** com valores padrão
- **Validações brasileiras** (CPF, CNPJ, CEP, telefone)
- **Formatação automática** de documentos e valores
- **Operações matemáticas** em campos numéricos
- **Manipulação avançada** de datas e horários
- **Criptografia e hash** (MD5, SHA1, SHA256, Base64)
- **Operações de string** avançadas

## 🚀 Exemplos de Uso

### **FDQueryHelper - Execução Fluente**

```delphi
uses FDQueryHelper;

// Método tradicional
FDQuery1.SQL.Text := 'SELECT * FROM Clientes WHERE Ativo = ? AND Salario >= ?';
FDQuery1.ParamByName('Ativo').Value := True;
FDQuery1.ParamByName('Salario').Value := 2500;
FDQuery1.Open;

// Com Helper - muito mais limpo!
FDQuery1.OpenSQL('SELECT * FROM Clientes WHERE Ativo = ? AND Salario >= ?', [True, 2500]);

// Execução com parâmetros nomeados fluentes
FDQuery1
  .SetSQL('UPDATE Clientes SET Salario = ? WHERE ID = ?')
  .SetParam('Salario', 3000.0)
  .SetParam('ID', 123)
  .ExecSQL;
```

### **Conversões para JSON**

```delphi
// Registro atual como JSON
var JsonString := FDQuery1.ToJSON;
// {"ID":1,"Nome":"João Silva","Email":"joao@email.com","Salario":2500.00}

// Todos os registros como array JSON
var JsonArray := FDQuery1.ToJSONArray;
// [{"ID":1,"Nome":"João"...},{"ID":2,"Nome":"Maria"...}]

// Apenas campos específicos
var JsonEspecifico := FDQuery1.ToJSONArray(['Nome', 'Email']);
```

### **Verificações e Navegação**

```delphi
// Verificações simples
if FDQuery1.IsEmpty then
  ShowMessage('Nenhum registro encontrado');

if FDQuery1.HasRecords then
  ShowMessage(Format('Encontrados %d registros', [FDQuery1.RecordCount]));

// Navegação fluente
FDQuery1
  .FirstRecord
  .ForEach(procedure(Query: TFDQuery)
           begin
             ShowMessage(Query.StringValue('Nome', 'Sem nome'));
           end);
```

### **Funções de Agregação**

```delphi
FDQuery1.OpenSQL('SELECT ValorVenda FROM Vendas');

var TotalVendas := FDQuery1.Sum('ValorVenda');
var MediaVendas := FDQuery1.Average('ValorVenda');
var MaiorVenda := FDQuery1.Max('ValorVenda');
var MenorVenda := FDQuery1.Min('ValorVenda');

// Contagem condicional
var VendasAltas := FDQuery1.Count(function(Query: TFDQuery): Boolean
                                  begin
                                    Result := Query.FloatValue('ValorVenda') > 1000;
                                  end);
```

### **Transações Fluentes**

```delphi
// Transação com rollback automático em caso de erro
FDQuery1.InTransaction(
  procedure(Query: TFDQuery)
  begin
    Query.ExecSQL('UPDATE Produtos SET Preco = Preco * 1.1');
    Query.ExecSQL('INSERT INTO Log (Operacao) VALUES (?)', ['Reajuste de preços']);
    // Se qualquer comando falhar, faz rollback automático
  end
);
```

### **FieldHelper - Conversões Seguras**

```delphi
uses FieldHelper;

var NomeField := FDQuery1.FieldByName('Nome');
var IdadeField := FDQuery1.FieldByName('Idade');
var SalarioField := FDQuery1.FieldByName('Salario');

// Conversões com valores padrão
var Nome := NomeField.AsStringDef('Nome não informado');
var Idade := IdadeField.AsIntegerDef(0);
var Salario := SalarioField.AsCurrencyDef(0);

// Verificações de estado
if NomeField.IsNotEmpty and SalarioField.HasValue then
  // Processar...
```

### **Validações Brasileiras**

```delphi
var CPFField := FDQuery1.FieldByName('CPF');
var CNPJField := FDQuery1.FieldByName('CNPJ');
var EmailField := FDQuery1.FieldByName('Email');
var TelefoneField := FDQuery1.FieldByName('Telefone');

// Validações automáticas
if CPFField.IsCPF then
  ShowMessage('CPF válido: ' + CPFField.FormatCPF);

if CNPJField.IsCNPJ then
  ShowMessage('CNPJ válido: ' + CNPJField.FormatCNPJ);

if EmailField.IsEmail then
  ShowMessage('Email válido');

if TelefoneField.IsPhone then
  ShowMessage('Telefone: ' + TelefoneField.FormatPhone);
```

### **Operações de String Avançadas**

```delphi
var NomeField := FDQuery1.FieldByName('Nome');

// Operações de string
var NomeLimpo := NomeField.Trim.RemoveAccents.ProperCase;
var PrimeiroNome := NomeField.WordAt(0);
var QuantidadePalavras := NomeField.WordCount;
var ApenasLetras := NomeField.OnlyLetters;
var ApenasNumeros := NomeField.OnlyNumbers;

// Hash e criptografia
var MD5Hash := NomeField.ToMD5;
var Base64 := NomeField.ToBase64;
```

### **Operações com Data/Hora**

```delphi
var DataNascField := FDQuery1.FieldByName('DataNascimento');
var DataCadastroField := FDQuery1.FieldByName('DataCadastro');

// Cálculos de idade e tempo
var Idade := DataNascField.Age;
var DiasVividos := DataNascField.DaysSince(Now);

// Verificações temporais
if DataNascField.IsToday then
  ShowMessage('Aniversariante do dia!');

if DataCadastroField.IsThisWeek then
  ShowMessage('Cliente cadastrado esta semana');

// Formatações especiais
var DataRelativa := DataCadastroField.ToRelativeString; // "2 dias atrás"
var DataISO := DataCadastroField.ToISOString; // "2024-01-15T10:30:00"
```

### **Operações Matemáticas**

```delphi
var SalarioField := FDQuery1.FieldByName('Salario');
var QuantidadeField := FDQuery1.FieldByName('Quantidade');

// Operações matemáticas
var NovoSalario := SalarioField.Multiply(1.1); // Aumento de 10%
var SalarioArredondado := SalarioField.Round(2);
var SalarioAbsoluto := SalarioField.Abs;

// Verificações
if SalarioField.IsPositive and QuantidadeField.IsEven then
  // Processar...
```

### **Operações em Conjuntos de Campos**

```delphi
// Métodos de classe para múltiplos campos
var Campos := [FDQuery1.FieldByName('Valor1'), 
               FDQuery1.FieldByName('Valor2'), 
               FDQuery1.FieldByName('Valor3')];

var Soma := TFieldHelper.SumFields(Campos);
var Media := TFieldHelper.AverageFields(Campos);
var Concatenacao := TFieldHelper.ConcatFields(Campos, ' - ');
var QuantidadeNulos := TFieldHelper.CountNull(Campos);
```

## 🛠️ Instalação

1. **Baixe os arquivos:**
   - `FDQueryHelper.pas`
   - `FieldHelper.pas`

2. **Adicione ao seu projeto:**
   ```delphi
   uses FDQueryHelper, FieldHelper;
   ```

3. **Configure as dependências:**
   - FireDAC (para FDQueryHelper)
   - System.JSON (para conversões JSON)
   - System.Hash (para funções de hash)

## 🎯 Benefícios

### **Produtividade**
- **90% menos código** para operações comuns de banco
- **Sintaxe fluente** e intuitiva
- **IntelliSense completo** no IDE

### **Confiabilidade**
- **Tratamento de erros** automático
- **Conversões seguras** com fallback
- **Validações rigorosas** de dados brasileiros

### **Performance**
- **Operações otimizadas** para grandes volumes
- **Caching inteligente** de conversões
- **Uso eficiente** de memória

### **Manutenibilidade**
- **Código mais limpo** e legível
- **Padronização** de operações
- **Documentação integrada** via IntelliSense

## 📖 Casos de Uso Comuns

### **1. Relatórios e Exportação**
```delphi
// Exportar vendas para CSV
var CSV := FDQuery1
  .OpenSQL('SELECT * FROM Vendas WHERE DataVenda >= ?', [StartOfMonth(Now)])
  .ToCSV(';', True);
  
SaveStringToFile('vendas.csv', CSV);
```

### **2. APIs REST**
```delphi
// Retornar dados para API
function GetClientesJSON: string;
begin
  Result := FDQuery1
    .OpenSQL('SELECT ID, Nome, Email FROM Clientes WHERE Ativo = ?', [True])
    .ToJSONArray(['ID', 'Nome', 'Email']);
end;
```

### **3. Validação de Formulários**
```delphi
// Validar dados antes de salvar
procedure ValidarCliente;
begin
  with FDQuery1 do
  begin
    if not FieldByName('CPF').IsCPF then
      raise Exception.Create('CPF inválido: ' + FieldByName('CPF').AsString);
      
    if not FieldByName('Email').IsEmail then
      raise Exception.Create('Email inválido');
      
    if FieldByName('Idade').Age < 18 then
      raise Exception.Create('Cliente deve ser maior de idade');
  end;
end;
```

### **4. Dashboards e Analytics**
```delphi
// Calcular métricas para dashboard
procedure CalcularMetricas;
begin
  FDQuery1.OpenSQL('SELECT ValorVenda, DataVenda FROM Vendas WHERE DataVenda >= ?', [StartOfMonth(Now)]);
  
  lblTotalVendas.Caption := FormatCurr(',0.00', FDQuery1.Sum('ValorVenda'));
  lblMediaVendas.Caption := FormatCurr(',0.00', FDQuery1.Average('ValorVenda'));
  lblQuantidadeVendas.Caption := IntToStr(FDQuery1.Count);
  
  // Vendas da última semana
  var VendasRecentes := FDQuery1.Count(function(Q: TFDQuery): Boolean
                                       begin
                                         Result := Q.FieldByName('DataVenda').IsThisWeek;
                                       end);
end;
```

## 🎉 Conclusão

Estes helpers transformam o desenvolvimento com banco de dados no Delphi, proporcionando:

- ✅ **Sintaxe moderna** e fluente
- ✅ **Redução drástica** de código boilerplate  
- ✅ **Validações automáticas** para dados brasileiros
- ✅ **Conversões seguras** e confiáveis
- ✅ **Performance otimizada** para aplicações reais
- ✅ **Compatibilidade total** com FireDAC

**Ideal para:** Sistemas ERP, CRM, e-commerce, APIs REST, relatórios, dashboards e qualquer aplicação que trabalhe intensivamente com dados.

---

*Desenvolvido para a comunidade Delphi Brasil* 🇧🇷
