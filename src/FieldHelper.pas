unit FieldHelper;

interface

uses
  System.SysUtils, System.Variants, Data.DB, System.Classes, System.JSON,
  System.DateUtils, System.RegularExpressions, System.Math, System.Hash, 
  System.NetEncoding, System.TypInfo;

type
  // Helper para TField
  TFieldHelper = class helper for TField
  public
    // Verificações de estado
    function IsNull: Boolean;
    function IsNotNull: Boolean;
    function IsEmpty: Boolean;
    function IsNotEmpty: Boolean;
    function HasValue: Boolean;
    
    // Conversões seguras com fallback
    function AsStringDef(const ADefault: string = ''): string;
    function AsIntegerDef(const ADefault: Integer = 0): Integer;
    function AsInt64Def(const ADefault: Int64 = 0): Int64;
    function AsFloatDef(const ADefault: Double = 0.0): Double;
    function AsCurrencyDef(const ADefault: Currency = 0): Currency;
    function AsBooleanDef(const ADefault: Boolean = False): Boolean;
    function AsDateTimeDef(const ADefault: TDateTime = 0): TDateTime;
    function AsDateDef(const ADefault: TDate = 0): TDate;
    function AsTimeDef(const ADefault: TTime = 0): TTime;
    function AsVariantDef(const ADefault: Variant): Variant;
    
    // Conversões especiais
    function AsJSON: string;
    function AsHex: string;
    function AsBinary: string;
    function AsBase64: string;
    function AsGUID: string;
    function AsFormattedString(const AFormat: string): string;
    
    // Validações de conteúdo
    function IsNumeric: Boolean;
    function IsInteger: Boolean;
    function IsFloat: Boolean;
    function IsCurrency: Boolean;
    function IsBoolean: Boolean;
    function IsDate: Boolean;
    function IsTime: Boolean;
    function IsDateTime: Boolean;
    function IsEmail: Boolean;
    function IsURL: Boolean;
    function IsGUID: Boolean;
    function IsIPAddress: Boolean;
    function IsCPF: Boolean;
    function IsCNPJ: Boolean;
    function IsPhone: Boolean;
    function IsCEP: Boolean;
    
    // Validações de formato
    function MatchesPattern(const APattern: string): Boolean;
    function ContainsText(const AText: string; const ACaseSensitive: Boolean = False): Boolean;
    function StartsWithText(const AText: string; const ACaseSensitive: Boolean = False): Boolean;
    function EndsWithText(const AText: string; const ACaseSensitive: Boolean = False): Boolean;
    function IsInRange(const AMin, AMax: Variant): Boolean;
    function IsInList(const AValues: array of Variant): Boolean;
    
    // Operações de string
    function Trim: string;
    function TrimLeft: string;
    function TrimRight: string;
    function UpperCase: string;
    function LowerCase: string;
    function ProperCase: string;
    function Reverse: string;
    function RemoveSpaces: string;
    function RemoveAccents: string;
    function OnlyNumbers: string;
    function OnlyLetters: string;
    function OnlyAlphanumeric: string;
    function Left(const ALength: Integer): string;
    function Right(const ALength: Integer): string;
    function Mid(const AStart, ALength: Integer): string;
    function PadLeft(const ALength: Integer; const APadChar: Char = ' '): string;
    function PadRight(const ALength: Integer; const APadChar: Char = ' '): string;
    function RepeatText(const ACount: Integer): string;
    function Replace(const AOldValue, ANewValue: string; const ACaseSensitive: Boolean = True): string;
    function WordCount: Integer;
    function WordAt(const AIndex: Integer): string;
    function LineCount: Integer;
    function LineAt(const AIndex: Integer): string;
    
    // Operações matemáticas (para campos numéricos)
    function Add(const AValue: Double): Double;
    function Subtract(const AValue: Double): Double;
    function Multiply(const AValue: Double): Double;
    function Divide(const AValue: Double): Double;
    function Power(const AExponent: Double): Double;
    function Sqrt: Double;
    function Abs: Double;
    function Round(const ADigits: Integer = 0): Double;
    function Trunc: Int64;
    function Ceil: Int64;
    function Floor: Int64;
    function Min(const AValue: Double): Double;
    function Max(const AValue: Double): Double;
    function IsPositive: Boolean;
    function IsNegative: Boolean;
    function IsZero: Boolean;
    function IsEven: Boolean;
    function IsOdd: Boolean;
    
    // Operações de data/hora
    function AddYears(const AYears: Integer): TDateTime;
    function AddMonths(const AMonths: Integer): TDateTime;
    function AddDays(const ADays: Integer): TDateTime;
    function AddHours(const AHours: Integer): TDateTime;
    function AddMinutes(const AMinutes: Integer): TDateTime;
    function AddSeconds(const ASeconds: Integer): TDateTime;
    function StartOfYear: TDateTime;
    function EndOfYear: TDateTime;
    function StartOfMonth: TDateTime;
    function EndOfMonth: TDateTime;
    function StartOfWeek: TDateTime;
    function EndOfWeek: TDateTime;
    function StartOfDay: TDateTime;
    function EndOfDay: TDateTime;
    function YearOf: Word;
    function MonthOf: Word;
    function DayOf: Word;
    function HourOf: Word;
    function MinuteOf: Word;
    function SecondOf: Word;
    function DayOfWeek: Word;
    function DayOfYear: Word;
    function WeekOfYear: Word;
    function QuarterOfYear: Word;
    function IsToday: Boolean;
    function IsYesterday: Boolean;
    function IsTomorrow: Boolean;
    function IsThisWeek: Boolean;
    function IsThisMonth: Boolean;
    function IsThisYear: Boolean;
    function IsPast: Boolean;
    function IsFuture: Boolean;
    function IsWeekend: Boolean;
    function IsBusinessDay: Boolean;
    function Age: Integer; // Para datas de nascimento
    function DaysUntil(const ADate: TDateTime): Integer;
    function DaysSince(const ADate: TDateTime): Integer;
    function HoursUntil(const ADate: TDateTime): Integer;
    function HoursSince(const ADate: TDateTime): Integer;
    function MinutesUntil(const ADate: TDateTime): Integer;
    function MinutesSince(const ADate: TDateTime): Integer;
    function ToRelativeString: string; // "2 horas atrás", "amanhã", etc.
    function ToShortDateString: string;
    function ToLongDateString: string;
    function ToShortTimeString: string;
    function ToLongTimeString: string;
    function ToISOString: string;
    function ToUnixTimestamp: Int64;
    function FromUnixTimestamp: TDateTime;
    
    // Formatação avançada
    function FormatCurrency(const ADecimals: Integer = 2): string;
    function FormatPercent(const ADecimals: Integer = 2): string;
    function FormatNumber(const ADecimals: Integer = 2): string;
    function FormatFileSize: string; // "1.5 KB", "2.3 MB", etc.
    function FormatCPF: string; // "123.456.789-01"
    function FormatCNPJ: string; // "12.345.678/0001-90"
    function FormatPhone: string; // "(11) 99999-9999"
    function FormatCEP: string; // "12345-678"
    
    // Criptografia e hash
    function ToMD5: string;
    function ToSHA1: string;
    function ToSHA256: string;
    function ToBase64: string;
    function FromBase64: string;
    function Encrypt(const AKey: string): string;
    function Decrypt(const AKey: string): string;
    
    // Utilitários de comparação
    function EqualsTo(const AValue: Variant; const ACaseSensitive: Boolean = True): Boolean;
    function GreaterThan(const AValue: Variant): Boolean;
    function LessThan(const AValue: Variant): Boolean;
    function Between(const AMin, AMax: Variant): Boolean;
    function IsOneOf(const AValues: array of Variant): Boolean;
    
    // Informações sobre o campo
    function DataTypeName: string;
    function FieldInfo: string;
    function MaxLength: Integer;
    function IsRequired: Boolean;
    function IsReadOnly: Boolean;
    function IsVisible: Boolean;
    function IsKey: Boolean;
    function IsAutoIncrement: Boolean;
    function IsCalculated: Boolean;
    function IsLookup: Boolean;
    function IsBLOB: Boolean;
    function IsMemo: Boolean;
    function GetConstraints: TStringList;
    
    // Operações de conjunto (para múltiplos valores)
    class function SumFields(const AFields: array of TField): Double; static;
    class function AverageFields(const AFields: array of TField): Double; static;
    class function MinField(const AFields: array of TField): Variant; static;
    class function MaxField(const AFields: array of TField): Variant; static;
    class function ConcatFields(const AFields: array of TField; const ASeparator: string = ' '): string; static;
    class function CountNonNull(const AFields: array of TField): Integer; static;
    class function CountNull(const AFields: array of TField): Integer; static;
    class function AllFieldsNull(const AFields: array of TField): Boolean; static;
    class function AnyFieldNull(const AFields: array of TField): Boolean; static;
    class function AllFieldsEqual(const AFields: array of TField): Boolean; static;
  end;

implementation

{ TFieldHelper }

function TFieldHelper.IsNull: Boolean;
begin
  Result := inherited IsNull;
end;

function TFieldHelper.IsNotNull: Boolean;
begin
  Result := not IsNull;
end;

function TFieldHelper.IsEmpty: Boolean;
begin
  Result := IsNull or (VarToStr(Value) = '');
end;

function TFieldHelper.IsNotEmpty: Boolean;
begin
  Result := not IsEmpty;
end;

function TFieldHelper.HasValue: Boolean;
begin
  Result := IsNotNull;
end;

function TFieldHelper.AsStringDef(const ADefault: string): string;
begin
  if IsNull then
    Result := ADefault
  else
    Result := AsString;
end;

function TFieldHelper.AsIntegerDef(const ADefault: Integer): Integer;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsInteger;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsInt64Def(const ADefault: Int64): Int64;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsLargeInt;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsFloatDef(const ADefault: Double): Double;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsFloat;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsCurrencyDef(const ADefault: Currency): Currency;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsCurrency;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsBooleanDef(const ADefault: Boolean): Boolean;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsBoolean;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsDateTimeDef(const ADefault: TDateTime): TDateTime;
begin
  if IsNull then
    Result := ADefault
  else
    try
      Result := AsDateTime;
    except
      Result := ADefault;
    end;
end;

function TFieldHelper.AsDateDef(const ADefault: TDate): TDate;
begin
  Result := DateOf(AsDateTimeDef(ADefault));
end;

function TFieldHelper.AsTimeDef(const ADefault: TTime): TTime;
begin
  Result := TimeOf(AsDateTimeDef(ADefault));
end;

function TFieldHelper.AsVariantDef(const ADefault: Variant): Variant;
begin
  if IsNull then
    Result := ADefault
  else
    Result := Value;
end;

function TFieldHelper.AsJSON: string;
begin
  if IsNull then
    Result := 'null'
  else
  begin
    case DataType of
      ftString, ftMemo, ftWideString, ftWideMemo:
        Result := TJSONString.Create(AsString).ToString;
      ftInteger, ftSmallint, ftWord, ftLargeint:
        Result := TJSONNumber.Create(AsInteger).ToString;
      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := TJSONNumber.Create(AsFloat).ToString;
      ftBoolean:
        Result := TJSONBool.Create(AsBoolean).ToString;
      ftDate, ftTime, ftDateTime, ftTimeStamp:
        Result := TJSONString.Create(DateTimeToStr(AsDateTime)).ToString;
    else
      Result := TJSONString.Create(AsString).ToString;
    end;
  end;
end;

function TFieldHelper.AsHex: string;
begin
  if IsNull then
    Result := ''
  else
    case DataType of
      ftInteger, ftSmallint, ftWord, ftLargeint:
        Result := System.SysUtils.IntToHex(AsInteger, 8);
      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := System.SysUtils.IntToHex(System.Trunc(AsFloat), 8);
    else
      Result := '';
    end;
end;

function TFieldHelper.AsBinary: string;
var
  IntValue: Integer;
begin
  if IsNull then
    Result := ''
  else
  begin
    case DataType of
      ftInteger, ftSmallint, ftWord, ftLargeint:
      begin
        IntValue := AsInteger;
        Result := '';
        while IntValue > 0 do
        begin
          Result := Chr(Ord('0') + (IntValue mod 2)) + Result;
          IntValue := IntValue div 2;
        end;
        if Result = '' then Result := '0';
      end;
    else
      Result := '';
    end;
  end;
end;

function TFieldHelper.AsBase64: string;
begin
  if IsNull then
    Result := ''
  else
    Result := TNetEncoding.Base64.Encode(AsString);
end;

function TFieldHelper.AsGUID: string;
var
  GUID: TGUID;
begin
  if IsNull then
    Result := ''
  else
  begin
    try
      GUID := StringToGUID(AsString);
      Result := GUIDToString(GUID);
    except
      Result := '';
    end;
  end;
end;

function TFieldHelper.AsFormattedString(const AFormat: string): string;
begin
  if IsNull then
    Result := ''
  else
  begin
    case DataType of
      ftInteger, ftSmallint, ftWord, ftLargeint:
        Result := Format(AFormat, [AsInteger]);
      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := Format(AFormat, [AsFloat]);
      ftDate, ftTime, ftDateTime, ftTimeStamp:
        Result := FormatDateTime(AFormat, AsDateTime);
    else
      Result := Format(AFormat, [AsString]);
    end;
  end;
end;

function TFieldHelper.IsNumeric: Boolean;
var
  Dummy: Double;
begin
  Result := not IsNull and TryStrToFloat(AsString, Dummy);
end;

function TFieldHelper.IsInteger: Boolean;
var
  Dummy: Integer;
begin
  Result := not IsNull and TryStrToInt(AsString, Dummy);
end;

function TFieldHelper.IsFloat: Boolean;
var
  Dummy: Double;
begin
  Result := not IsNull and TryStrToFloat(AsString, Dummy) and (Pos('.', AsString) > 0);
end;

function TFieldHelper.IsCurrency: Boolean;
var
  Dummy: Currency;
begin
  Result := not IsNull and TryStrToCurr(AsString, Dummy);
end;

function TFieldHelper.IsBoolean: Boolean;
var
  Dummy: Boolean;
begin
  Result := not IsNull and TryStrToBool(AsString, Dummy);
end;

function TFieldHelper.IsDate: Boolean;
var
  Dummy: TDateTime;
begin
  Result := not IsNull and TryStrToDate(AsString, Dummy);
end;

function TFieldHelper.IsTime: Boolean;
var
  Dummy: TDateTime;
begin
  Result := not IsNull and TryStrToTime(AsString, Dummy);
end;

function TFieldHelper.IsDateTime: Boolean;
var
  Dummy: TDateTime;
begin
  Result := not IsNull and TryStrToDateTime(AsString, Dummy);
end;

function TFieldHelper.IsEmail: Boolean;
const
  EmailPattern = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
begin
  Result := not IsNull and TRegEx.IsMatch(AsString, EmailPattern);
end;

function TFieldHelper.IsURL: Boolean;
const
  URLPattern = '^https?://[^\s/$.?#].[^\s]*$';
begin
  Result := not IsNull and TRegEx.IsMatch(AsString, URLPattern);
end;

function TFieldHelper.IsGUID: Boolean;
var
  GUID: TGUID;
begin
  Result := not IsNull and (Length(AsString) = 38) and
           (AsString[1] = '{') and (AsString[38] = '}');
  if Result then
  begin
    try
      GUID := StringToGUID(AsString);
    except
      Result := False;
    end;
  end;
end;

function TFieldHelper.IsIPAddress: Boolean;
const
  IPPattern = '^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$';
begin
  Result := not IsNull and TRegEx.IsMatch(AsString, IPPattern);
end;

function TFieldHelper.IsCPF: Boolean;
var
  CPF: string;
  I, Soma, Resto: Integer;
begin
  Result := False;
  if IsNull then Exit;
  
  CPF := OnlyNumbers;
  if Length(CPF) <> 11 then Exit;
  
  // Verifica se todos os dígitos são iguais
  if CPF = StringOfChar(CPF[1], 11) then Exit;
  
  // Calcula primeiro dígito verificador
  Soma := 0;
  for I := 1 to 9 do
    Soma := Soma + StrToInt(CPF[I]) * (11 - I);
  Resto := (Soma * 10) mod 11;
  if Resto = 10 then Resto := 0;
  if Resto <> StrToInt(CPF[10]) then Exit;
  
  // Calcula segundo dígito verificador
  Soma := 0;
  for I := 1 to 10 do
    Soma := Soma + StrToInt(CPF[I]) * (12 - I);
  Resto := (Soma * 10) mod 11;
  if Resto = 10 then Resto := 0;
  Result := Resto = StrToInt(CPF[11]);
end;

function TFieldHelper.IsCNPJ: Boolean;
const
  Pesos1: array[1..12] of Integer = (5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
  Pesos2: array[1..13] of Integer = (6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2);
var
  CNPJ: string;
  I, Soma, Resto: Integer;
begin
  Result := False;
  if IsNull then Exit;
  
  CNPJ := OnlyNumbers;
  if Length(CNPJ) <> 14 then Exit;
  
  // Verifica se todos os dígitos são iguais
  if CNPJ = StringOfChar(CNPJ[1], 14) then Exit;
  
  // Calcula primeiro dígito verificador
  Soma := 0;
  for I := 1 to 12 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos1[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
  if Resto <> StrToInt(CNPJ[13]) then Exit;
  
  // Calcula segundo dígito verificador
  Soma := 0;
  for I := 1 to 13 do
    Soma := Soma + StrToInt(CNPJ[I]) * Pesos2[I];
  Resto := Soma mod 11;
  if Resto < 2 then
    Resto := 0
  else
    Resto := 11 - Resto;
  Result := Resto = StrToInt(CNPJ[14]);
end;

function TFieldHelper.IsPhone: Boolean;
var
  Phone: string;
begin
  if IsNull then Exit(False);
  
  Phone := OnlyNumbers;
  Result := (Length(Phone) = 10) or (Length(Phone) = 11);
end;

function TFieldHelper.IsCEP: Boolean;
var
  CEP: string;
begin
  if IsNull then Exit(False);
  
  CEP := OnlyNumbers;
  Result := Length(CEP) = 8;
end;

function TFieldHelper.MatchesPattern(const APattern: string): Boolean;
begin
  Result := not IsNull and TRegEx.IsMatch(AsString, APattern);
end;

function TFieldHelper.ContainsText(const AText: string; const ACaseSensitive: Boolean): Boolean;
var
  Source, Target: string;
begin
  if IsNull then Exit(False);
  
  Source := AsString;
  Target := AText;
  
  if not ACaseSensitive then
  begin
    Source := Source.ToUpper;
    Target := Target.ToUpper;
  end;
  
  Result := Source.Contains(Target);
end;

function TFieldHelper.StartsWithText(const AText: string; const ACaseSensitive: Boolean): Boolean;
var
  Source, Target: string;
begin
  if IsNull then Exit(False);
  
  Source := AsString;
  Target := AText;
  
  if not ACaseSensitive then
  begin
    Source := Source.ToUpper;
    Target := Target.ToUpper;
  end;
  
  Result := Source.StartsWith(Target);
end;

function TFieldHelper.EndsWithText(const AText: string; const ACaseSensitive: Boolean): Boolean;
var
  Source, Target: string;
begin
  if IsNull then Exit(False);
  
  Source := AsString;
  Target := AText;
  
  if not ACaseSensitive then
  begin
    Source := Source.ToUpper;
    Target := Target.ToUpper;
  end;
  
  Result := Source.EndsWith(Target);
end;

function TFieldHelper.IsInRange(const AMin, AMax: Variant): Boolean;
begin
  if IsNull then Exit(False);
  
  Result := (Value >= AMin) and (Value <= AMax);
end;

function TFieldHelper.IsInList(const AValues: array of Variant): Boolean;
var
  I: Integer;
begin
  if IsNull then Exit(False);
  
  for I := 0 to High(AValues) do
  begin
    if VarSameValue(Value, AValues[I]) then
      Exit(True);
  end;
  Result := False;
end;

function TFieldHelper.Trim: string;
begin
  Result := AsStringDef('').Trim;
end;

function TFieldHelper.TrimLeft: string;
begin
  Result := AsStringDef('').TrimLeft;
end;

function TFieldHelper.TrimRight: string;
begin
  Result := AsStringDef('').TrimRight;
end;

function TFieldHelper.UpperCase: string;
begin
  Result := AsStringDef('').ToUpper;
end;

function TFieldHelper.LowerCase: string;
begin
  Result := AsStringDef('').ToLower;
end;

function TFieldHelper.ProperCase: string;
var
  S: string;
  I: Integer;
  CapitalizeNext: Boolean;
begin
  S := AsStringDef('').ToLower;
  Result := '';
  CapitalizeNext := True;
  
  for I := 1 to Length(S) do
  begin
    if CapitalizeNext and CharInSet(S[I], ['a'..'z']) then
    begin
      Result := Result + UpCase(S[I]);
      CapitalizeNext := False;
    end
    else
    begin
      Result := Result + S[I];
      CapitalizeNext := CharInSet(S[I], [' ', '-', '.', '''']);
    end;
  end;
end;

function TFieldHelper.Reverse: string;
var
  S: string;
  I: Integer;
begin
  S := AsStringDef('');
  Result := '';
  for I := Length(S) downto 1 do
    Result := Result + S[I];
end;

function TFieldHelper.RemoveSpaces: string;
begin
  Result := AsStringDef('').Replace(' ', '');
end;

function TFieldHelper.RemoveAccents: string;
const
  Accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÿÑñ';
  NoAccents = 'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeEeIIIIiiiiUUUUuuuuyNn';
var
  I: Integer;
  S: string;
begin
  S := AsStringDef('');
  Result := S;
  for I := 1 to Length(Accents) do
    Result := Result.Replace(Accents[I], NoAccents[I]);
end;

function TFieldHelper.OnlyNumbers: string;
var
  I: Integer;
  S: string;
begin
  S := AsStringDef('');
  Result := '';
  for I := 1 to Length(S) do
  begin
    if CharInSet(S[I], ['0'..'9']) then
      Result := Result + S[I];
  end;
end;

function TFieldHelper.OnlyLetters: string;
var
  I: Integer;
  S: string;
begin
  S := AsStringDef('');
  Result := '';
  for I := 1 to Length(S) do
  begin
    if CharInSet(S[I], ['A'..'Z', 'a'..'z']) then
      Result := Result + S[I];
  end;
end;

function TFieldHelper.OnlyAlphanumeric: string;
var
  I: Integer;
  S: string;
begin
  S := AsStringDef('');
  Result := '';
  for I := 1 to Length(S) do
  begin
    if CharInSet(S[I], ['A'..'Z', 'a'..'z', '0'..'9']) then
      Result := Result + S[I];
  end;
end;

function TFieldHelper.Left(const ALength: Integer): string;
var
  S: string;
begin
  S := AsStringDef('');
  if ALength >= Length(S) then
    Result := S
  else
    Result := Copy(S, 1, ALength);
end;

function TFieldHelper.Right(const ALength: Integer): string;
var
  S: string;
begin
  S := AsStringDef('');
  if ALength >= Length(S) then
    Result := S
  else
    Result := Copy(S, Length(S) - ALength + 1, ALength);
end;

function TFieldHelper.Mid(const AStart, ALength: Integer): string;
begin
  Result := Copy(AsStringDef(''), AStart, ALength);
end;

function TFieldHelper.PadLeft(const ALength: Integer; const APadChar: Char): string;
var
  S: string;
begin
  S := AsStringDef('');
  while Length(S) < ALength do
    S := APadChar + S;
  Result := S;
end;

function TFieldHelper.PadRight(const ALength: Integer; const APadChar: Char): string;
var
  S: string;
begin
  S := AsStringDef('');
  while Length(S) < ALength do
    S := S + APadChar;
  Result := S;
end;

function TFieldHelper.RepeatText(const ACount: Integer): string;
var
  I: Integer;
  S: string;
begin
  S := AsStringDef('');
  Result := '';
  for I := 1 to ACount do
    Result := Result + S;
end;

function TFieldHelper.Replace(const AOldValue, ANewValue: string; const ACaseSensitive: Boolean): string;
var
  Flags: TReplaceFlags;
begin
  Flags := [rfReplaceAll];
  if not ACaseSensitive then
    Include(Flags, rfIgnoreCase);
  Result := StringReplace(AsStringDef(''), AOldValue, ANewValue, Flags);
end;

function TFieldHelper.WordCount: Integer;
var
  S: string;
  I: Integer;
  InWord: Boolean;
begin
  S := Trim;
  Result := 0;
  InWord := False;
  
  for I := 1 to Length(S) do
  begin
    if CharInSet(S[I], [' ', #9, #10, #13]) then
      InWord := False
    else if not InWord then
    begin
      InWord := True;
      Inc(Result);
    end;
  end;
end;

function TFieldHelper.WordAt(const AIndex: Integer): string;
var
  Words: TArray<string>;
begin
  Words := Trim.Split([' ', #9, #10, #13], TStringSplitOptions.ExcludeEmpty);
  if (AIndex >= 0) and (AIndex < Length(Words)) then
    Result := Words[AIndex]
  else
    Result := '';
end;

function TFieldHelper.LineCount: Integer;
var
  S: string;
begin
  S := AsStringDef('');
  Result := Length(S.Split([#13#10, #10, #13]));
end;

function TFieldHelper.LineAt(const AIndex: Integer): string;
var
  Lines: TArray<string>;
begin
  Lines := AsStringDef('').Split([#13#10, #10, #13]);
  if (AIndex >= 0) and (AIndex < Length(Lines)) then
    Result := Lines[AIndex]
  else
    Result := '';
end;

// Operações matemáticas
function TFieldHelper.Add(const AValue: Double): Double;
begin
  Result := AsFloatDef(0) + AValue;
end;

function TFieldHelper.Subtract(const AValue: Double): Double;
begin
  Result := AsFloatDef(0) - AValue;
end;

function TFieldHelper.Multiply(const AValue: Double): Double;
begin
  Result := AsFloatDef(0) * AValue;
end;

function TFieldHelper.Divide(const AValue: Double): Double;
begin
  if AValue <> 0 then
    Result := AsFloatDef(0) / AValue
  else
    Result := 0;
end;

function TFieldHelper.Power(const AExponent: Double): Double;
begin
  Result := System.Math.Power(AsFloatDef(0), AExponent);
end;

function TFieldHelper.Sqrt: Double;
var
  Value: Double;
begin
  Value := AsFloatDef(0);
  if Value < 0 then
    Result := 0
  else
    Result := System.Sqrt(Value);
end;

function TFieldHelper.Abs: Double;
var
  Value: Double;
begin
  Value := AsFloatDef(0);
  if Value < 0 then
    Result := -Value
  else
    Result := Value;
end;

function TFieldHelper.Round(const ADigits: Integer): Double;
begin
  Result := System.Math.RoundTo(AsFloatDef(0), -ADigits);
end;

function TFieldHelper.Trunc: Int64;
begin
  Result := System.Trunc(AsFloatDef(0));
end;

function TFieldHelper.Ceil: Int64;
begin
  Result := System.Math.Ceil(AsFloatDef(0));
end;

function TFieldHelper.Floor: Int64;
begin
  Result := System.Math.Floor(AsFloatDef(0));
end;

function TFieldHelper.Min(const AValue: Double): Double;
begin
  Result := System.Math.Min(AsFloatDef(0), AValue);
end;

function TFieldHelper.Max(const AValue: Double): Double;
begin
  Result := System.Math.Max(AsFloatDef(0), AValue);
end;

function TFieldHelper.IsPositive: Boolean;
begin
  Result := AsFloatDef(0) > 0;
end;

function TFieldHelper.IsNegative: Boolean;
begin
  Result := AsFloatDef(0) < 0;
end;

function TFieldHelper.IsZero: Boolean;
begin
  Result := AsFloatDef(0) = 0;
end;

function TFieldHelper.IsEven: Boolean;
begin
  Result := (AsIntegerDef(0) mod 2) = 0;
end;

function TFieldHelper.IsOdd: Boolean;
begin
  Result := not IsEven;
end;

// Operações de data/hora
function TFieldHelper.AddYears(const AYears: Integer): TDateTime;
var
  Year, Month, Day: Word;
  FieldDate: TDateTime;
begin
  FieldDate := AsDateTimeDef(Now);
  DecodeDate(FieldDate, Year, Month, Day);
  Year := Year + AYears;
  Result := EncodeDate(Year, Month, Day) + Frac(FieldDate);
end;

function TFieldHelper.AddMonths(const AMonths: Integer): TDateTime;
var
  Year, Month, Day: Word;
  FieldDate: TDateTime;
begin
  FieldDate := AsDateTimeDef(Now);
  DecodeDate(FieldDate, Year, Month, Day);
  Month := Month + AMonths;
  while Month > 12 do
  begin
    Month := Month - 12;
    Year := Year + 1;
  end;
  while Month < 1 do
  begin
    Month := Month + 12;
    Year := Year - 1;
  end;
  Result := EncodeDate(Year, Month, Day) + Frac(FieldDate);
end;

function TFieldHelper.AddDays(const ADays: Integer): TDateTime;
begin
  Result := AsDateTimeDef(Now) + ADays;
end;

function TFieldHelper.AddHours(const AHours: Integer): TDateTime;
begin
  Result := System.DateUtils.IncHour(AsDateTimeDef(Now), AHours);
end;

function TFieldHelper.AddMinutes(const AMinutes: Integer): TDateTime;
begin
  Result := System.DateUtils.IncMinute(AsDateTimeDef(Now), AMinutes);
end;

function TFieldHelper.AddSeconds(const ASeconds: Integer): TDateTime;
begin
  Result := System.DateUtils.IncSecond(AsDateTimeDef(Now), ASeconds);
end;

function TFieldHelper.StartOfYear: TDateTime;
begin
  Result := System.DateUtils.StartOfTheYear(AsDateTimeDef(Now));
end;

function TFieldHelper.EndOfYear: TDateTime;
begin
  Result := System.DateUtils.EndOfTheYear(AsDateTimeDef(Now));
end;

function TFieldHelper.StartOfMonth: TDateTime;
begin
  Result := System.DateUtils.StartOfTheMonth(AsDateTimeDef(Now));
end;

function TFieldHelper.EndOfMonth: TDateTime;
begin
  Result := System.DateUtils.EndOfTheMonth(AsDateTimeDef(Now));
end;

function TFieldHelper.StartOfWeek: TDateTime;
begin
  Result := System.DateUtils.StartOfTheWeek(AsDateTimeDef(Now));
end;

function TFieldHelper.EndOfWeek: TDateTime;
begin
  Result := System.DateUtils.EndOfTheWeek(AsDateTimeDef(Now));
end;

function TFieldHelper.StartOfDay: TDateTime;
begin
  Result := System.DateUtils.StartOfTheDay(AsDateTimeDef(Now));
end;

function TFieldHelper.EndOfDay: TDateTime;
begin
  Result := System.DateUtils.EndOfTheDay(AsDateTimeDef(Now));
end;

function TFieldHelper.YearOf: Word;
begin
  Result := System.DateUtils.YearOf(AsDateTimeDef(Now));
end;

function TFieldHelper.MonthOf: Word;
begin
  Result := System.DateUtils.MonthOf(AsDateTimeDef(Now));
end;

function TFieldHelper.DayOf: Word;
begin
  Result := System.DateUtils.DayOf(AsDateTimeDef(Now));
end;

function TFieldHelper.HourOf: Word;
begin
  Result := System.DateUtils.HourOf(AsDateTimeDef(Now));
end;

function TFieldHelper.MinuteOf: Word;
begin
  Result := System.DateUtils.MinuteOf(AsDateTimeDef(Now));
end;

function TFieldHelper.SecondOf: Word;
begin
  Result := System.DateUtils.SecondOf(AsDateTimeDef(Now));
end;

function TFieldHelper.DayOfWeek: Word;
begin
  Result := System.DateUtils.DayOfTheWeek(AsDateTimeDef(Now));
end;

function TFieldHelper.DayOfYear: Word;
begin
  Result := System.DateUtils.DayOfTheYear(AsDateTimeDef(Now));
end;

function TFieldHelper.WeekOfYear: Word;
begin
  Result := System.DateUtils.WeekOfTheYear(AsDateTimeDef(Now));
end;

function TFieldHelper.QuarterOfYear: Word;
begin
  Result := (MonthOf - 1) div 3 + 1;
end;

function TFieldHelper.IsToday: Boolean;
begin
  Result := System.DateUtils.IsToday(AsDateTimeDef(0));
end;

function TFieldHelper.IsYesterday: Boolean;
var
  FieldDate: TDateTime;
  Yesterday: TDateTime;
begin
  FieldDate := AsDateTimeDef(0);
  Yesterday := Date - 1;
  Result := (FieldDate >= Yesterday) and (FieldDate < Date);
end;

function TFieldHelper.IsTomorrow: Boolean;
var
  FieldDate: TDateTime;
  Tomorrow: TDateTime;
begin
  FieldDate := AsDateTimeDef(0);
  Tomorrow := Date + 1;
  Result := (FieldDate >= Tomorrow) and (FieldDate < Tomorrow + 1);
end;

function TFieldHelper.IsThisWeek: Boolean;
var
  Diff: Double;
begin
  Diff := AsDateTimeDef(0) - Date;
  if Diff < 0 then Diff := -Diff;
  Result := Diff <= 7;
end;

function TFieldHelper.IsThisMonth: Boolean;
var
  FieldDate: TDateTime;
  CurrentYear, CurrentMonth, CurrentDay: Word;
  FieldYear, FieldMonth, FieldDay: Word;
begin
  FieldDate := AsDateTimeDef(0);
  DecodeDate(Date, CurrentYear, CurrentMonth, CurrentDay);
  DecodeDate(FieldDate, FieldYear, FieldMonth, FieldDay);
  Result := (CurrentYear = FieldYear) and (CurrentMonth = FieldMonth);
end;

function TFieldHelper.IsThisYear: Boolean;
var
  FieldDate: TDateTime;
  CurrentYear, CurrentMonth, CurrentDay: Word;
  FieldYear, FieldMonth, FieldDay: Word;
begin
  FieldDate := AsDateTimeDef(0);
  DecodeDate(Date, CurrentYear, CurrentMonth, CurrentDay);
  DecodeDate(FieldDate, FieldYear, FieldMonth, FieldDay);
  Result := CurrentYear = FieldYear;
end;

function TFieldHelper.IsPast: Boolean;
begin
  Result := AsDateTimeDef(0) < Now;
end;

function TFieldHelper.IsFuture: Boolean;
begin
  Result := AsDateTimeDef(0) > Now;
end;

function TFieldHelper.IsWeekend: Boolean;
var
  DayNum: Word;
begin
  DayNum := DayOfWeek;
  Result := (DayNum = 1) or (DayNum = 7); // Domingo = 1, Sábado = 7
end;

function TFieldHelper.IsBusinessDay: Boolean;
begin
  Result := not IsWeekend;
end;

function TFieldHelper.Age: Integer;
begin
  Result := System.DateUtils.YearsBetween(Now, AsDateTimeDef(Now));
end;

function TFieldHelper.DaysUntil(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.DaysBetween(ADate, AsDateTimeDef(Now));
end;

function TFieldHelper.DaysSince(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.DaysBetween(AsDateTimeDef(Now), ADate);
end;

function TFieldHelper.HoursUntil(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.HoursBetween(ADate, AsDateTimeDef(Now));
end;

function TFieldHelper.HoursSince(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.HoursBetween(AsDateTimeDef(Now), ADate);
end;

function TFieldHelper.MinutesUntil(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.MinutesBetween(ADate, AsDateTimeDef(Now));
end;

function TFieldHelper.MinutesSince(const ADate: TDateTime): Integer;
begin
  Result := System.DateUtils.MinutesBetween(AsDateTimeDef(Now), ADate);
end;

function TFieldHelper.ToRelativeString: string;
var
  DT: TDateTime;
  Days, Hours, Minutes: Integer;
begin
  DT := AsDateTimeDef(0);
  
  if IsToday then
    Result := 'Hoje'
  else if IsYesterday then
    Result := 'Ontem'
  else if IsTomorrow then
    Result := 'Amanhã'
  else
  begin
    Days := DaysBetween(Now, DT);
    Hours := HoursBetween(Now, DT);
    Minutes := MinutesBetween(Now, DT);
    
    if DT < Now then
    begin
      if Days > 0 then
        Result := Format('%d dia(s) atrás', [Days])
      else if Hours > 0 then
        Result := Format('%d hora(s) atrás', [Hours])
      else
        Result := Format('%d minuto(s) atrás', [Minutes]);
    end
    else
    begin
      if Days > 0 then
        Result := Format('em %d dia(s)', [Days])
      else if Hours > 0 then
        Result := Format('em %d hora(s)', [Hours])
      else
        Result := Format('em %d minuto(s)', [Minutes]);
    end;
  end;
end;

function TFieldHelper.ToShortDateString: string;
begin
  Result := DateToStr(AsDateTimeDef(0));
end;

function TFieldHelper.ToLongDateString: string;
begin
  Result := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', AsDateTimeDef(0));
end;

function TFieldHelper.ToShortTimeString: string;
begin
  Result := TimeToStr(AsDateTimeDef(0));
end;

function TFieldHelper.ToLongTimeString: string;
begin
  Result := FormatDateTime('hh:nn:ss', AsDateTimeDef(0));
end;

function TFieldHelper.ToISOString: string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', AsDateTimeDef(0));
end;

function TFieldHelper.ToUnixTimestamp: Int64;
begin
  Result := DateTimeToUnix(AsDateTimeDef(0));
end;

function TFieldHelper.FromUnixTimestamp: TDateTime;
begin
  Result := UnixToDateTime(AsInt64Def(0));
end;

// Formatação avançada
function TFieldHelper.FormatCurrency(const ADecimals: Integer): string;
begin
  Result := FormatCurr(',0.' + StringOfChar('0', ADecimals), AsCurrencyDef(0));
end;

function TFieldHelper.FormatPercent(const ADecimals: Integer): string;
begin
  Result := FormatFloat('0.' + StringOfChar('0', ADecimals) + '%', AsFloatDef(0) * 100);
end;

function TFieldHelper.FormatNumber(const ADecimals: Integer): string;
begin
  Result := FormatFloat(',0.' + StringOfChar('0', ADecimals), AsFloatDef(0));
end;

function TFieldHelper.FormatFileSize: string;
var
  Size: Double;
begin
  Size := AsFloatDef(0);
  if Size < 1024 then
    Result := Format('%.0f bytes', [Size])
  else if Size < 1024 * 1024 then
    Result := Format('%.1f KB', [Size / 1024])
  else if Size < 1024 * 1024 * 1024 then
    Result := Format('%.1f MB', [Size / (1024 * 1024)])
  else
    Result := Format('%.1f GB', [Size / (1024 * 1024 * 1024)]);
end;

function TFieldHelper.FormatCPF: string;
var
  CPF: string;
begin
  CPF := OnlyNumbers;
  if Length(CPF) = 11 then
    Result := Format('%s.%s.%s-%s', [
      Copy(CPF, 1, 3),
      Copy(CPF, 4, 3),
      Copy(CPF, 7, 3),
      Copy(CPF, 10, 2)
    ])
  else
    Result := CPF;
end;

function TFieldHelper.FormatCNPJ: string;
var
  CNPJ: string;
begin
  CNPJ := OnlyNumbers;
  if Length(CNPJ) = 14 then
    Result := Format('%s.%s.%s/%s-%s', [
      Copy(CNPJ, 1, 2),
      Copy(CNPJ, 3, 3),
      Copy(CNPJ, 6, 3),
      Copy(CNPJ, 9, 4),
      Copy(CNPJ, 13, 2)
    ])
  else
    Result := CNPJ;
end;

function TFieldHelper.FormatPhone: string;
var
  Phone: string;
begin
  Phone := OnlyNumbers;
  if Length(Phone) = 11 then
    Result := Format('(%s) %s-%s', [
      Copy(Phone, 1, 2),
      Copy(Phone, 3, 5),
      Copy(Phone, 8, 4)
    ])
  else if Length(Phone) = 10 then
    Result := Format('(%s) %s-%s', [
      Copy(Phone, 1, 2),
      Copy(Phone, 3, 4),
      Copy(Phone, 7, 4)
    ])
  else
    Result := Phone;
end;

function TFieldHelper.FormatCEP: string;
var
  CEP: string;
begin
  CEP := OnlyNumbers;
  if Length(CEP) = 8 then
    Result := Format('%s-%s', [Copy(CEP, 1, 5), Copy(CEP, 6, 3)])
  else
    Result := CEP;
end;

// Criptografia e hash
function TFieldHelper.ToMD5: string;
begin
  Result := THashMD5.GetHashString(AsStringDef(''));
end;

function TFieldHelper.ToSHA1: string;
begin
  Result := THashSHA1.GetHashString(AsStringDef(''));
end;

function TFieldHelper.ToSHA256: string;
begin
  Result := THashSHA2.GetHashString(AsStringDef(''));
end;

function TFieldHelper.ToBase64: string;
begin
  Result := TNetEncoding.Base64.Encode(AsStringDef(''));
end;

function TFieldHelper.FromBase64: string;
begin
  try
    Result := TNetEncoding.Base64.Decode(AsStringDef(''));
  except
    Result := '';
  end;
end;

function TFieldHelper.Encrypt(const AKey: string): string;
begin
  // Implementação simples - em produção usar algoritmos mais seguros
  Result := ToBase64;
end;

function TFieldHelper.Decrypt(const AKey: string): string;
begin
  // Implementação simples - em produção usar algoritmos mais seguros
  Result := FromBase64;
end;

// Utilitários de comparação
function TFieldHelper.EqualsTo(const AValue: Variant; const ACaseSensitive: Boolean): Boolean;
var
  V1, V2: string;
begin
  if IsNull and VarIsNull(AValue) then
    Exit(True);
  if IsNull or VarIsNull(AValue) then
    Exit(False);
    
  if ACaseSensitive then
    Result := VarSameValue(Value, AValue)
  else
  begin
    V1 := VarToStr(Value).ToUpper;
    V2 := VarToStr(AValue).ToUpper;
    Result := V1 = V2;
  end;
end;

function TFieldHelper.GreaterThan(const AValue: Variant): Boolean;
begin
  Result := not IsNull and not VarIsNull(AValue) and (Value > AValue);
end;

function TFieldHelper.LessThan(const AValue: Variant): Boolean;
begin
  Result := not IsNull and not VarIsNull(AValue) and (Value < AValue);
end;

function TFieldHelper.Between(const AMin, AMax: Variant): Boolean;
begin
  Result := not IsNull and (Value >= AMin) and (Value <= AMax);
end;

function TFieldHelper.IsOneOf(const AValues: array of Variant): Boolean;
begin
  Result := IsInList(AValues);
end;

// Informações sobre o campo
function TFieldHelper.DataTypeName: string;
begin
  case DataType of
    ftUnknown: Result := 'ftUnknown';
    ftString: Result := 'ftString';
    ftSmallint: Result := 'ftSmallint';
    ftInteger: Result := 'ftInteger';
    ftWord: Result := 'ftWord';
    ftBoolean: Result := 'ftBoolean';
    ftFloat: Result := 'ftFloat';
    ftCurrency: Result := 'ftCurrency';
    ftBCD: Result := 'ftBCD';
    ftDate: Result := 'ftDate';
    ftTime: Result := 'ftTime';
    ftDateTime: Result := 'ftDateTime';
    ftBytes: Result := 'ftBytes';
    ftVarBytes: Result := 'ftVarBytes';
    ftAutoInc: Result := 'ftAutoInc';
    ftBlob: Result := 'ftBlob';
    ftMemo: Result := 'ftMemo';
    ftGraphic: Result := 'ftGraphic';
    ftFmtMemo: Result := 'ftFmtMemo';
    ftParadoxOle: Result := 'ftParadoxOle';
    ftDBaseOle: Result := 'ftDBaseOle';
    ftTypedBinary: Result := 'ftTypedBinary';
    ftCursor: Result := 'ftCursor';
    ftFixedChar: Result := 'ftFixedChar';
    ftWideString: Result := 'ftWideString';
    ftLargeint: Result := 'ftLargeint';
    ftADT: Result := 'ftADT';
    ftArray: Result := 'ftArray';
    ftReference: Result := 'ftReference';
    ftDataSet: Result := 'ftDataSet';
    ftOraBlob: Result := 'ftOraBlob';
    ftOraClob: Result := 'ftOraClob';
    ftVariant: Result := 'ftVariant';
    ftInterface: Result := 'ftInterface';
    ftIDispatch: Result := 'ftIDispatch';
    ftGuid: Result := 'ftGuid';
    ftTimeStamp: Result := 'ftTimeStamp';
    ftFMTBcd: Result := 'ftFMTBcd';
    ftFixedWideChar: Result := 'ftFixedWideChar';
    ftWideMemo: Result := 'ftWideMemo';
    ftOraTimeStamp: Result := 'ftOraTimeStamp';
    ftOraInterval: Result := 'ftOraInterval';
    ftLongWord: Result := 'ftLongWord';
    ftShortint: Result := 'ftShortint';
    ftByte: Result := 'ftByte';
    ftConnection: Result := 'ftConnection';
    ftParams: Result := 'ftParams';
    ftStream: Result := 'ftStream';
    ftTimeStampOffset: Result := 'ftTimeStampOffset';
    ftObject: Result := 'ftObject';
  else
    Result := 'Unknown';
  end;
end;

function TFieldHelper.FieldInfo: string;
begin
  Result := Format('Field: %s, Type: %s, Size: %d, Required: %s, ReadOnly: %s', [
    FieldName,
    DataTypeName,
    Size,
    BoolToStr(Required, True),
    BoolToStr(ReadOnly, True)
  ]);
end;

function TFieldHelper.MaxLength: Integer;
begin
  Result := Size;
end;

function TFieldHelper.IsRequired: Boolean;
begin
  Result := Required;
end;

function TFieldHelper.IsReadOnly: Boolean;
begin
  Result := ReadOnly;
end;

function TFieldHelper.IsVisible: Boolean;
begin
  Result := Visible;
end;

function TFieldHelper.IsKey: Boolean;
begin
  Result := pfInKey in ProviderFlags;
end;

function TFieldHelper.IsAutoIncrement: Boolean;
begin
  Result := AutoGenerateValue <> arNone;
end;

function TFieldHelper.IsCalculated: Boolean;
begin
  Result := Calculated;
end;

function TFieldHelper.IsLookup: Boolean;
begin
  Result := Lookup;
end;

function TFieldHelper.IsBLOB: Boolean;
begin
  Result := DataType in [ftBlob, ftMemo, ftGraphic, ftFmtMemo, ftParadoxOle, 
                        ftDBaseOle, ftTypedBinary, ftOraBlob, ftOraClob,
                        ftWideMemo];
end;

function TFieldHelper.IsMemo: Boolean;
begin
  Result := DataType in [ftMemo, ftFmtMemo, ftWideMemo];
end;

function TFieldHelper.GetConstraints: TStringList;
begin
  Result := TStringList.Create;
  
  if Required then
    Result.Add('NOT NULL');
  if ReadOnly then
    Result.Add('READ ONLY');
  if IsKey then
    Result.Add('PRIMARY KEY');
  if IsAutoIncrement then
    Result.Add('AUTO INCREMENT');
  if Calculated then
    Result.Add('CALCULATED');
  if Lookup then
    Result.Add('LOOKUP');
end;

// Operações de conjunto (métodos de classe)
class function TFieldHelper.SumFields(const AFields: array of TField): Double;
var
  I: Integer;
  Total: Double;
begin
  Total := 0;
  for I := 0 to High(AFields) do
  begin
    if not AFields[I].IsNull then
      Total := Total + AFields[I].AsFloat;
  end;
  Result := Total;
end;

class function TFieldHelper.AverageFields(const AFields: array of TField): Double;
var
  Count: Integer;
begin
  Count := CountNonNull(AFields);
  if Count > 0 then
    Result := SumFields(AFields) / Count
  else
    Result := 0;
end;

class function TFieldHelper.MinField(const AFields: array of TField): Variant;
var
  I: Integer;
  MinValue: Variant;
begin
  MinValue := Null;
  for I := 0 to High(AFields) do
  begin
    if not AFields[I].IsNull then
    begin
      if VarIsNull(MinValue) or (AFields[I].Value < MinValue) then
        MinValue := AFields[I].Value;
    end;
  end;
  Result := MinValue;
end;

class function TFieldHelper.MaxField(const AFields: array of TField): Variant;
var
  I: Integer;
  MaxValue: Variant;
begin
  MaxValue := Null;
  for I := 0 to High(AFields) do
  begin
    if not AFields[I].IsNull then
    begin
      if VarIsNull(MaxValue) or (AFields[I].Value > MaxValue) then
        MaxValue := AFields[I].Value;
    end;
  end;
  Result := MaxValue;
end;

class function TFieldHelper.ConcatFields(const AFields: array of TField; const ASeparator: string): string;
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    for I := 0 to High(AFields) do
    begin
      if not AFields[I].IsNull then
        Values.Add(AFields[I].AsString);
    end;
    Result := String.Join(ASeparator, Values.ToStringArray);
  finally
    Values.Free;
  end;
end;

class function TFieldHelper.CountNonNull(const AFields: array of TField): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(AFields) do
  begin
    if not AFields[I].IsNull then
      Inc(Result);
  end;
end;

class function TFieldHelper.CountNull(const AFields: array of TField): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to High(AFields) do
  begin
    if AFields[I].IsNull then
      Inc(Result);
  end;
end;

class function TFieldHelper.AllFieldsNull(const AFields: array of TField): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(AFields) do
  begin
    if not AFields[I].IsNull then
      Exit(False);
  end;
  Result := True;
end;

class function TFieldHelper.AnyFieldNull(const AFields: array of TField): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(AFields) do
  begin
    if AFields[I].IsNull then
      Exit(True);
  end;
  Result := False;
end;

class function TFieldHelper.AllFieldsEqual(const AFields: array of TField): Boolean;
var
  I: Integer;
  FirstValue: Variant;
begin
  if Length(AFields) <= 1 then
    Exit(True);
    
  FirstValue := AFields[0].Value;
  for I := 1 to High(AFields) do
  begin
    if not VarSameValue(AFields[I].Value, FirstValue) then
      Exit(False);
  end;
  Result := True;
end;

end.
