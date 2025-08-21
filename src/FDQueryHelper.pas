unit FDQueryHelper;

interface

uses
  System.SysUtils, System.Variants, System.Classes, System.JSON, System.Generics.Collections,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, System.DateUtils;

type
  // Helper para TFDQuery
  TFDQueryHelper = class helper for TFDQuery
  public
    // Execução rápida
    function ExecSQL(const ASQL: string): Integer; overload;
    function ExecSQL(const ASQL: string; const AParams: array of Variant): Integer; overload;
    function OpenSQL(const ASQL: string): TFDQuery; overload;
    function OpenSQL(const ASQL: string; const AParams: array of Variant): TFDQuery; overload;
    
    // Verificações rápidas
    function IsEmpty: Boolean;
    function IsNotEmpty: Boolean;
    function HasRecords: Boolean;
    function RecordCount: Integer;
    function IsEOF: Boolean;
    function IsBOF: Boolean;
    
    // Navegação fluente
    function FirstRecord: TFDQuery;
    function LastRecord: TFDQuery;
    function NextRecord: TFDQuery;
    function PriorRecord: TFDQuery;
    function GotoRecord(const ARecNo: Integer): TFDQuery;
    
    // Valores de campo com fallback
    function FieldValueDef(const AFieldName: string; const ADefault: Variant): Variant;
    function StringValue(const AFieldName: string; const ADefault: string = ''): string;
    function IntValue(const AFieldName: string; const ADefault: Integer = 0): Integer;
    function Int64Value(const AFieldName: string; const ADefault: Int64 = 0): Int64;
    function FloatValue(const AFieldName: string; const ADefault: Double = 0.0): Double;
    function CurrencyValue(const AFieldName: string; const ADefault: Currency = 0): Currency;
    function BoolValue(const AFieldName: string; const ADefault: Boolean = False): Boolean;
    function DateTimeValue(const AFieldName: string; const ADefault: TDateTime = 0): TDateTime;
    function DateValue(const AFieldName: string; const ADefault: TDate = 0): TDate;
    function TimeValue(const AFieldName: string; const ADefault: TTime = 0): TTime;
    
    // Parâmetros fluentes
    function SetParam(const AParamName: string; const AValue: Variant): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: string): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: Integer): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: Int64): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: Double): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: Currency): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: Boolean): TFDQuery; overload;
    function SetParam(const AParamName: string; const AValue: TDateTime): TFDQuery; overload;
    function SetParamNull(const AParamName: string): TFDQuery;
    function SetParams(const AParams: array of Variant): TFDQuery;
    function ClearParams: TFDQuery;
    
    // Conversões
    function ToJSON: string; overload;
    function ToJSON(const AFields: array of string): string; overload;
    function ToJSONArray: string; overload;
    function ToJSONArray(const AFields: array of string): string; overload;
    function ToCSV: string; overload;
    function ToCSV(const ASeparator: string; const AIncludeHeader: Boolean = True): string; overload;
    function ToStringList: TStringList;
    function ToArray: TArray<TArray<Variant>>;
    function ToDictionary: TDictionary<string, Variant>;
    function ToArrayOfDictionaries: TArray<TDictionary<string, Variant>>;
    
    // Operações em lote
    function ForEach(const AAction: TProc<TFDQuery>): TFDQuery;
    function ForEachRecord(const AAction: TProc<TFDQuery, Integer>): TFDQuery;
    function Where(const APredicate: TFunc<TFDQuery, Boolean>): TFDQuery;
    function Select(const ASelector: TFunc<TFDQuery, Variant>): TArray<Variant>;
    function Sum(const AFieldName: string): Double;
    function Count: Integer; overload;
    function Count(const ACondition: TFunc<TFDQuery, Boolean>): Integer; overload;
    function Min(const AFieldName: string): Variant;
    function Max(const AFieldName: string): Variant;
    function Average(const AFieldName: string): Double;
    
    // Localização
    function FindRecord(const AFieldName: string; const AValue: Variant): Boolean; overload;
    function FindRecord(const ACondition: TFunc<TFDQuery, Boolean>): Boolean; overload;
    function LocateRecord(const AKeyFields: string; const AKeyValues: Variant): Boolean;
    
    // Cloning e backup
    function CloneQuery: TFDQuery;
    function CloneStructure: TFDQuery;
    function Backup: TFDQuery;
    function Restore(const ABackup: TFDQuery): TFDQuery;
    
    // Utilitários
    function GetFieldNames: TArray<string>;
    function GetFieldTypes: TArray<TFieldType>;
    function GetFieldInfo: TDictionary<string, TFieldType>;
    function HasField(const AFieldName: string): Boolean;
    function GetSQL: string;
    function SetSQL(const ASQL: string): TFDQuery;
    function AppendSQL(const ASQL: string): TFDQuery;
    
    // Transações fluentes
    function BeginTransaction: TFDQuery;
    function CommitTransaction: TFDQuery;
    function RollbackTransaction: TFDQuery;
    function InTransaction(const AAction: TProc<TFDQuery>): TFDQuery;
    
    // Debugging
    function DebugSQL: string;
    function DebugParams: string;
    function DebugInfo: string;
    function SaveToFile(const AFileName: string): TFDQuery;
    function LoadFromFile(const AFileName: string): TFDQuery;
  end;

implementation

{ TFDQueryHelper }

function TFDQueryHelper.ExecSQL(const ASQL: string): Integer;
begin
  SQL.Text := ASQL;
  ExecSQL;
  Result := RowsAffected;
end;

function TFDQueryHelper.ExecSQL(const ASQL: string; const AParams: array of Variant): Integer;
var
  I: Integer;
begin
  SQL.Text := ASQL;
  for I := 0 to High(AParams) do
    Params[I].Value := AParams[I];
  ExecSQL;
  Result := RowsAffected;
end;

function TFDQueryHelper.OpenSQL(const ASQL: string): TFDQuery;
begin
  Close;
  SQL.Text := ASQL;
  Open;
  Result := Self;
end;

function TFDQueryHelper.OpenSQL(const ASQL: string; const AParams: array of Variant): TFDQuery;
var
  I: Integer;
begin
  Close;
  SQL.Text := ASQL;
  for I := 0 to High(AParams) do
    Params[I].Value := AParams[I];
  Open;
  Result := Self;
end;

function TFDQueryHelper.IsEmpty: Boolean;
begin
  Result := EOF and BOF;
end;

function TFDQueryHelper.IsNotEmpty: Boolean;
begin
  Result := not IsEmpty;
end;

function TFDQueryHelper.HasRecords: Boolean;
begin
  Result := IsNotEmpty;
end;

function TFDQueryHelper.RecordCount: Integer;
begin
  if Active then
    Result := inherited RecordCount
  else
    Result := 0;
end;

function TFDQueryHelper.IsEOF: Boolean;
begin
  Result := EOF;
end;

function TFDQueryHelper.IsBOF: Boolean;
begin
  Result := BOF;
end;

function TFDQueryHelper.FirstRecord: TFDQuery;
begin
  First;
  Result := Self;
end;

function TFDQueryHelper.LastRecord: TFDQuery;
begin
  Last;
  Result := Self;
end;

function TFDQueryHelper.NextRecord: TFDQuery;
begin
  Next;
  Result := Self;
end;

function TFDQueryHelper.PriorRecord: TFDQuery;
begin
  Prior;
  Result := Self;
end;

function TFDQueryHelper.GotoRecord(const ARecNo: Integer): TFDQuery;
begin
  if (ARecNo >= 1) and (ARecNo <= RecordCount) then
    RecNo := ARecNo;
  Result := Self;
end;

function TFDQueryHelper.FieldValueDef(const AFieldName: string; const ADefault: Variant): Variant;
begin
  if HasField(AFieldName) and not FieldByName(AFieldName).IsNull then
    Result := FieldByName(AFieldName).Value
  else
    Result := ADefault;
end;

function TFDQueryHelper.StringValue(const AFieldName: string; const ADefault: string): string;
begin
  try
    Result := VarToStr(FieldValueDef(AFieldName, ADefault));
    if Result = '' then
      Result := ADefault;
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.IntValue(const AFieldName: string; const ADefault: Integer): Integer;
begin
  try
    Result := FieldValueDef(AFieldName, ADefault);
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.Int64Value(const AFieldName: string; const ADefault: Int64): Int64;
begin
  try
    Result := FieldValueDef(AFieldName, ADefault);
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.FloatValue(const AFieldName: string; const ADefault: Double): Double;
begin
  try
    Result := FieldValueDef(AFieldName, ADefault);
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.CurrencyValue(const AFieldName: string; const ADefault: Currency): Currency;
begin
  try
    Result := FieldValueDef(AFieldName, ADefault);
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.BoolValue(const AFieldName: string; const ADefault: Boolean): Boolean;
begin
  try
    Result := FieldValueDef(AFieldName, ADefault);
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.DateTimeValue(const AFieldName: string; const ADefault: TDateTime): TDateTime;
begin
  try
    Result := VarToDateTime(FieldValueDef(AFieldName, ADefault));
  except
    Result := ADefault;
  end;
end;

function TFDQueryHelper.DateValue(const AFieldName: string; const ADefault: TDate): TDate;
begin
  Result := DateOf(DateTimeValue(AFieldName, ADefault));
end;

function TFDQueryHelper.TimeValue(const AFieldName: string; const ADefault: TTime): TTime;
begin
  Result := TimeOf(DateTimeValue(AFieldName, ADefault));
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Variant): TFDQuery;
begin
  ParamByName(AParamName).Value := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: string): TFDQuery;
begin
  ParamByName(AParamName).AsString := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Integer): TFDQuery;
begin
  ParamByName(AParamName).AsInteger := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Int64): TFDQuery;
begin
  ParamByName(AParamName).AsLargeInt := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Double): TFDQuery;
begin
  ParamByName(AParamName).AsFloat := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Currency): TFDQuery;
begin
  ParamByName(AParamName).AsCurrency := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: Boolean): TFDQuery;
begin
  ParamByName(AParamName).AsBoolean := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParam(const AParamName: string; const AValue: TDateTime): TFDQuery;
begin
  ParamByName(AParamName).AsDateTime := AValue;
  Result := Self;
end;

function TFDQueryHelper.SetParamNull(const AParamName: string): TFDQuery;
begin
  ParamByName(AParamName).Clear;
  Result := Self;
end;

function TFDQueryHelper.SetParams(const AParams: array of Variant): TFDQuery;
var
  I: Integer;
begin
  for I := 0 to High(AParams) do
    Params[I].Value := AParams[I];
  Result := Self;
end;

function TFDQueryHelper.ClearParams: TFDQuery;
begin
  Params.Clear;
  Result := Self;
end;

function TFDQueryHelper.ToJSON: string;
var
  JSONObj: TJSONObject;
  I: Integer;
begin
  if IsEmpty then
    Exit('{}');
    
  JSONObj := TJSONObject.Create;
  try
    for I := 0 to FieldCount - 1 do
    begin
      if Fields[I].IsNull then
        JSONObj.AddPair(Fields[I].FieldName, TJSONNull.Create)
      else
        case Fields[I].DataType of
          ftString, ftMemo, ftWideString, ftWideMemo:
            JSONObj.AddPair(Fields[I].FieldName, Fields[I].AsString);
          ftInteger, ftSmallint, ftWord, ftLargeint:
            JSONObj.AddPair(Fields[I].FieldName, TJSONNumber.Create(Fields[I].AsInteger));
          ftFloat, ftCurrency, ftBCD, ftFMTBcd:
            JSONObj.AddPair(Fields[I].FieldName, TJSONNumber.Create(Fields[I].AsFloat));
          ftBoolean:
            JSONObj.AddPair(Fields[I].FieldName, TJSONBool.Create(Fields[I].AsBoolean));
          ftDate, ftTime, ftDateTime, ftTimeStamp:
            JSONObj.AddPair(Fields[I].FieldName, DateTimeToStr(Fields[I].AsDateTime));
        else
          JSONObj.AddPair(Fields[I].FieldName, Fields[I].AsString);
        end;
    end;
    Result := JSONObj.ToString;
  finally
    JSONObj.Free;
  end;
end;

function TFDQueryHelper.ToJSON(const AFields: array of string): string;
var
  JSONObj: TJSONObject;
  I: Integer;
  Field: TField;
begin
  if IsEmpty then
    Exit('{}');
    
  JSONObj := TJSONObject.Create;
  try
    for I := 0 to High(AFields) do
    begin
      if HasField(AFields[I]) then
      begin
        Field := FieldByName(AFields[I]);
        if Field.IsNull then
          JSONObj.AddPair(Field.FieldName, TJSONNull.Create)
        else
          case Field.DataType of
            ftString, ftMemo, ftWideString, ftWideMemo:
              JSONObj.AddPair(Field.FieldName, Field.AsString);
            ftInteger, ftSmallint, ftWord, ftLargeint:
              JSONObj.AddPair(Field.FieldName, TJSONNumber.Create(Field.AsInteger));
            ftFloat, ftCurrency, ftBCD, ftFMTBcd:
              JSONObj.AddPair(Field.FieldName, TJSONNumber.Create(Field.AsFloat));
            ftBoolean:
              JSONObj.AddPair(Field.FieldName, TJSONBool.Create(Field.AsBoolean));
            ftDate, ftTime, ftDateTime, ftTimeStamp:
              JSONObj.AddPair(Field.FieldName, DateTimeToStr(Field.AsDateTime));
          else
            JSONObj.AddPair(Field.FieldName, Field.AsString);
          end;
      end;
    end;
    Result := JSONObj.ToString;
  finally
    JSONObj.Free;
  end;
end;

function TFDQueryHelper.ToJSONArray: string;
var
  JSONArray: TJSONArray;
  Bookmark: TBookmark;
begin
  if IsEmpty then
    Exit('[]');
    
  JSONArray := TJSONArray.Create;
  try
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        JSONArray.AddElement(TJSONObject.ParseJSONValue(ToJSON) as TJSONObject);
        Next;
      end;
      Result := JSONArray.ToString;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  finally
    JSONArray.Free;
  end;
end;

function TFDQueryHelper.ToJSONArray(const AFields: array of string): string;
var
  JSONArray: TJSONArray;
  Bookmark: TBookmark;
begin
  if IsEmpty then
    Exit('[]');
    
  JSONArray := TJSONArray.Create;
  try
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        JSONArray.AddElement(TJSONObject.ParseJSONValue(ToJSON(AFields)) as TJSONObject);
        Next;
      end;
      Result := JSONArray.ToString;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  finally
    JSONArray.Free;
  end;
end;

function TFDQueryHelper.ToCSV: string;
begin
  Result := ToCSV(',', True);
end;

function TFDQueryHelper.ToCSV(const ASeparator: string; const AIncludeHeader: Boolean): string;
var
  Lines: TStringList;
  Line: string;
  I: Integer;
  Bookmark: TBookmark;
begin
  Lines := TStringList.Create;
  try
    if AIncludeHeader then
    begin
      Line := '';
      for I := 0 to FieldCount - 1 do
      begin
        if I > 0 then Line := Line + ASeparator;
        Line := Line + Fields[I].FieldName;
      end;
      Lines.Add(Line);
    end;
    
    if IsNotEmpty then
    begin
      Bookmark := GetBookmark;
      try
        First;
        while not EOF do
        begin
          Line := '';
          for I := 0 to FieldCount - 1 do
          begin
            if I > 0 then Line := Line + ASeparator;
            Line := Line + Fields[I].AsString;
          end;
          Lines.Add(Line);
          Next;
        end;
      finally
        GotoBookmark(Bookmark);
        FreeBookmark(Bookmark);
      end;
    end;
    
    Result := Lines.Text;
  finally
    Lines.Free;
  end;
end;

function TFDQueryHelper.ToStringList: TStringList;
var
  Bookmark: TBookmark;
begin
  Result := TStringList.Create;
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        Result.Add(ToJSON);
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
end;

function TFDQueryHelper.ToArray: TArray<TArray<Variant>>;
var
  Rows: TArray<TArray<Variant>>;
  Row: TArray<Variant>;
  I, RowIndex: Integer;
  Bookmark: TBookmark;
begin
  if IsEmpty then
    Exit(nil);
    
  SetLength(Rows, RecordCount);
  RowIndex := 0;
  
  Bookmark := GetBookmark;
  try
    First;
    while not EOF do
    begin
      SetLength(Row, FieldCount);
      for I := 0 to FieldCount - 1 do
        Row[I] := Fields[I].Value;
      Rows[RowIndex] := Row;
      Inc(RowIndex);
      Next;
    end;
  finally
    GotoBookmark(Bookmark);
    FreeBookmark(Bookmark);
  end;
  
  Result := Rows;
end;

function TFDQueryHelper.ToDictionary: TDictionary<string, Variant>;
var
  I: Integer;
begin
  Result := TDictionary<string, Variant>.Create;
  if IsNotEmpty then
  begin
    for I := 0 to FieldCount - 1 do
      Result.Add(Fields[I].FieldName, Fields[I].Value);
  end;
end;

function TFDQueryHelper.ToArrayOfDictionaries: TArray<TDictionary<string, Variant>>;
var
  Dicts: TArray<TDictionary<string, Variant>>;
  RowIndex: Integer;
  Bookmark: TBookmark;
begin
  if IsEmpty then
    Exit(nil);
    
  SetLength(Dicts, RecordCount);
  RowIndex := 0;
  
  Bookmark := GetBookmark;
  try
    First;
    while not EOF do
    begin
      Dicts[RowIndex] := ToDictionary;
      Inc(RowIndex);
      Next;
    end;
  finally
    GotoBookmark(Bookmark);
    FreeBookmark(Bookmark);
  end;
  
  Result := Dicts;
end;

function TFDQueryHelper.ForEach(const AAction: TProc<TFDQuery>): TFDQuery;
var
  Bookmark: TBookmark;
begin
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        AAction(Self);
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
  Result := Self;
end;

function TFDQueryHelper.ForEachRecord(const AAction: TProc<TFDQuery, Integer>): TFDQuery;
var
  Bookmark: TBookmark;
  Index: Integer;
begin
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      Index := 0;
      First;
      while not EOF do
      begin
        AAction(Self, Index);
        Inc(Index);
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
  Result := Self;
end;

function TFDQueryHelper.Where(const APredicate: TFunc<TFDQuery, Boolean>): TFDQuery;
var
  Bookmark: TBookmark;
begin
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if not APredicate(Self) then
          Delete
        else
          Next;
      end;
    finally
      if BookmarkValid(Bookmark) then
      begin
        GotoBookmark(Bookmark);
        FreeBookmark(Bookmark);
      end;
    end;
  end;
  Result := Self;
end;

function TFDQueryHelper.Select(const ASelector: TFunc<TFDQuery, Variant>): TArray<Variant>;
var
  Values: TArray<Variant>;
  Index: Integer;
  Bookmark: TBookmark;
begin
  if IsEmpty then
    Exit(nil);
    
  SetLength(Values, RecordCount);
  Index := 0;
  
  Bookmark := GetBookmark;
  try
    First;
    while not EOF do
    begin
      Values[Index] := ASelector(Self);
      Inc(Index);
      Next;
    end;
  finally
    GotoBookmark(Bookmark);
    FreeBookmark(Bookmark);
  end;
  
  Result := Values;
end;

function TFDQueryHelper.Sum(const AFieldName: string): Double;
var
  Total: Double;
  Bookmark: TBookmark;
begin
  Total := 0;
  if IsNotEmpty and HasField(AFieldName) then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if not FieldByName(AFieldName).IsNull then
          Total := Total + FieldByName(AFieldName).AsFloat;
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
  Result := Total;
end;

function TFDQueryHelper.Count: Integer;
begin
  Result := RecordCount;
end;

function TFDQueryHelper.Count(const ACondition: TFunc<TFDQuery, Boolean>): Integer;
var
  Counter: Integer;
  Bookmark: TBookmark;
begin
  Counter := 0;
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if ACondition(Self) then
          Inc(Counter);
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
  Result := Counter;
end;

function TFDQueryHelper.Min(const AFieldName: string): Variant;
var
  MinValue: Variant;
  CurrentValue: Variant;
  Bookmark: TBookmark;
begin
  Result := Null;
  if IsNotEmpty and HasField(AFieldName) then
  begin
    Bookmark := GetBookmark;
    try
      First;
      MinValue := Null;
      while not EOF do
      begin
        CurrentValue := FieldByName(AFieldName).Value;
        if not VarIsNull(CurrentValue) then
        begin
          if VarIsNull(MinValue) or (CurrentValue < MinValue) then
            MinValue := CurrentValue;
        end;
        Next;
      end;
      Result := MinValue;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
end;

function TFDQueryHelper.Max(const AFieldName: string): Variant;
var
  MaxValue: Variant;
  CurrentValue: Variant;
  Bookmark: TBookmark;
begin
  Result := Null;
  if IsNotEmpty and HasField(AFieldName) then
  begin
    Bookmark := GetBookmark;
    try
      First;
      MaxValue := Null;
      while not EOF do
      begin
        CurrentValue := FieldByName(AFieldName).Value;
        if not VarIsNull(CurrentValue) then
        begin
          if VarIsNull(MaxValue) or (CurrentValue > MaxValue) then
            MaxValue := CurrentValue;
        end;
        Next;
      end;
      Result := MaxValue;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
end;

function TFDQueryHelper.Average(const AFieldName: string): Double;
var
  Total: Double;
  Counter: Integer;
  Bookmark: TBookmark;
begin
  Total := 0;
  Counter := 0;
  if IsNotEmpty and HasField(AFieldName) then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if not FieldByName(AFieldName).IsNull then
        begin
          Total := Total + FieldByName(AFieldName).AsFloat;
          Inc(Counter);
        end;
        Next;
      end;
    finally
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
    end;
  end;
  
  if Counter > 0 then
    Result := Total / Counter
  else
    Result := 0;
end;

function TFDQueryHelper.FindRecord(const AFieldName: string; const AValue: Variant): Boolean;
var
  Bookmark: TBookmark;
begin
  Result := False;
  if IsNotEmpty and HasField(AFieldName) then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if VarSameValue(FieldByName(AFieldName).Value, AValue) then
        begin
          Result := True;
          Break;
        end;
        Next;
      end;
      
      if not Result then
      begin
        GotoBookmark(Bookmark);
        FreeBookmark(Bookmark);
      end;
    except
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
      raise;
    end;
  end;
end;

function TFDQueryHelper.FindRecord(const ACondition: TFunc<TFDQuery, Boolean>): Boolean;
var
  Bookmark: TBookmark;
begin
  Result := False;
  if IsNotEmpty then
  begin
    Bookmark := GetBookmark;
    try
      First;
      while not EOF do
      begin
        if ACondition(Self) then
        begin
          Result := True;
          Break;
        end;
        Next;
      end;
      
      if not Result then
      begin
        GotoBookmark(Bookmark);
        FreeBookmark(Bookmark);
      end;
    except
      GotoBookmark(Bookmark);
      FreeBookmark(Bookmark);
      raise;
    end;
  end;
end;

function TFDQueryHelper.LocateRecord(const AKeyFields: string; const AKeyValues: Variant): Boolean;
begin
  Result := Locate(AKeyFields, AKeyValues, []);
end;

function TFDQueryHelper.CloneQuery: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Connection;
  Result.SQL.Text := SQL.Text;
  // Copy parameters
  Result.Params.Assign(Params);
end;

function TFDQueryHelper.CloneStructure: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := Connection;
  Result.SQL.Text := SQL.Text;
  Result.Params.Assign(Params);
  Result.Open;
  Result.Close;
end;

function TFDQueryHelper.Backup: TFDQuery;
begin
  Result := CloneQuery;
  if Active then
  begin
    Result.Open;
    // Copy data would require additional implementation
  end;
end;

function TFDQueryHelper.Restore(const ABackup: TFDQuery): TFDQuery;
begin
  Close;
  SQL.Text := ABackup.SQL.Text;
  Params.Assign(ABackup.Params);
  if ABackup.Active then
    Open;
  Result := Self;
end;

function TFDQueryHelper.GetFieldNames: TArray<string>;
var
  I: Integer;
begin
  SetLength(Result, FieldCount);
  for I := 0 to FieldCount - 1 do
    Result[I] := Fields[I].FieldName;
end;

function TFDQueryHelper.GetFieldTypes: TArray<TFieldType>;
var
  I: Integer;
begin
  SetLength(Result, FieldCount);
  for I := 0 to FieldCount - 1 do
    Result[I] := Fields[I].DataType;
end;

function TFDQueryHelper.GetFieldInfo: TDictionary<string, TFieldType>;
var
  I: Integer;
begin
  Result := TDictionary<string, TFieldType>.Create;
  for I := 0 to FieldCount - 1 do
    Result.Add(Fields[I].FieldName, Fields[I].DataType);
end;

function TFDQueryHelper.HasField(const AFieldName: string): Boolean;
begin
  Result := FindField(AFieldName) <> nil;
end;

function TFDQueryHelper.GetSQL: string;
begin
  Result := SQL.Text;
end;

function TFDQueryHelper.SetSQL(const ASQL: string): TFDQuery;
begin
  SQL.Text := ASQL;
  Result := Self;
end;

function TFDQueryHelper.AppendSQL(const ASQL: string): TFDQuery;
begin
  SQL.Add(ASQL);
  Result := Self;
end;

function TFDQueryHelper.BeginTransaction: TFDQuery;
begin
  if Assigned(Connection) and not Connection.InTransaction then
    Connection.StartTransaction;
  Result := Self;
end;

function TFDQueryHelper.CommitTransaction: TFDQuery;
begin
  if Assigned(Connection) and Connection.InTransaction then
    Connection.Commit;
  Result := Self;
end;

function TFDQueryHelper.RollbackTransaction: TFDQuery;
begin
  if Assigned(Connection) and Connection.InTransaction then
    Connection.Rollback;
  Result := Self;
end;

function TFDQueryHelper.InTransaction(const AAction: TProc<TFDQuery>): TFDQuery;
begin
  BeginTransaction;
  try
    AAction(Self);
    CommitTransaction;
  except
    RollbackTransaction;
    raise;
  end;
  Result := Self;
end;

function TFDQueryHelper.DebugSQL: string;
begin
  Result := 'SQL: ' + SQL.Text;
end;

function TFDQueryHelper.DebugParams: string;
var
  I: Integer;
  ParamInfo: TStringList;
begin
  ParamInfo := TStringList.Create;
  try
    ParamInfo.Add('Parameters:');
    for I := 0 to Params.Count - 1 do
    begin
      ParamInfo.Add(Format('  %s = %s (%s)', [
        Params[I].Name,
        VarToStr(Params[I].Value),
        FieldTypeNames[Params[I].DataType]
      ]));
    end;
    Result := ParamInfo.Text;
  finally
    ParamInfo.Free;
  end;
end;

function TFDQueryHelper.DebugInfo: string;
begin
  Result := DebugSQL + #13#10 + DebugParams + #13#10 +
           Format('Record Count: %d', [RecordCount]) + #13#10 +
           Format('Active: %s', [BoolToStr(Active, True)]);
end;

function TFDQueryHelper.SaveToFile(const AFileName: string): TFDQuery;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(AFileName, fmCreate);
  try
    // Save as JSON
    FileStream.WriteBuffer(PChar(ToJSONArray)^, Length(ToJSONArray) * SizeOf(Char));
  finally
    FileStream.Free;
  end;
  Result := Self;
end;

function TFDQueryHelper.LoadFromFile(const AFileName: string): TFDQuery;
begin
  // Implementation would depend on file format
  // This is a placeholder
  Result := Self;
end;

end.
