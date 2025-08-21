unit DateTimeHelper;

interface

uses
  System.SysUtils, System.DateUtils;

type
  // Helper para TDateTime
  TDateTimeHelper = record helper for TDateTime
  public
    // Formatação
    function ToDateString: string;
    function ToTimeString: string;
    function ToDateTimeString: string;
    function ToISOString: string;
    function ToUnixTimestamp: Int64;
    function ToRelativeString: string; // "há 2 horas", "ontem", etc.
    
    // Manipulação
    function AddDays(const ADays: Integer): TDateTime;
    function AddHours(const AHours: Integer): TDateTime;
    function AddMinutes(const AMinutes: Integer): TDateTime;
    function AddSeconds(const ASeconds: Integer): TDateTime;
    function StartOfDay: TDateTime;
    function EndOfDay: TDateTime;
    function StartOfWeek: TDateTime;
    function EndOfWeek: TDateTime;
    function StartOfMonth: TDateTime;
    function EndOfMonth: TDateTime;
    function StartOfYear: TDateTime;
    function EndOfYear: TDateTime;
    
    // Comparação
    function IsSameDate(const ADateTime: TDateTime): Boolean;
    function IsSameTime(const ADateTime: TDateTime): Boolean;
    function IsToday: Boolean;
    function IsYesterday: Boolean;
    function IsTomorrow: Boolean;
    function IsWeekend: Boolean;
    function IsWorkDay: Boolean;
    function IsBetween(const AStart, AEnd: TDateTime): Boolean;
    
    // Informações
    function Age: Integer; // Idade se for data de nascimento
    function DayOfWeekName: string;
    function MonthName: string;
    function Quarter: Integer;
    function WeekOfYear: Integer;
    function DaysInMonth: Integer;
    function IsLeapYear: Boolean;
    
    // Criação estática
    class function Now: TDateTime; static;
    class function Today: TDateTime; static;
    class function Tomorrow: TDateTime; static;
    class function Yesterday: TDateTime; static;
    class function FromUnixTimestamp(const ATimestamp: Int64): TDateTime; static;
    class function FromISOString(const ADateTimeStr: string): TDateTime; static;
  end;

implementation

{ TDateTimeHelper }

function TDateTimeHelper.ToDateString: string;
begin
  Result := DateToStr(Self);
end;

function TDateTimeHelper.ToTimeString: string;
begin
  Result := TimeToStr(Self);
end;

function TDateTimeHelper.ToDateTimeString: string;
begin
  Result := DateTimeToStr(Self);
end;

function TDateTimeHelper.ToISOString: string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', Self);
end;

function TDateTimeHelper.ToUnixTimestamp: Int64;
begin
  Result := DateTimeToUnix(Self);
end;

function TDateTimeHelper.ToRelativeString: string;
var
  Diff: TDateTime;
  Days, Hours, Minutes: Integer;
begin
  Diff := Now - Self;
  Days := Trunc(Diff);
  Hours := Trunc((Diff - Days) * 24);
  Minutes := Trunc(((Diff - Days) * 24 - Hours) * 60);
  
  if Days > 7 then
    Result := ToDateString
  else if Days > 1 then
    Result := Format('há %d dias', [Days])
  else if Days = 1 then
    Result := 'ontem'
  else if Hours > 1 then
    Result := Format('há %d horas', [Hours])
  else if Hours = 1 then
    Result := 'há 1 hora'
  else if Minutes > 1 then
    Result := Format('há %d minutos', [Minutes])
  else if Minutes = 1 then
    Result := 'há 1 minuto'
  else
    Result := 'agora mesmo';
end;

function TDateTimeHelper.AddDays(const ADays: Integer): TDateTime;
begin
  Result := IncDay(Self, ADays);
end;

function TDateTimeHelper.AddHours(const AHours: Integer): TDateTime;
begin
  Result := IncHour(Self, AHours);
end;

function TDateTimeHelper.AddMinutes(const AMinutes: Integer): TDateTime;
begin
  Result := IncMinute(Self, AMinutes);
end;

function TDateTimeHelper.AddSeconds(const ASeconds: Integer): TDateTime;
begin
  Result := IncSecond(Self, ASeconds);
end;

function TDateTimeHelper.StartOfDay: TDateTime;
begin
  Result := System.DateUtils.StartOfTheDay(Self);
end;

function TDateTimeHelper.EndOfDay: TDateTime;
begin
  Result := System.DateUtils.EndOfTheDay(Self);
end;

function TDateTimeHelper.StartOfWeek: TDateTime;
begin
  Result := System.DateUtils.StartOfTheWeek(Self);
end;

function TDateTimeHelper.EndOfWeek: TDateTime;
begin
  Result := System.DateUtils.EndOfTheWeek(Self);
end;

function TDateTimeHelper.StartOfMonth: TDateTime;
begin
  Result := System.DateUtils.StartOfTheMonth(Self);
end;

function TDateTimeHelper.EndOfMonth: TDateTime;
begin
  Result := System.DateUtils.EndOfTheMonth(Self);
end;

function TDateTimeHelper.StartOfYear: TDateTime;
begin
  Result := System.DateUtils.StartOfTheYear(Self);
end;

function TDateTimeHelper.EndOfYear: TDateTime;
begin
  Result := System.DateUtils.EndOfTheYear(Self);
end;

function TDateTimeHelper.IsSameDate(const ADateTime: TDateTime): Boolean;
begin
  Result := System.DateUtils.IsSameDay(Self, ADateTime);
end;

function TDateTimeHelper.IsSameTime(const ADateTime: TDateTime): Boolean;
begin
  Result := TimeOf(Self) = TimeOf(ADateTime);
end;

function TDateTimeHelper.IsToday: Boolean;
begin
  Result := (Self >= Date) and (Self < Date + 1);
end;

function TDateTimeHelper.IsYesterday: Boolean;
var
  Yesterday: TDateTime;
begin
  Yesterday := Date - 1;
  Result := (Self >= Yesterday) and (Self < Date);
end;

function TDateTimeHelper.IsTomorrow: Boolean;
var
  Tomorrow: TDateTime;
begin
  Tomorrow := Date + 1;
  Result := (Self >= Tomorrow) and (Self < Tomorrow + 1);
end;

function TDateTimeHelper.IsWeekend: Boolean;
var
  DayOfWeek: Integer;
begin
  DayOfWeek := DayOfTheWeek(Self);
  Result := (DayOfWeek = 1) or (DayOfWeek = 7); // Domingo ou Sábado
end;

function TDateTimeHelper.IsWorkDay: Boolean;
begin
  Result := not IsWeekend;
end;

function TDateTimeHelper.IsBetween(const AStart, AEnd: TDateTime): Boolean;
begin
  Result := (Self >= AStart) and (Self <= AEnd);
end;

function TDateTimeHelper.Age: Integer;
begin
  Result := System.DateUtils.YearsBetween(Now, Self);
end;

function TDateTimeHelper.DayOfWeekName: string;
begin
  Result := FormatDateTime('dddd', Self);
end;

function TDateTimeHelper.MonthName: string;
begin
  Result := FormatDateTime('mmmm', Self);
end;

function TDateTimeHelper.Quarter: Integer;
begin
  Result := ((MonthOf(Self) - 1) div 3) + 1;
end;

function TDateTimeHelper.WeekOfYear: Integer;
begin
  Result := System.DateUtils.WeekOfTheYear(Self);
end;

function TDateTimeHelper.DaysInMonth: Integer;
begin
  Result := System.DateUtils.DaysInAMonth(YearOf(Self), MonthOf(Self));
end;

function TDateTimeHelper.IsLeapYear: Boolean;
var
  Year: Word;
begin
  Year := YearOf(Self);
  Result := (Year mod 4 = 0) and ((Year mod 100 <> 0) or (Year mod 400 = 0));
end;

class function TDateTimeHelper.Now: TDateTime;
begin
  Result := System.SysUtils.Now;
end;

class function TDateTimeHelper.Today: TDateTime;
begin
  Result := System.SysUtils.Date;
end;

class function TDateTimeHelper.Tomorrow: TDateTime;
begin
  Result := System.SysUtils.Date + 1;
end;

class function TDateTimeHelper.Yesterday: TDateTime;
begin
  Result := System.SysUtils.Date - 1;
end;

class function TDateTimeHelper.FromUnixTimestamp(const ATimestamp: Int64): TDateTime;
begin
  Result := UnixToDateTime(ATimestamp);
end;

class function TDateTimeHelper.FromISOString(const ADateTimeStr: string): TDateTime;
var
  FormatSettings: TFormatSettings;
begin
  FormatSettings := TFormatSettings.Create;
  FormatSettings.DateSeparator := '-';
  FormatSettings.TimeSeparator := ':';
  FormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  FormatSettings.ShortTimeFormat := 'hh:nn:ss';
  Result := StrToDateTime(StringReplace(ADateTimeStr, 'T', ' ', []), FormatSettings);
end;

end.
