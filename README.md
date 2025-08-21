# StringHelper - Classe Helper para String em Delphi

Uma biblioteca completa de extensões para o tipo `String` em Delphi, fornecendo mais de 60 métodos úteis para manipulação, validação, formatação e conversão de strings.

## 📋 Índice

- [Instalação](#instalação)
- [Uso Básico](#uso-básico)
- [Métodos Disponíveis](#métodos-disponíveis)
  - [Conversões](#conversões)
  - [Manipulação](#manipulação)
  - [Validação](#validação)
  - [Busca e Comparação](#busca-e-comparação)
  - [Formatação](#formatação)
  - [Arrays](#arrays)
  - [Hash e Criptografia](#hash-e-criptografia)
  - [Utilitários](#utilitários)
- [Exemplos de Uso](#exemplos-de-uso)
- [Compatibilidade](#compatibilidade)
- [Licença](#licença)

## 🚀 Instalação

1. Baixe o arquivo `StringHelper.pas`
2. Adicione-o ao seu projeto Delphi
3. Inclua `StringHelper` na cláusula `uses` da sua unit

```pascal
uses
  StringHelper;
```

## 📖 Uso Básico

Após incluir a unit, todos os métodos estarão disponíveis diretamente em qualquer variável do tipo `String`:

```pascal
var
  MinhaString: String;
begin
  MinhaString := 'Hello World';
  ShowMessage(MinhaString.Reverse); // Exibe: "dlroW olleH"
end;
```

## 📚 Métodos Disponíveis

### 🔄 Conversões

Converte strings para outros tipos de dados com segurança:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `ToInteger` | Converte para Integer | `'123'.ToInteger` → `123` |
| `ToIntegerDef(default)` | Converte para Integer com valor padrão | `'abc'.ToIntegerDef(0)` → `0` |
| `ToFloat` | Converte para Double | `'123.45'.ToFloat` → `123.45` |
| `ToFloatDef(default)` | Converte para Double com valor padrão | `'abc'.ToFloatDef(0.0)` → `0.0` |
| `ToBoolean` | Converte para Boolean | `'True'.ToBoolean` → `True` |
| `ToBooleanDef(default)` | Converte para Boolean com valor padrão | `'abc'.ToBooleanDef(False)` → `False` |
| `ToDateTime` | Converte para TDateTime | `'01/01/2024'.ToDateTime` |
| `ToDateTimeDef(default)` | Converte para TDateTime com valor padrão | |

### ✂️ Manipulação

Métodos para transformar e manipular strings:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `Reverse` | Inverte a string | `'Hello'.Reverse` → `'olleH'` |
| `RemoveSpaces` | Remove todos os espaços | `'H e l l o'.RemoveSpaces` → `'Hello'` |
| `RemoveAccents` | Remove acentos | `'João'.RemoveAccents` → `'Joao'` |
| `OnlyNumbers` | Mantém apenas números | `'ABC123xyz'.OnlyNumbers` → `'123'` |
| `OnlyLetters` | Mantém apenas letras | `'ABC123xyz'.OnlyLetters` → `'ABCxyz'` |
| `OnlyAlphaNumeric` | Mantém letras e números | `'ABC-123!xyz'.OnlyAlphaNumeric` → `'ABC123xyz'` |
| `Capitalize` | Primeira letra maiúscula | `'hello'.Capitalize` → `'Hello'` |
| `CamelCase` | Converte para camelCase | `'hello world'.CamelCase` → `'helloWorld'` |
| `PascalCase` | Converte para PascalCase | `'hello world'.PascalCase` → `'HelloWorld'` |
| `SnakeCase` | Converte para snake_case | `'hello world'.SnakeCase` → `'hello_world'` |
| `KebabCase` | Converte para kebab-case | `'hello world'.KebabCase` → `'hello-world'` |
| `RepeatString(count)` | Repete a string N vezes | `'Hi'.RepeatString(3)` → `'HiHiHi'` |
| `Left(count)` | Primeiros N caracteres | `'Hello'.Left(3)` → `'Hel'` |
| `Right(count)` | Últimos N caracteres | `'Hello'.Right(3)` → `'llo'` |
| `Mid(start, length)` | Substring específica | `'Hello'.Mid(2, 2)` → `'el'` |
| `PadLeft(width, char)` | Preenche à esquerda | `'Hi'.PadLeft(5, '*')` → `'***Hi'` |
| `PadRight(width, char)` | Preenche à direita | `'Hi'.PadRight(5, '*')` → `'Hi***'` |
| `RemoveChar(char)` | Remove caractere específico | `'Hello'.RemoveChar('l')` → `'Heo'` |
| `ReplaceChar(old, new)` | Substitui caractere | `'Hello'.ReplaceChar('l', 'x')` → `'Hexxo'` |
| `Insert(index, value)` | Insere string na posição | `'Hello'.Insert(3, 'XX')` → `'HeXXllo'` |
| `Delete(index, count)` | Remove caracteres | `'Hello'.Delete(2, 2)` → `'Hlo'` |

### ✅ Validação

Verifica se a string atende a critérios específicos:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `IsEmpty` | Verifica se está vazia | `''.IsEmpty` → `True` |
| `IsNotEmpty` | Verifica se não está vazia | `'Hello'.IsNotEmpty` → `True` |
| `IsNumeric` | Contém apenas números | `'123'.IsNumeric` → `True` |
| `IsAlpha` | Contém apenas letras | `'ABC'.IsAlpha` → `True` |
| `IsAlphaNumeric` | Contém letras e números | `'ABC123'.IsAlphaNumeric` → `True` |
| `IsEmail` | É um email válido | `'user@domain.com'.IsEmail` → `True` |
| `IsCPF` | É um CPF válido | `'12345678901'.IsCPF` → `False` |
| `IsCNPJ` | É um CNPJ válido | `'12345678000195'.IsCNPJ` → `False` |
| `IsPhone` | É um telefone válido | `'11987654321'.IsPhone` → `True` |
| `IsURL` | É uma URL válida | `'https://github.com'.IsURL` → `True` |
| `IsDate` | É uma data válida | `'01/01/2024'.IsDate` → `True` |
| `IsTime` | É um horário válido | `'14:30:00'.IsTime` → `True` |
| `IsDateTime` | É data/hora válida | `'01/01/2024 14:30'.IsDateTime` → `True` |
| `IsValidRegex(pattern)` | Corresponde ao regex | `'abc123'.IsValidRegex('[a-z]+\d+')` → `True` |

### 🔍 Busca e Comparação

Métodos para buscar e comparar strings:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `ContainsIgnoreCase(value)` | Contém texto (ignore case) | `'Hello'.ContainsIgnoreCase('ELLO')` → `True` |
| `StartsWithIgnoreCase(value)` | Inicia com texto (ignore case) | `'Hello'.StartsWithIgnoreCase('HEL')` → `True` |
| `EndsWithIgnoreCase(value)` | Termina com texto (ignore case) | `'Hello'.EndsWithIgnoreCase('LLO')` → `True` |
| `CountOccurrences(substring)` | Conta ocorrências | `'Hello World'.CountOccurrences('l')` → `3` |
| `IndexOfIgnoreCase(value)` | Primeira posição (ignore case) | `'Hello'.IndexOfIgnoreCase('LLO')` → `2` |
| `LastIndexOfIgnoreCase(value)` | Última posição (ignore case) | `'Hello World'.LastIndexOfIgnoreCase('L')` → `9` |
| `EqualsIgnoreCase(value)` | Compara ignorando case | `'Hello'.EqualsIgnoreCase('HELLO')` → `True` |

### 🎨 Formatação

Formata strings para padrões específicos:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `FormatCPF` | Formata como CPF | `'12345678901'.FormatCPF` → `'123.456.789-01'` |
| `FormatCNPJ` | Formata como CNPJ | `'12345678000195'.FormatCNPJ` → `'12.345.678/0001-95'` |
| `FormatPhone` | Formata como telefone | `'11987654321'.FormatPhone` → `'(11) 98765-4321'` |
| `FormatCEP` | Formata como CEP | `'01234567'.FormatCEP` → `'01234-567'` |
| `FormatCurrency` | Formata como moeda | `'1234.56'.FormatCurrency` → `'1,234.56'` |
| `FormatBytes` | Formata tamanho de arquivo | `'1048576'.FormatBytes` → `'1.00 MB'` |

### 📊 Arrays

Trabalha com arrays de strings:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `Split(delimiter)` | Divide por delimitador | `'a,b,c'.Split(',')` → `['a','b','c']` |
| `Split(delimiters[])` | Divide por múltiplos delimitadores | `'a,b;c'.Split([',',';'])` → `['a','b','c']` |
| `Join(array)` | Une array com a string atual | `','.Join(['a','b','c'])` → `'a,b,c'` |

### 🔐 Hash e Criptografia

Gera hashes e codifica strings:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `MD5` | Hash MD5 | `'Hello'.MD5` → `'8b1a9953c4611296...'` |
| `SHA1` | Hash SHA1 | `'Hello'.SHA1` → `'f7c3bc1d808e04732...'` |
| `Base64Encode` | Codifica em Base64 | `'Hello'.Base64Encode` → `'SGVsbG8='` |
| `Base64Decode` | Decodifica Base64 | `'SGVsbG8='.Base64Decode` → `'Hello'` |

### 🛠️ Utilitários

Métodos utilitários diversos:

| Método | Descrição | Exemplo |
|--------|-----------|---------|
| `WordCount` | Conta palavras | `'Hello World'.WordCount` → `2` |
| `CharCount(char)` | Conta caractere específico | `'Hello'.CharCount('l')` → `2` |
| `ToSlug` | Converte para slug URL | `'João da Silva'.ToSlug` → `'joao-da-silva'` |
| `Truncate(length, suffix)` | Trunca com sufixo | `'Hello World'.Truncate(5)` → `'He...'` |
| `EscapeHTML` | Escapa HTML | `'<div>'.EscapeHTML` → `'&lt;div&gt;'` |
| `UnescapeHTML` | Remove escape HTML | `'&lt;div&gt;'.UnescapeHTML` → `'<div>'` |
| `ToHex` | Converte para hexadecimal | `'ABC'.ToHex` → `'414243'` |
| `FromHex` | Converte de hexadecimal | `'414243'.FromHex` → `'ABC'` |

## 💡 Exemplos de Uso

### Validação de Dados

```pascal
var
  Email, CPF, Telefone: String;
begin
  Email := 'usuario@exemplo.com';
  CPF := '12345678901';
  Telefone := '11987654321';
  
  if Email.IsEmail then
    ShowMessage('Email válido: ' + Email.FormatEmail);
    
  if CPF.IsCPF then
    ShowMessage('CPF válido: ' + CPF.FormatCPF);
    
  if Telefone.IsPhone then
    ShowMessage('Telefone válido: ' + Telefone.FormatPhone);
end;
```

### Manipulação de Texto

```pascal
var
  Texto: String;
begin
  Texto := 'João da Silva Santos';
  
  // Remove acentos e cria slug
  ShowMessage(Texto.ToSlug); // joao-da-silva-santos
  
  // Converte para diferentes formatos
  ShowMessage(Texto.CamelCase);  // joãoDaSilvaSantos
  ShowMessage(Texto.PascalCase); // JoãoDaSilvaSantos
  ShowMessage(Texto.SnakeCase);  // joão_da_silva_santos
end;
```

### Processamento de Arrays

```pascal
var
  CSV, Resultado: String;
  Itens: TArray<String>;
begin
  CSV := 'maçã,banana,laranja';
  Itens := CSV.Split(',');
  
  // Processa cada item
  for var Item in Itens do
    Item := Item.Capitalize.RemoveAccents;
    
  Resultado := ' | '.Join(Itens); // Maça | Banana | Laranja
end;
```

### Criptografia e Hash

```pascal
var
  Senha, Hash: String;
begin
  Senha := 'MinhaSenh@123';
  
  // Gera hashes
  Hash := Senha.MD5;
  ShowMessage('MD5: ' + Hash);
  
  Hash := Senha.SHA1;
  ShowMessage('SHA1: ' + Hash);
  
  // Codificação Base64
  Hash := Senha.Base64Encode;
  ShowMessage('Base64: ' + Hash);
end;
```

## 🔧 Compatibilidade

- **Delphi**: XE7 ou superior
- **Plataformas**: Windows, macOS, Linux, iOS, Android
- **Dependências**: System.SysUtils, System.StrUtils, System.RegularExpressions, System.Classes, System.Hash, System.NetEncoding

## 📝 Changelog

### v1.0.0
- ✅ Implementação inicial com 60+ métodos
- ✅ Métodos de conversão, validação e manipulação
- ✅ Suporte para CPF, CNPJ, email, telefone
- ✅ Hash MD5, SHA1 e codificação Base64
- ✅ Formatação de dados brasileiros
- ✅ Documentação completa

## 📜 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**Seu Nome**
- GitHub: [@Janderson Silva](https://github.com/janderson-silva)
- Email: janderson97.dev@gmail.com

## ⭐ Agradecimentos

- Comunidade Delphi Brasil
- Embarcadero Technologies

---

### 📊 Estatísticas

![GitHub stars](https://img.shields.io/github/stars/seunome/stringhelper)
![GitHub forks](https://img.shields.io/github/forks/seunome/stringhelper)
![GitHub issues](https://img.shields.io/github/issues/seunome/stringhelper)
![GitHub license](https://img.shields.io/github/license/seunome/stringhelper)