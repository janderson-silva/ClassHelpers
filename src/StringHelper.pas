unit StringHelper;

interface

uses
  System.SysUtils, System.StrUtils, System.RegularExpressions, System.Classes;

type
  // Helper completo para String
  TStringHelper = record helper for String
  public
    // Métodos de conversão
    function ToInteger: Integer;
    function ToIntegerDef(const ADefault: Integer = 0): Integer;
    function ToFloat: Double;
    function ToFloatDef(const ADefault: Double = 0.0): Double;
    function ToBoolean: Boolean;
    function ToBooleanDef(const ADefault: Boolean = False): Boolean;
    function ToDateTime: TDateTime;
    function ToDateTimeDef(const ADefault: TDateTime): TDateTime;
    
    // Métodos de manipulação
    function Reverse: String;
    function RemoveSpaces: String;
    function RemoveAccents: String;
    function OnlyNumbers: String;
    function OnlyLetters: String;
    function OnlyAlphaNumeric: String;
    function Capitalize: String;
    function CamelCase: String;
    function PascalCase: String;
    function SnakeCase: String;
    function KebabCase: String;
    function RepeatString(const ACount: Integer): String;
    function Left(const ACount: Integer): String;
    function Right(const ACount: Integer): String;
    function Mid(const AStart, ALength: Integer): String;
    function PadLeft(const ATotalWidth: Integer; const APaddingChar: Char = ' '): String;
    function PadRight(const ATotalWidth: Integer; const APaddingChar: Char = ' '): String;
    function RemoveChar(const AChar: Char): String;
    function ReplaceChar(const AOldChar, ANewChar: Char): String;
    function Insert(const AIndex: Integer; const AValue: String): String;
    function Delete(const AIndex, ACount: Integer): String;
    
    // Métodos de validação
    function IsEmpty: Boolean;
    function IsNotEmpty: Boolean;
    function IsNumeric: Boolean;
    function IsAlpha: Boolean;
    function IsAlphaNumeric: Boolean;
    function IsEmail: Boolean;
    function IsCPF: Boolean;
    function IsCNPJ: Boolean;
    function IsPhone: Boolean;
    function IsURL: Boolean;
    function IsDate: Boolean;
    function IsTime: Boolean;
    function IsDateTime: Boolean;
    function IsValidRegex(const APattern: String): Boolean;
    
    // Métodos de busca e comparação
    function ContainsIgnoreCase(const AValue: String): Boolean;
    function StartsWithIgnoreCase(const AValue: String): Boolean;
    function EndsWithIgnoreCase(const AValue: String): Boolean;
    function CountOccurrences(const ASubstring: String): Integer;
    function IndexOfIgnoreCase(const AValue: String): Integer;
    function LastIndexOfIgnoreCase(const AValue: String): Integer;
    function EqualsIgnoreCase(const AValue: String): Boolean;
    
    // Métodos de formatação
    function FormatCPF: String;
    function FormatCNPJ: String;
    function FormatPhone: String;
    function FormatCEP: String;
    function FormatCurrency: String;
    function FormatBytes: String;
    
    // Métodos de array
    function Split(const ADelimiter: String): TArray<String>; overload;
    function Split(const ADelimiters: array of Char): TArray<String>; overload;
    function Join(const AArray: TArray<String>): String;
    
    // Métodos de hash e criptografia
    function MD5: String;
    function SHA1: String;
    function Base64Encode: String;
    function Base64Decode: String;
    
    // Métodos utilitários
    function WordCount: Integer;
    function CharCount(const AChar: Char): Integer;
    function ToSlug: String;
    function Truncate(const AMaxLength: Integer; const ASuffix: String = '...'): String;
    function EscapeHTML: String;
    function UnescapeHTML: String;
    function ToHex: String;
    function FromHex: String;
  end;

implementation

uses
  System.Hash, System.NetEncoding;

{ TStringHelper }

// Métodos de conversão
function TStringHelper.ToInteger: Integer;
begin
  Result := StrToInt(Self);
end;

function TStringHelper.ToIntegerDef(const ADefault: Integer): Integer;
begin
  Result := StrToIntDef(Self, ADefault);
end;

function TStringHelper.ToFloat: Double;
begin
  Result := StrToFloat(Self);
end;

function TStringHelper.ToFloatDef(const ADefault: Double): Double;
begin
  Result := StrToFloatDef(Self, ADefault);
end;

function TStringHelper.ToBoolean: Boolean;
begin
  Result := StrToBool(Self);
end;

function TStringHelper.ToBooleanDef(const ADefault: Boolean): Boolean;
begin
  Result := StrToBoolDef(Self, ADefault);
end;

function TStringHelper.ToDateTime: TDateTime;
begin
  Result := StrToDateTime(Self);
end;

function TStringHelper.ToDateTimeDef(const ADefault: TDateTime): TDateTime;
begin
  Result := StrToDateTimeDef(Self, ADefault);
end;

// Métodos de manipulação
function TStringHelper.Reverse: String;
var
  I: Integer;
begin
  Result := '';
  for I := Length(Self) downto 1 do
    Result := Result + Self[I];
end;

function TStringHelper.RemoveSpaces: String;
begin
  Result := StringReplace(Self, ' ', '', [rfReplaceAll]);
end;

function TStringHelper.RemoveAccents: String;
const
  Accents = 'àáâãäåæçèéêëìíîïðñòóôõöøùúûüýþÿÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝÞŸ';
  NoAccents = 'aaaaaaaceeeeiiiidnooooooouuuuythyAAAAAACEEEEIIIIDNOOOOOOUUUUYTHY';
var
  I, J: Integer;
begin
  Result := Self;
  for I := 1 to Length(Accents) do
  begin
    for J := 1 to Length(Result) do
    begin
      if Result[J] = Accents[I] then
        Result[J] := NoAccents[I];
    end;
  end;
end;

function TStringHelper.OnlyNumbers: String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Self) do
  begin
    if CharInSet(Self[I], ['0'..'9']) then
      Result := Result + Self[I];
  end;
end;

function TStringHelper.OnlyLetters: String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Self) do
  begin
    if CharInSet(Self[I], ['A'..'Z', 'a'..'z']) then
      Result := Result + Self[I];
  end;
end;

function TStringHelper.OnlyAlphaNumeric: String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Self) do
  begin
    if CharInSet(Self[I], ['A'..'Z', 'a'..'z', '0'..'9']) then
      Result := Result + Self[I];
  end;
end;

function TStringHelper.Capitalize: String;
begin
  if Length(Self) > 0 then
    Result := UpperCase(Self[1]) + LowerCase(Copy(Self, 2, Length(Self)))
  else
    Result := Self;
end;

function TStringHelper.CamelCase: String;
var
  Words: TArray<String>;
  I: Integer;
begin
  Words := Self.Split([' ', '_', '-']);
  Result := '';
  for I := 0 to High(Words) do
  begin
    if I = 0 then
      Result := LowerCase(Words[I])
    else
      Result := Result + Words[I].Capitalize;
  end;
end;

function TStringHelper.PascalCase: String;
var
  Words: TArray<String>;
  I: Integer;
begin
  Words := Self.Split([' ', '_', '-']);
  Result := '';
  for I := 0 to High(Words) do
    Result := Result + Words[I].Capitalize;
end;

function TStringHelper.SnakeCase: String;
begin
  Result := LowerCase(StringReplace(Self, ' ', '_', [rfReplaceAll]));
end;

function TStringHelper.KebabCase: String;
begin
  Result := LowerCase(StringReplace(Self, ' ', '-', [rfReplaceAll]));
end;

function TStringHelper.RepeatString(const ACount: Integer): String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to ACount do
    Result := Result + Self;
end;

function TStringHelper.Left(const ACount: Integer): String;
begin
  Result := Copy(Self, 1, ACount);
end;

function TStringHelper.Right(const ACount: Integer): String;
begin
  Result := Copy(Self, Length(Self) - ACount + 1, ACount);
end;

function TStringHelper.Mid(const AStart, ALength: Integer): String;
begin
  Result := Copy(Self, AStart, ALength);
end;

function TStringHelper.PadLeft(const ATotalWidth: Integer; const APaddingChar: Char): String;
begin
  Result := StringOfChar(APaddingChar, ATotalWidth - Length(Self)) + Self;
end;

function TStringHelper.PadRight(const ATotalWidth: Integer; const APaddingChar: Char): String;
begin
  Result := Self + StringOfChar(APaddingChar, ATotalWidth - Length(Self));
end;

function TStringHelper.RemoveChar(const AChar: Char): String;
begin
  Result := StringReplace(Self, AChar, '', [rfReplaceAll]);
end;

function TStringHelper.ReplaceChar(const AOldChar, ANewChar: Char): String;
begin
  Result := StringReplace(Self, AOldChar, ANewChar, [rfReplaceAll]);
end;

function TStringHelper.Insert(const AIndex: Integer; const AValue: String): String;
begin
  Result := Self;
  System.Insert(AValue, Result, AIndex);
end;

function TStringHelper.Delete(const AIndex, ACount: Integer): String;
begin
  Result := Self;
  System.Delete(Result, AIndex, ACount);
end;

// Métodos de validação
function TStringHelper.IsEmpty: Boolean;
begin
  Result := Self = '';
end;

function TStringHelper.IsNotEmpty: Boolean;
begin
  Result := Self <> '';
end;

function TStringHelper.IsNumeric: Boolean;
var
  Dummy: Extended;
begin
  Result := TryStrToFloat(Self, Dummy);
end;

function TStringHelper.IsAlpha: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Self) do
  begin
    if not CharInSet(Self[I], ['A'..'Z', 'a'..'z']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TStringHelper.IsAlphaNumeric: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(Self) do
  begin
    if not CharInSet(Self[I], ['A'..'Z', 'a'..'z', '0'..'9']) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TStringHelper.IsEmail: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
end;

function TStringHelper.IsCPF: Boolean;
var
  CPF: String;
  I, Soma, Resto: Integer;
begin
  CPF := Self.OnlyNumbers;
  Result := False;
  
  if Length(CPF) <> 11 then
    Exit;
    
  // Verifica se todos os dígitos são iguais
  if CPF = StringOfChar(CPF[1], 11) then
    Exit;
    
  // Primeiro dígito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(CPF[I]) * (11 - I);
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
    
  if Resto <> StrToInt(CPF[10]) then
    Exit;
    
  // Segundo dígito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(CPF[I]) * (12 - I);
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
    
  Result := Resto = StrToInt(CPF[11]);
end;

function TStringHelper.IsCNPJ: Boolean;
var
  CNPJ: String;
  I, Soma, Resto: Integer;
  Pesos: array[1..13] of Integer;
begin
  CNPJ := Self.OnlyNumbers;
  Result := False;
  
  if Length(CNPJ) <> 14 then
    Exit;
    
  // Verifica se todos os dígitos são iguais
  if CNPJ = StringOfChar(CNPJ[1], 14) then
    Exit;
    
  // Primeiro dígito verificador
  Pesos[1] := 5; Pesos[2] := 4; Pesos[3] := 3; Pesos[4] := 2;
  Pesos[5] := 9; Pesos[6] := 8; Pesos[7] := 7; Pesos[8] := 6;
  Pesos[9] := 5; Pesos[10] := 4; Pesos[11] := 3; Pesos[12] := 2;
  
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
    
  if Resto <> StrToInt(CNPJ[13]) then
    Exit;
    
  // Segundo dígito verificador
  Pesos[1] := 6; Pesos[2] := 7; Pesos[3] := 8; Pesos[4] := 9;
  Pesos[5] := 2; Pesos[6] := 3; Pesos[7] := 4; Pesos[8] := 5;
  Pesos[9] := 6; Pesos[10] := 7; Pesos[11] := 8; Pesos[12] := 9;
  Pesos[13] := 2;
  
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
    
  Result := Resto = StrToInt(CNPJ[14]);
end;

function TStringHelper.IsPhone: Boolean;
var
  Phone: String;
begin
  Phone := Self.OnlyNumbers;
  Result := (Length(Phone) = 10) or (Length(Phone) = 11);
end;

function TStringHelper.IsURL: Boolean;
begin
  Result := TRegEx.IsMatch(Self, '^(https?|ftp)://[^\s/$.?#].[^\s]*$', [roIgnoreCase]);
end;

function TStringHelper.IsDate: Boolean;
var
  Dummy: TDateTime;
begin
  Result := TryStrToDate(Self, Dummy);
end;

function TStringHelper.IsTime: Boolean;
var
  Dummy: TDateTime;
begin
  Result := TryStrToTime(Self, Dummy);
end;

function TStringHelper.IsDateTime: Boolean;
var
  Dummy: TDateTime;
begin
  Result := TryStrToDateTime(Self, Dummy);
end;

function TStringHelper.IsValidRegex(const APattern: String): Boolean;
begin
  try
    TRegEx.IsMatch(Self, APattern);
    Result := True;
  except
    Result := False;
  end;
end;

// Métodos de busca e comparação
function TStringHelper.ContainsIgnoreCase(const AValue: String): Boolean;
begin
  Result := Pos(UpperCase(AValue), UpperCase(Self)) > 0;
end;

function TStringHelper.StartsWithIgnoreCase(const AValue: String): Boolean;
begin
  Result := Pos(UpperCase(AValue), UpperCase(Self)) = 1;
end;

function TStringHelper.EndsWithIgnoreCase(const AValue: String): Boolean;
var
  SelfUpper, ValueUpper: String;
begin
  SelfUpper := UpperCase(Self);
  ValueUpper := UpperCase(AValue);
  Result := Copy(SelfUpper, Length(SelfUpper) - Length(ValueUpper) + 1, Length(ValueUpper)) = ValueUpper;
end;

function TStringHelper.CountOccurrences(const ASubstring: String): Integer;
var
  Pos, Offset: Integer;
begin
  Result := 0;
  Offset := 1;
  repeat
    Pos := PosEx(ASubstring, Self, Offset);
    if Pos > 0 then
    begin
      Inc(Result);
      Offset := Pos + Length(ASubstring);
    end;
  until Pos = 0;
end;

function TStringHelper.IndexOfIgnoreCase(const AValue: String): Integer;
begin
  Result := Pos(UpperCase(AValue), UpperCase(Self));
  if Result > 0 then
    Dec(Result); // Converte para base 0
end;

function TStringHelper.LastIndexOfIgnoreCase(const AValue: String): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Length(Self) - Length(AValue) + 1 downto 1 do
  begin
    if UpperCase(Copy(Self, I, Length(AValue))) = UpperCase(AValue) then
    begin
      Result := I - 1; // Base 0
      Break;
    end;
  end;
end;

function TStringHelper.EqualsIgnoreCase(const AValue: String): Boolean;
begin
  Result := SameText(Self, AValue);
end;

// Métodos de formatação
function TStringHelper.FormatCPF: String;
var
  CPF: String;
begin
  CPF := Self.OnlyNumbers;
  if Length(CPF) = 11 then
    Result := Format('%s.%s.%s-%s', [Copy(CPF, 1, 3), Copy(CPF, 4, 3), Copy(CPF, 7, 3), Copy(CPF, 10, 2)])
  else
    Result := Self;
end;

function TStringHelper.FormatCNPJ: String;
var
  CNPJ: String;
begin
  CNPJ := Self.OnlyNumbers;
  if Length(CNPJ) = 14 then
    Result := Format('%s.%s.%s/%s-%s', [Copy(CNPJ, 1, 2), Copy(CNPJ, 3, 3), Copy(CNPJ, 6, 3), Copy(CNPJ, 9, 4), Copy(CNPJ, 13, 2)])
  else
    Result := Self;
end;

function TStringHelper.FormatPhone: String;
var
  Phone: String;
begin
  Phone := Self.OnlyNumbers;
  case Length(Phone) of
    10: Result := Format('(%s) %s-%s', [Copy(Phone, 1, 2), Copy(Phone, 3, 4), Copy(Phone, 7, 4)]);
    11: Result := Format('(%s) %s-%s', [Copy(Phone, 1, 2), Copy(Phone, 3, 5), Copy(Phone, 8, 4)]);
  else
    Result := Self;
  end;
end;

function TStringHelper.FormatCEP: String;
var
  CEP: String;
begin
  CEP := Self.OnlyNumbers;
  if Length(CEP) = 8 then
    Result := Format('%s-%s', [Copy(CEP, 1, 5), Copy(CEP, 6, 3)])
  else
    Result := Self;
end;

function TStringHelper.FormatCurrency: String;
var
  Value: Currency;
begin
  if TryStrToCurr(Self, Value) then
    Result := FormatCurr('#,##0.00', Value)
  else
    Result := Self;
end;

function TStringHelper.FormatBytes: String;
var
  Bytes: Int64;
const
  KB = 1024;
  MB = KB * 1024;
  GB = MB * 1024;
  TB = GB * Int64(1024);
begin
  if TryStrToInt64(Self, Bytes) then
  begin
    if Bytes >= TB then
      Result := Format('%.2f TB', [Bytes / TB])
    else if Bytes >= GB then
      Result := Format('%.2f GB', [Bytes / GB])
    else if Bytes >= MB then
      Result := Format('%.2f MB', [Bytes / MB])
    else if Bytes >= KB then
      Result := Format('%.2f KB', [Bytes / KB])
    else
      Result := Format('%d bytes', [Bytes]);
  end
  else
    Result := Self;
end;

// Métodos de array
function TStringHelper.Split(const ADelimiter: String): TArray<String>;
begin
  Result := SplitString(Self, ADelimiter);
end;

function TStringHelper.Split(const ADelimiters: array of Char): TArray<String>;
var
  List: TStringList;
  I: Integer;
  Temp: String;
begin
  List := TStringList.Create;
  try
    Temp := Self;
    for I := Low(ADelimiters) to High(ADelimiters) do
      Temp := StringReplace(Temp, ADelimiters[I], #13#10, [rfReplaceAll]);
    
    List.Text := Temp;
    SetLength(Result, List.Count);
    for I := 0 to List.Count - 1 do
      Result[I] := List[I];
  finally
    List.Free;
  end;
end;

function TStringHelper.Join(const AArray: TArray<String>): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to High(AArray) do
  begin
    if I > 0 then
      Result := Result + Self;
    Result := Result + AArray[I];
  end;
end;

// Métodos de hash e criptografia
function TStringHelper.MD5: String;
begin
  Result := THashMD5.GetHashString(Self);
end;

function TStringHelper.SHA1: String;
begin
  Result := THashSHA1.GetHashString(Self);
end;

function TStringHelper.Base64Encode: String;
begin
  Result := TNetEncoding.Base64.Encode(Self);
end;

function TStringHelper.Base64Decode: String;
begin
  try
    Result := TNetEncoding.Base64.Decode(Self);
  except
    Result := Self;
  end;
end;

// Métodos utilitários
function TStringHelper.WordCount: Integer;
var
  Words: TArray<String>;
begin
  Words := Self.Split([' ', #9, #13, #10]);
  Result := Length(Words);
end;

function TStringHelper.CharCount(const AChar: Char): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 1 to Length(Self) do
  begin
    if Self[I] = AChar then
      Inc(Result);
  end;
end;

function TStringHelper.ToSlug: String;
begin
  Result := LowerCase(Self.RemoveAccents);
  Result := TRegEx.Replace(Result, '[^a-z0-9\s]', '');
  Result := TRegEx.Replace(Result, '\s+', '-');
  Result := TRegEx.Replace(Result, '^-+|-+$', '');
end;

function TStringHelper.Truncate(const AMaxLength: Integer; const ASuffix: String): String;
begin
  if Length(Self) <= AMaxLength then
    Result := Self
  else
    Result := Copy(Self, 1, AMaxLength - Length(ASuffix)) + ASuffix;
end;

function TStringHelper.EscapeHTML: String;
begin
  Result := StringReplace(Self, '&', '&amp;', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;', [rfReplaceAll]);
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]);
  Result := StringReplace(Result, '''', '&#39;', [rfReplaceAll]);
end;

function TStringHelper.UnescapeHTML: String;
begin
  Result := StringReplace(Self, '&amp;', '&', [rfReplaceAll]);
  Result := StringReplace(Result, '&lt;', '<', [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;', '>', [rfReplaceAll]);
  Result := StringReplace(Result, '&quot;', '"', [rfReplaceAll]);
  Result := StringReplace(Result, '&#39;', '''', [rfReplaceAll]);
end;

function TStringHelper.ToHex: String;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Self) do
    Result := Result + IntToHex(Ord(Self[I]), 2);
end;

function TStringHelper.FromHex: String;
var
  I: Integer;
  HexPair: String;
begin
  Result := '';
  for I := 1 to Length(Self) div 2 do
  begin
    HexPair := Copy(Self, (I - 1) * 2 + 1, 2);
    Result := Result + Chr(StrToInt('$' + HexPair));
  end;
end;

end.
