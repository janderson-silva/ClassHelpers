unit IntegerHelperSimple;

interface

uses
  System.SysUtils;

type
  // Helper simples para Integer
  TIntegerHelper = record helper for Integer
  public
    // Conversões básicas
    function ToString: string;
    function ToHex: string;
    function ToBinary: string;
    
    // Verificações
    function IsEven: Boolean;
    function IsOdd: Boolean;
    function IsPositive: Boolean;
    function IsNegative: Boolean;
    function IsZero: Boolean;
    
    // Operações matemáticas básicas
    function Abs: Integer;
    function Sign: Integer;
    function Power(const AExponent: Integer): Int64;
    
    // Ranges e loops
    function UpTo(const AMax: Integer): TArray<Integer>;
    function DownToArray(const AMin: Integer): TArray<Integer>;
    procedure Times(const AProc: TProc<Integer>);
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

function TIntegerHelper.IsEven: Boolean;
begin
  Result := Self mod 2 = 0;
end;

function TIntegerHelper.IsOdd: Boolean;
begin
  Result := Self mod 2 <> 0;
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

function TIntegerHelper.Abs: Integer;
begin
  if Self < 0 then
    Result := -Self
  else
    Result := Self;
end;

function TIntegerHelper.Sign: Integer;
begin
  if Self > 0 then
    Result := 1
  else if Self < 0 then
    Result := -1
  else
    Result := 0;
end;

function TIntegerHelper.Power(const AExponent: Integer): Int64;
var
  I: Integer;
begin
  Result := 1;
  for I := 1 to AExponent do
    Result := Result * Self;
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

procedure TIntegerHelper.Times(const AProc: TProc<Integer>);
var
  I: Integer;
begin
  for I := 0 to Self - 1 do
    AProc(I);
end;

end.
