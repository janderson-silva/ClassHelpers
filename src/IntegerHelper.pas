unit IntegerHelper;

interface

uses
  System.SysUtils, System.Math;

type
  // Helper para Integer
  TIntegerHelper = record helper for Integer
  public
    // Conversões
    function ToString: string;
    function ToHex: string;
    function ToBinary: string;
    function ToOctal: string;
    function ToRoman: string;
    function ToOrdinal: string; // 1st, 2nd, 3rd, 4th...
    function ToWords: string; // "vinte e três"
    function ToCurrency: string;
    function ToBytes: string; // "1.5 KB", "2.3 MB", etc.
    
    // Matemática
    function IsEven: Boolean;
    function IsOdd: Boolean;
    function IsPrime: Boolean;
    function IsPositive: Boolean;
    function IsNegative: Boolean;
    function IsZero: Boolean;
    function Factorial: Int64;
    function Power(const AExponent: Integer): Int64;
    function Sqrt: Double;
    function Abs: Integer;
    function Sign: Integer; // -1, 0, ou 1
    function Gcd(const AOther: Integer): Integer; // Máximo Divisor Comum
    function Lcm(const AOther: Integer): Integer; // Mínimo Múltiplo Comum
    
    // Validações e limites
    function IsBetween(const AMin, AMax: Integer): Boolean;
    function Clamp(const AMin, AMax: Integer): Integer;
    function IsMultipleOf(const ADivisor: Integer): Boolean;
    function IsPowerOf(const ABase: Integer): Boolean;
    
    // Manipulação de dígitos
    function DigitCount: Integer;
    function DigitSum: Integer;
    function ReverseDigits: Integer;
    function GetDigit(const APosition: Integer): Integer; // 0-based da direita
    
    // Loops e repetições
    procedure Times(const AProc: TProc); overload;
    procedure Times(const AProc: TProc<Integer>); overload;
    function UpTo(const AMax: Integer): TArray<Integer>;
    function DownToArray(const AMin: Integer): TArray<Integer>;
    
    // Geradores
    class function Random(const AMax: Integer): Integer; overload; static;
    class function Random(const AMin, AMax: Integer): Integer; overload; static;
    class function RandomArray(const ACount, AMax: Integer): TArray<Integer>; static;
  end;

implementation

{ TIntegerHelper }

function TIntegerHelper.ToString: string;
begin
  Result := IntToStr(Self);
end;

function TIntegerHelper.ToHex: string;
begin
  Result := IntToHex(Self, 8);
end;

function TIntegerHelper.ToBinary: string;
var
  Value: Integer;
begin
  Result := '';
  Value := Self.Abs;
  if Value = 0 then
    Result := '0'
  else
  begin
    while Value > 0 do
    begin
      Result := IntToStr(Value mod 2) + Result;
      Value := Value div 2;
    end;
  end;
  if Self < 0 then
    Result := '-' + Result;
end;

function TIntegerHelper.ToOctal: string;
var
  Value: Integer;
begin
  Result := '';
  Value := Self.Abs;
  if Value = 0 then
    Result := '0'
  else
  begin
    while Value > 0 do
    begin
      Result := IntToStr(Value mod 8) + Result;
      Value := Value div 8;
    end;
  end;
  if Self < 0 then
    Result := '-' + Result;
end;

function TIntegerHelper.ToRoman: string;
const
  Numbers: array[0..12] of Integer = (1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1);
  Numerals: array[0..12] of string = ('M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I');
var
  I, Value: Integer;
begin
  Result := '';
  Value := Self;
  if (Value <= 0) or (Value > 3999) then
    Exit;
    
  for I := 0 to High(Numbers) do
  begin
    while Value >= Numbers[I] do
    begin
      Result := Result + Numerals[I];
      Value := Value - Numbers[I];
    end;
  end;
end;

function TIntegerHelper.ToOrdinal: string;
var
  LastDigit, LastTwoDigits: Integer;
begin
  LastDigit := Self mod 10;
  LastTwoDigits := Self mod 100;
  
  if (LastTwoDigits >= 11) and (LastTwoDigits <= 13) then
    Result := IntToStr(Self) + 'th'
  else
    case LastDigit of
      1: Result := IntToStr(Self) + 'st';
      2: Result := IntToStr(Self) + 'nd';
      3: Result := IntToStr(Self) + 'rd';
    else
      Result := IntToStr(Self) + 'th';
    end;
end;

function TIntegerHelper.ToWords: string;
const
  Ones: array[0..19] of string = ('zero', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove',
    'dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis', 'dezessete', 'dezoito', 'dezenove');
  Tens: array[2..9] of string = ('vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta', 'setenta', 'oitenta', 'noventa');
  Hundreds: array[1..9] of string = ('cento', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos', 'seiscentos', 'setecentos', 'oitocentos', 'novecentos');
var
  Value: Integer;
  
  function ConvertHundreds(AValue: Integer): string;
  var
    H, T, O: Integer;
  begin
    Result := '';
    H := AValue div 100;
    T := (AValue mod 100) div 10;
    O := AValue mod 10;
    
    if H > 0 then
    begin
      if AValue = 100 then
        Result := 'cem'
      else
        Result := Hundreds[H];
    end;
    
    if T >= 2 then
    begin
      if Result <> '' then Result := Result + ' e ';
      Result := Result + Tens[T];
      if O > 0 then
        Result := Result + ' e ' + Ones[O];
    end
    else if (T = 1) or (O > 0) then
    begin
      if Result <> '' then Result := Result + ' e ';
      Result := Result + Ones[T * 10 + O];
    end;
  end;
  
begin
  Value := Self;
  if Value = 0 then
  begin
    Result := 'zero';
    Exit;
  end;
  
  if Value < 0 then
  begin
    Result := 'menos ';
    Value := -Value;
  end;
  
  if Value < 1000 then
    Result := Result + ConvertHundreds(Value)
  else if Value < 1000000 then
  begin
    Result := Result + ConvertHundreds(Value div 1000) + ' mil';
    if Value mod 1000 > 0 then
      Result := Result + ' ' + ConvertHundreds(Value mod 1000);
  end
  else
    Result := IntToStr(Self); // Simplificado para números maiores
end;

function TIntegerHelper.ToCurrency: string;
begin
  Result := FormatFloat('#,##0.00', Self / 100);
end;

function TIntegerHelper.ToBytes: string;
const
  Units: array[0..8] of string = ('B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB');
var
  Value: Double;
  UnitIndex: Integer;
begin
  Value := Self;
  UnitIndex := 0;
  
  while (Value >= 1024) and (UnitIndex < High(Units)) do
  begin
    Value := Value / 1024;
    Inc(UnitIndex);
  end;
  
  if UnitIndex = 0 then
    Result := Format('%.0f %s', [Value, Units[UnitIndex]])
  else
    Result := Format('%.1f %s', [Value, Units[UnitIndex]]);
end;

function TIntegerHelper.IsEven: Boolean;
begin
  Result := (Self mod 2) = 0;
end;

function TIntegerHelper.IsOdd: Boolean;
begin
  Result := (Self mod 2) <> 0;
end;

function TIntegerHelper.IsPrime: Boolean;
var
  I: Integer;
begin
  if Self < 2 then
    Exit(False);
  if Self = 2 then
    Exit(True);
  if Self.IsEven then
    Exit(False);
    
  for I := 3 to Trunc(System.Sqrt(Self)) do
  begin
    if (I mod 2 = 1) and (Self mod I = 0) then
      Exit(False);
  end;
  Result := True;
end;

function TIntegerHelper.IsPositive: Boolean;
begin
  Result := Self > 0;
end;

function TIntegerHelper.IsNegative: Boolean;
begin
  Result := Self < 0;
end;

function TIntegerHelper.IsZero: Boolean;
begin
  Result := Self = 0;
end;

function TIntegerHelper.Factorial: Int64;
var
  I: Integer;
begin
  if Self < 0 then
    raise Exception.Create('Factorial não definido para números negativos');
  Result := 1;
  for I := 2 to Self do
    Result := Result * I;
end;

function TIntegerHelper.Power(const AExponent: Integer): Int64;
begin
  Result := Round(System.Math.Power(Self, AExponent));
end;

function TIntegerHelper.Sqrt: Double;
begin
  Result := System.Sqrt(Self);
end;

function TIntegerHelper.Abs: Integer;
begin
  if Self < 0 then
    Result := -Self
  else
    Result := Self;
end;

function TIntegerHelper.Sign: Integer;
begin
  Result := System.Math.Sign(Self);
end;

function TIntegerHelper.Gcd(const AOther: Integer): Integer;
var
  A, B, Temp: Integer;
begin
  A := Self.Abs;
  if AOther < 0 then
    B := -AOther
  else
    B := AOther;
  while B <> 0 do
  begin
    Temp := B;
    B := A mod B;
    A := Temp;
  end;
  Result := A;
end;

function TIntegerHelper.Lcm(const AOther: Integer): Integer;
var
  Product: Integer;
begin
  Product := Self * AOther;
  if Product < 0 then
    Product := -Product;
  Result := Product div Gcd(AOther);
end;

function TIntegerHelper.IsBetween(const AMin, AMax: Integer): Boolean;
begin
  Result := (Self >= AMin) and (Self <= AMax);
end;

function TIntegerHelper.Clamp(const AMin, AMax: Integer): Integer;
begin
  if Self < AMin then
    Result := AMin
  else if Self > AMax then
    Result := AMax
  else
    Result := Self;
end;

function TIntegerHelper.IsMultipleOf(const ADivisor: Integer): Boolean;
begin
  Result := (ADivisor <> 0) and (Self mod ADivisor = 0);
end;

function TIntegerHelper.IsPowerOf(const ABase: Integer): Boolean;
var
  Value: Integer;
begin
  if (ABase <= 1) or (Self <= 0) then
    Exit(False);
  Value := Self;
  while Value > 1 do
  begin
    if Value mod ABase <> 0 then
      Exit(False);
    Value := Value div ABase;
  end;
  Result := True;
end;

function TIntegerHelper.DigitCount: Integer;
begin
  Result := Length(IntToStr(Self.Abs));
end;

function TIntegerHelper.DigitSum: Integer;
var
  Value: Integer;
begin
  Result := 0;
  Value := Self.Abs;
  while Value > 0 do
  begin
    Result := Result + (Value mod 10);
    Value := Value div 10;
  end;
end;

function TIntegerHelper.ReverseDigits: Integer;
var
  Value: Integer;
  IsNegative: Boolean;
begin
  Result := 0;
  IsNegative := Self < 0;
  Value := Self.Abs;
  
  while Value > 0 do
  begin
    Result := Result * 10 + (Value mod 10);
    Value := Value div 10;
  end;
  
  if IsNegative then
    Result := -Result;
end;

function TIntegerHelper.GetDigit(const APosition: Integer): Integer;
var
  Value: Integer;
  I: Integer;
begin
  Result := 0;
  Value := Self.Abs;
  for I := 0 to APosition do
  begin
    Result := Value mod 10;
    Value := Value div 10;
  end;
end;

procedure TIntegerHelper.Times(const AProc: TProc);
var
  I: Integer;
begin
  for I := 1 to Self do
    AProc();
end;

procedure TIntegerHelper.Times(const AProc: TProc<Integer>);
var
  I: Integer;
begin
  for I := 1 to Self do
    AProc(I);
end;

function TIntegerHelper.UpTo(const AMax: Integer): TArray<Integer>;
var
  I, Count: Integer;
begin
  Count := AMax - Self + 1;
  if Count <= 0 then
    Exit(nil);
  SetLength(Result, Count);
  for I := 0 to Count - 1 do
    Result[I] := Self + I;
end;

function TIntegerHelper.DownToArray(const AMin: Integer): TArray<Integer>;
var
  I, Count: Integer;
begin
  Count := Self - AMin + 1;
  if Count <= 0 then
    Exit(nil);
  SetLength(Result, Count);
  for I := 0 to Count - 1 do
    Result[I] := Self - I;
end;

class function TIntegerHelper.Random(const AMax: Integer): Integer;
begin
  Result := System.Random(AMax);
end;

class function TIntegerHelper.Random(const AMin, AMax: Integer): Integer;
begin
  Result := AMin + System.Random(AMax - AMin + 1);
end;

class function TIntegerHelper.RandomArray(const ACount, AMax: Integer): TArray<Integer>;
var
  I: Integer;
begin
  SetLength(Result, ACount);
  for I := 0 to ACount - 1 do
    Result[I] := System.Random(AMax);
end;

end.
