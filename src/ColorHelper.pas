unit ColorHelper;

interface

uses
  System.SysUtils, Vcl.Graphics, System.Math;

type
  TRGB = record
    R, G, B: Byte;
  end;
  
  THSL = record
    H, S, L: Double; // H: 0-360, S,L: 0-100
  end;
  
  THSV = record
    H, S, V: Double; // H: 0-360, S,V: 0-100
  end;

  // Helper para TColor
  TColorHelper = record helper for TColor
  public
    // Conversões
    function ToRGB: TRGB;
    function ToHSL: THSL;
    function ToHSV: THSV;
    function ToHex: string;
    function ToWebColor: string; // #RRGGBB
    function ToCSSColor: string; // rgb(r,g,b)
    function ToDelphiColor: string; // $00BBGGRR
    
    // Criação
    class function FromRGB(const R, G, B: Byte): TColor; static;
    class function FromHSL(const H, S, L: Double): TColor; static;
    class function FromHSV(const H, S, V: Double): TColor; static;
    class function FromHex(const AHexColor: string): TColor; static;
    class function FromWebColor(const AWebColor: string): TColor; static;
    
    // Análise
    function IsLight: Boolean;
    function IsDark: Boolean;
    function IsGrayscale: Boolean;
    function Brightness: Double; // 0-100
    function Luminance: Double; // 0-1
    function Contrast(const AOtherColor: TColor): Double; // 1-21
    function IsReadableOn(const ABackgroundColor: TColor): Boolean;
    
    // Manipulação
    function Lighten(const APercent: Double): TColor;
    function Darken(const APercent: Double): TColor;
    function Saturate(const APercent: Double): TColor;
    function Desaturate(const APercent: Double): TColor;
    function Invert: TColor;
    function Complement: TColor; // Cor complementar
    function Grayscale: TColor;
    function Sepia: TColor;
    function AdjustBrightness(const APercent: Double): TColor;
    function AdjustContrast(const APercent: Double): TColor;
    function Mix(const AOtherColor: TColor; const AWeight: Double = 0.5): TColor;
    function Fade(const AOpacity: Double): TColor; // Para uso com Alpha
    
    // Esquemas de cores
    function Analogous: TArray<TColor>; // Cores análogas
    function Triadic: TArray<TColor>; // Esquema triádico
    function Tetradic: TArray<TColor>; // Esquema tetrádico
    function Monochromatic(const ACount: Integer = 5): TArray<TColor>;
    function Shades(const ACount: Integer = 5): TArray<TColor>;
    function Tints(const ACount: Integer = 5): TArray<TColor>;
    
    // Paletas predefinidas
    class function MaterialPalette: TArray<TColor>; static;
    class function FlatUIPalette: TArray<TColor>; static;
    class function WindowsPalette: TArray<TColor>; static;
    class function WebSafePalette: TArray<TColor>; static;
    
    // Cores nomeadas comuns
    class function AliceBlue: TColor; static;
    class function AntiqueWhite: TColor; static;
    class function Aqua: TColor; static;
    class function Aquamarine: TColor; static;
    class function Azure: TColor; static;
    class function Beige: TColor; static;
    class function Bisque: TColor; static;
    class function BlanchedAlmond: TColor; static;
    class function BlueViolet: TColor; static;
    class function Brown: TColor; static;
    class function BurlyWood: TColor; static;
    class function CadetBlue: TColor; static;
    class function Chartreuse: TColor; static;
    class function Chocolate: TColor; static;
    class function Coral: TColor; static;
    class function CornflowerBlue: TColor; static;
    class function Cornsilk: TColor; static;
    class function Crimson: TColor; static;
    class function DarkBlue: TColor; static;
    class function DarkCyan: TColor; static;
    class function DarkGoldenrod: TColor; static;
    class function DarkGreen: TColor; static;
    class function DarkKhaki: TColor; static;
    class function DarkMagenta: TColor; static;
    class function DarkOliveGreen: TColor; static;
    class function DarkOrange: TColor; static;
    class function DarkOrchid: TColor; static;
    class function DarkRed: TColor; static;
    class function DarkSalmon: TColor; static;
    class function DarkSeaGreen: TColor; static;
    class function DarkSlateBlue: TColor; static;
    class function DarkSlateGray: TColor; static;
    class function DarkTurquoise: TColor; static;
    class function DarkViolet: TColor; static;
    class function DeepPink: TColor; static;
    class function DeepSkyBlue: TColor; static;
    class function DimGray: TColor; static;
    class function DodgerBlue: TColor; static;
    class function FireBrick: TColor; static;
    class function FloralWhite: TColor; static;
    class function ForestGreen: TColor; static;
    class function Gainsboro: TColor; static;
    class function GhostWhite: TColor; static;
    class function Gold: TColor; static;
    class function Goldenrod: TColor; static;
    class function GreenYellow: TColor; static;
    class function Honeydew: TColor; static;
    class function HotPink: TColor; static;
    class function IndianRed: TColor; static;
    class function Indigo: TColor; static;
    class function Ivory: TColor; static;
    class function Khaki: TColor; static;
    class function Lavender: TColor; static;
    class function LavenderBlush: TColor; static;
    class function LawnGreen: TColor; static;
    class function LemonChiffon: TColor; static;
    class function LightBlue: TColor; static;
    class function LightCoral: TColor; static;
    class function LightCyan: TColor; static;
    class function LightGoldenrodYellow: TColor; static;
    class function LightGreen: TColor; static;
    class function LightPink: TColor; static;
    class function LightSalmon: TColor; static;
    class function LightSeaGreen: TColor; static;
    class function LightSkyBlue: TColor; static;
    class function LightSlateGray: TColor; static;
    class function LightSteelBlue: TColor; static;
    class function LightYellow: TColor; static;
    class function LimeGreen: TColor; static;
    class function Linen: TColor; static;
    class function Magenta: TColor; static;
    class function MediumAquamarine: TColor; static;
    class function MediumBlue: TColor; static;
    class function MediumOrchid: TColor; static;
    class function MediumPurple: TColor; static;
    class function MediumSeaGreen: TColor; static;
    class function MediumSlateBlue: TColor; static;
    class function MediumSpringGreen: TColor; static;
    class function MediumTurquoise: TColor; static;
    class function MediumVioletRed: TColor; static;
    class function MidnightBlue: TColor; static;
    class function MintCream: TColor; static;
    class function MistyRose: TColor; static;
    class function Moccasin: TColor; static;
    class function NavajoWhite: TColor; static;
    class function OldLace: TColor; static;
    class function OliveDrab: TColor; static;
    class function Orange: TColor; static;
    class function OrangeRed: TColor; static;
    class function Orchid: TColor; static;
    class function PaleGoldenrod: TColor; static;
    class function PaleGreen: TColor; static;
    class function PaleTurquoise: TColor; static;
    class function PaleVioletRed: TColor; static;
    class function PapayaWhip: TColor; static;
    class function PeachPuff: TColor; static;
    class function Peru: TColor; static;
    class function Pink: TColor; static;
    class function Plum: TColor; static;
    class function PowderBlue: TColor; static;
    class function RosyBrown: TColor; static;
    class function RoyalBlue: TColor; static;
    class function SaddleBrown: TColor; static;
    class function Salmon: TColor; static;
    class function SandyBrown: TColor; static;
    class function SeaGreen: TColor; static;
    class function SeaShell: TColor; static;
    class function Sienna: TColor; static;
    class function SkyBlue: TColor; static;
    class function SlateBlue: TColor; static;
    class function SlateGray: TColor; static;
    class function Snow: TColor; static;
    class function SpringGreen: TColor; static;
    class function SteelBlue: TColor; static;
    class function Tan: TColor; static;
    class function Thistle: TColor; static;
    class function Tomato: TColor; static;
    class function Turquoise: TColor; static;
    class function Violet: TColor; static;
    class function Wheat: TColor; static;
    class function WhiteSmoke: TColor; static;
    class function YellowGreen: TColor; static;
  end;

implementation

{ TColorHelper }

function TColorHelper.ToRGB: TRGB;
begin
  Result.R := Self and $FF;
  Result.G := (Self shr 8) and $FF;
  Result.B := (Self shr 16) and $FF;
end;

function TColorHelper.ToHSL: THSL;
var
  RGB: TRGB;
  R, G, B: Double;
  Max, Min, Delta: Double;
begin
  RGB := ToRGB;
  R := RGB.R / 255;
  G := RGB.G / 255;
  B := RGB.B / 255;
  
  Max := System.Math.Max(System.Math.Max(R, G), B);
  Min := System.Math.Min(System.Math.Min(R, G), B);
  Delta := Max - Min;
  
  // Luminosidade
  Result.L := (Max + Min) / 2 * 100;
  
  if Delta = 0 then
  begin
    Result.H := 0;
    Result.S := 0;
  end
  else
  begin
    // Saturação
    if Result.L < 50 then
      Result.S := Delta / (Max + Min) * 100
    else
      Result.S := Delta / (2 - Max - Min) * 100;
    
    // Matiz
    if Max = R then
      Result.H := ((G - B) / Delta) * 60
    else if Max = G then
      Result.H := (2 + (B - R) / Delta) * 60
    else
      Result.H := (4 + (R - G) / Delta) * 60;
    
    if Result.H < 0 then
      Result.H := Result.H + 360;
  end;
end;

function TColorHelper.ToHSV: THSV;
var
  RGB: TRGB;
  R, G, B: Double;
  Max, Min, Delta: Double;
begin
  RGB := ToRGB;
  R := RGB.R / 255;
  G := RGB.G / 255;
  B := RGB.B / 255;
  
  Max := System.Math.Max(System.Math.Max(R, G), B);
  Min := System.Math.Min(System.Math.Min(R, G), B);
  Delta := Max - Min;
  
  // Valor
  Result.V := Max * 100;
  
  // Saturação
  if Max = 0 then
    Result.S := 0
  else
    Result.S := (Delta / Max) * 100;
  
  // Matiz
  if Delta = 0 then
    Result.H := 0
  else
  begin
    if Max = R then
      Result.H := ((G - B) / Delta) * 60
    else if Max = G then
      Result.H := (2 + (B - R) / Delta) * 60
    else
      Result.H := (4 + (R - G) / Delta) * 60;
    
    if Result.H < 0 then
      Result.H := Result.H + 360;
  end;
end;

function TColorHelper.ToHex: string;
var
  RGB: TRGB;
begin
  RGB := ToRGB;
  Result := Format('%.2x%.2x%.2x', [RGB.R, RGB.G, RGB.B]);
end;

function TColorHelper.ToWebColor: string;
begin
  Result := '#' + ToHex;
end;

function TColorHelper.ToCSSColor: string;
var
  RGB: TRGB;
begin
  RGB := ToRGB;
  Result := Format('rgb(%d,%d,%d)', [RGB.R, RGB.G, RGB.B]);
end;

function TColorHelper.ToDelphiColor: string;
begin
  Result := Format('$%.8x', [Self]);
end;

class function TColorHelper.FromRGB(const R, G, B: Byte): TColor;
begin
  Result := TColor(R or (G shl 8) or (B shl 16));
end;

class function TColorHelper.FromHSL(const H, S, L: Double): TColor;
var
  C, X, M: Double;
  R, G, B: Double;
  HPrime: Double;
begin
  C := (1 - Abs(2 * (L / 100) - 1)) * (S / 100);
  HPrime := H / 60;
  X := C * (1 - Abs(HPrime - 2 * Floor(HPrime / 2) - 1));
  M := (L / 100) - C / 2;
  
  if HPrime < 1 then
  begin
    R := C; G := X; B := 0;
  end
  else if HPrime < 2 then
  begin
    R := X; G := C; B := 0;
  end
  else if HPrime < 3 then
  begin
    R := 0; G := C; B := X;
  end
  else if HPrime < 4 then
  begin
    R := 0; G := X; B := C;
  end
  else if HPrime < 5 then
  begin
    R := X; G := 0; B := C;
  end
  else
  begin
    R := C; G := 0; B := X;
  end;
  
  Result := FromRGB(
    Round((R + M) * 255),
    Round((G + M) * 255),
    Round((B + M) * 255)
  );
end;

class function TColorHelper.FromHSV(const H, S, V: Double): TColor;
var
  C, X, M: Double;
  R, G, B: Double;
  HPrime: Double;
begin
  C := (V / 100) * (S / 100);
  HPrime := H / 60;
  X := C * (1 - Abs(HPrime - 2 * Floor(HPrime / 2) - 1));
  M := (V / 100) - C;
  
  if HPrime < 1 then
  begin
    R := C; G := X; B := 0;
  end
  else if HPrime < 2 then
  begin
    R := X; G := C; B := 0;
  end
  else if HPrime < 3 then
  begin
    R := 0; G := C; B := X;
  end
  else if HPrime < 4 then
  begin
    R := 0; G := X; B := C;
  end
  else if HPrime < 5 then
  begin
    R := X; G := 0; B := C;
  end
  else
  begin
    R := C; G := 0; B := X;
  end;
  
  Result := FromRGB(
    Round((R + M) * 255),
    Round((G + M) * 255),
    Round((B + M) * 255)
  );
end;

class function TColorHelper.FromHex(const AHexColor: string): TColor;
var
  Hex: string;
begin
  Hex := AHexColor;
  if Hex.StartsWith('#') then
    Hex := Hex.Substring(1);
  if Hex.StartsWith('$') then
    Hex := Hex.Substring(1);
    
  Result := StrToInt('$' + Hex);
end;

class function TColorHelper.FromWebColor(const AWebColor: string): TColor;
begin
  Result := FromHex(AWebColor);
end;

function TColorHelper.IsLight: Boolean;
begin
  Result := Brightness > 50;
end;

function TColorHelper.IsDark: Boolean;
begin
  Result := not IsLight;
end;

function TColorHelper.IsGrayscale: Boolean;
var
  RGB: TRGB;
begin
  RGB := ToRGB;
  Result := (RGB.R = RGB.G) and (RGB.G = RGB.B);
end;

function TColorHelper.Brightness: Double;
var
  RGB: TRGB;
begin
  RGB := ToRGB;
  Result := (RGB.R * 0.299 + RGB.G * 0.587 + RGB.B * 0.114) / 255 * 100;
end;

function TColorHelper.Luminance: Double;
var
  RGB: TRGB;
  R, G, B: Double;
begin
  RGB := ToRGB;
  R := RGB.R / 255;
  G := RGB.G / 255;
  B := RGB.B / 255;
  
  // Gamma correction
  if R <= 0.03928 then R := R / 12.92 else R := Power((R + 0.055) / 1.055, 2.4);
  if G <= 0.03928 then G := G / 12.92 else G := Power((G + 0.055) / 1.055, 2.4);
  if B <= 0.03928 then B := B / 12.92 else B := Power((B + 0.055) / 1.055, 2.4);
  
  Result := 0.2126 * R + 0.7152 * G + 0.0722 * B;
end;

function TColorHelper.Contrast(const AOtherColor: TColor): Double;
var
  L1, L2: Double;
begin
  L1 := Luminance;
  L2 := AOtherColor.Luminance;
  
  if L1 > L2 then
    Result := (L1 + 0.05) / (L2 + 0.05)
  else
    Result := (L2 + 0.05) / (L1 + 0.05);
end;

function TColorHelper.IsReadableOn(const ABackgroundColor: TColor): Boolean;
begin
  Result := Contrast(ABackgroundColor) >= 4.5; // WCAG AA standard
end;

function TColorHelper.Lighten(const APercent: Double): TColor;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  HSL.L := HSL.L + APercent;
  if HSL.L > 100 then HSL.L := 100;
  Result := FromHSL(HSL.H, HSL.S, HSL.L);
end;

function TColorHelper.Darken(const APercent: Double): TColor;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  HSL.L := HSL.L - APercent;
  if HSL.L < 0 then HSL.L := 0;
  Result := FromHSL(HSL.H, HSL.S, HSL.L);
end;

function TColorHelper.Saturate(const APercent: Double): TColor;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  HSL.S := HSL.S + APercent;
  if HSL.S > 100 then HSL.S := 100;
  Result := FromHSL(HSL.H, HSL.S, HSL.L);
end;

function TColorHelper.Desaturate(const APercent: Double): TColor;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  HSL.S := HSL.S - APercent;
  if HSL.S < 0 then HSL.S := 0;
  Result := FromHSL(HSL.H, HSL.S, HSL.L);
end;

function TColorHelper.Invert: TColor;
var
  RGB: TRGB;
begin
  RGB := ToRGB;
  Result := FromRGB(255 - RGB.R, 255 - RGB.G, 255 - RGB.B);
end;

function TColorHelper.Complement: TColor;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  HSL.H := HSL.H + 180;
  if HSL.H >= 360 then HSL.H := HSL.H - 360;
  Result := FromHSL(HSL.H, HSL.S, HSL.L);
end;

function TColorHelper.Grayscale: TColor;
var
  Gray: Byte;
begin
  Gray := Round(Brightness * 255 / 100);
  Result := FromRGB(Gray, Gray, Gray);
end;

function TColorHelper.Sepia: TColor;
var
  RGB: TRGB;
  R, G, B: Integer;
begin
  RGB := ToRGB;
  R := Round(RGB.R * 0.393 + RGB.G * 0.769 + RGB.B * 0.189);
  G := Round(RGB.R * 0.349 + RGB.G * 0.686 + RGB.B * 0.168);
  B := Round(RGB.R * 0.272 + RGB.G * 0.534 + RGB.B * 0.131);
  
  if R > 255 then R := 255;
  if G > 255 then G := 255;
  if B > 255 then B := 255;
  
  Result := FromRGB(R, G, B);
end;

function TColorHelper.AdjustBrightness(const APercent: Double): TColor;
begin
  if APercent > 0 then
    Result := Lighten(APercent)
  else
    Result := Darken(-APercent);
end;

function TColorHelper.AdjustContrast(const APercent: Double): TColor;
var
  RGB: TRGB;
  Factor: Double;
  R, G, B: Integer;
begin
  RGB := ToRGB;
  Factor := (259 * (APercent + 255)) / (255 * (259 - APercent));
  
  R := Round(Factor * (RGB.R - 128) + 128);
  G := Round(Factor * (RGB.G - 128) + 128);
  B := Round(Factor * (RGB.B - 128) + 128);
  
  if R < 0 then R := 0 else if R > 255 then R := 255;
  if G < 0 then G := 0 else if G > 255 then G := 255;
  if B < 0 then B := 0 else if B > 255 then B := 255;
  
  Result := FromRGB(R, G, B);
end;

function TColorHelper.Mix(const AOtherColor: TColor; const AWeight: Double): TColor;
var
  RGB1, RGB2: TRGB;
  Weight: Double;
begin
  RGB1 := ToRGB;
  RGB2 := AOtherColor.ToRGB;
  Weight := Max(0, Min(1, AWeight));
  
  Result := FromRGB(
    Round(RGB1.R * (1 - Weight) + RGB2.R * Weight),
    Round(RGB1.G * (1 - Weight) + RGB2.G * Weight),
    Round(RGB1.B * (1 - Weight) + RGB2.B * Weight)
  );
end;

function TColorHelper.Fade(const AOpacity: Double): TColor;
begin
  // Para uso futuro com suporte a Alpha
  Result := Self;
end;

function TColorHelper.Analogous: TArray<TColor>;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  SetLength(Result, 3);
  Result[0] := FromHSL(HSL.H - 30, HSL.S, HSL.L);
  Result[1] := Self;
  Result[2] := FromHSL(HSL.H + 30, HSL.S, HSL.L);
end;

function TColorHelper.Triadic: TArray<TColor>;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  SetLength(Result, 3);
  Result[0] := Self;
  Result[1] := FromHSL(HSL.H + 120, HSL.S, HSL.L);
  Result[2] := FromHSL(HSL.H + 240, HSL.S, HSL.L);
end;

function TColorHelper.Tetradic: TArray<TColor>;
var
  HSL: THSL;
begin
  HSL := ToHSL;
  SetLength(Result, 4);
  Result[0] := Self;
  Result[1] := FromHSL(HSL.H + 90, HSL.S, HSL.L);
  Result[2] := FromHSL(HSL.H + 180, HSL.S, HSL.L);
  Result[3] := FromHSL(HSL.H + 270, HSL.S, HSL.L);
end;

function TColorHelper.Monochromatic(const ACount: Integer): TArray<TColor>;
var
  HSL: THSL;
  I: Integer;
  Step: Double;
begin
  HSL := ToHSL;
  SetLength(Result, ACount);
  Step := 100 / (ACount - 1);
  
  for I := 0 to ACount - 1 do
    Result[I] := FromHSL(HSL.H, HSL.S, I * Step);
end;

function TColorHelper.Shades(const ACount: Integer): TArray<TColor>;
var
  I: Integer;
  Step: Double;
begin
  SetLength(Result, ACount);
  Step := 100 / (ACount - 1);
  
  for I := 0 to ACount - 1 do
    Result[I] := Darken(I * Step);
end;

function TColorHelper.Tints(const ACount: Integer): TArray<TColor>;
var
  I: Integer;
  Step: Double;
begin
  SetLength(Result, ACount);
  Step := 100 / (ACount - 1);
  
  for I := 0 to ACount - 1 do
    Result[I] := Lighten(I * Step);
end;

class function TColorHelper.MaterialPalette: TArray<TColor>;
begin
  Result := [
    $36F4F4, // Red
    $E91E63, // Pink
    $9C27B0, // Purple
    $673AB7, // Deep Purple
    $3F51B5, // Indigo
    $2196F3, // Blue
    $03A9F4, // Light Blue
    $00BCD4, // Cyan
    $009688, // Teal
    $4CAF50, // Green
    $8BC34A, // Light Green
    $CDDC39, // Lime
    $FFEB3B, // Yellow
    $FFC107, // Amber
    $FF9800, // Orange
    $FF5722  // Deep Orange
  ];
end;

class function TColorHelper.FlatUIPalette: TArray<TColor>;
begin
  Result := [
    $1ABC9C, // Turquoise
    $16A085, // Green Sea
    $2ECC71, // Emerald
    $27AE60, // Nephritis
    $3498DB, // Peter River
    $2980B9, // Belize Hole
    $9B59B6, // Amethyst
    $8E44AD, // Wisteria
    $34495E, // Wet Asphalt
    $2C3E50, // Midnight Blue
    $F1C40F, // Sun Flower
    $F39C12, // Orange
    $E67E22, // Carrot
    $D35400, // Pumpkin
    $E74C3C, // Alizarin
    $C0392B  // Pomegranate
  ];
end;

class function TColorHelper.WindowsPalette: TArray<TColor>;
begin
  Result := [
    clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
    clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite
  ];
end;

class function TColorHelper.WebSafePalette: TArray<TColor>;
var
  I, R, G, B: Integer;
  Colors: TArray<Integer>;
begin
  Colors := [0, $33, $66, $99, $CC, $FF];
  SetLength(Result, 216);
  I := 0;
  
  for R in Colors do
    for G in Colors do
      for B in Colors do
      begin
        Result[I] := FromRGB(R, G, B);
        Inc(I);
      end;
end;

// Cores nomeadas
class function TColorHelper.AliceBlue: TColor; begin Result := $F0F8FF; end;
class function TColorHelper.AntiqueWhite: TColor; begin Result := $FAEBD7; end;
class function TColorHelper.Aqua: TColor; begin Result := $00FFFF; end;
class function TColorHelper.Aquamarine: TColor; begin Result := $7FFFD4; end;
class function TColorHelper.Azure: TColor; begin Result := $F0FFFF; end;
class function TColorHelper.Beige: TColor; begin Result := $F5F5DC; end;
class function TColorHelper.Bisque: TColor; begin Result := $FFE4C4; end;
class function TColorHelper.BlanchedAlmond: TColor; begin Result := $FFEBCD; end;
class function TColorHelper.BlueViolet: TColor; begin Result := $8A2BE2; end;
class function TColorHelper.Brown: TColor; begin Result := $A52A2A; end;
class function TColorHelper.BurlyWood: TColor; begin Result := $DEB887; end;
class function TColorHelper.CadetBlue: TColor; begin Result := $5F9EA0; end;
class function TColorHelper.Chartreuse: TColor; begin Result := $7FFF00; end;
class function TColorHelper.Chocolate: TColor; begin Result := $D2691E; end;
class function TColorHelper.Coral: TColor; begin Result := $FF7F50; end;
class function TColorHelper.CornflowerBlue: TColor; begin Result := $6495ED; end;
class function TColorHelper.Cornsilk: TColor; begin Result := $FFF8DC; end;
class function TColorHelper.Crimson: TColor; begin Result := $DC143C; end;
class function TColorHelper.DarkBlue: TColor; begin Result := $00008B; end;
class function TColorHelper.DarkCyan: TColor; begin Result := $008B8B; end;
class function TColorHelper.DarkGoldenrod: TColor; begin Result := $B8860B; end;
class function TColorHelper.DarkGreen: TColor; begin Result := $006400; end;
class function TColorHelper.DarkKhaki: TColor; begin Result := $BDB76B; end;
class function TColorHelper.DarkMagenta: TColor; begin Result := $8B008B; end;
class function TColorHelper.DarkOliveGreen: TColor; begin Result := $556B2F; end;
class function TColorHelper.DarkOrange: TColor; begin Result := $FF8C00; end;
class function TColorHelper.DarkOrchid: TColor; begin Result := $9932CC; end;
class function TColorHelper.DarkRed: TColor; begin Result := $8B0000; end;
class function TColorHelper.DarkSalmon: TColor; begin Result := $E9967A; end;
class function TColorHelper.DarkSeaGreen: TColor; begin Result := $8FBC8F; end;
class function TColorHelper.DarkSlateBlue: TColor; begin Result := $483D8B; end;
class function TColorHelper.DarkSlateGray: TColor; begin Result := $2F4F4F; end;
class function TColorHelper.DarkTurquoise: TColor; begin Result := $00CED1; end;
class function TColorHelper.DarkViolet: TColor; begin Result := $9400D3; end;
class function TColorHelper.DeepPink: TColor; begin Result := $FF1493; end;
class function TColorHelper.DeepSkyBlue: TColor; begin Result := $00BFFF; end;
class function TColorHelper.DimGray: TColor; begin Result := $696969; end;
class function TColorHelper.DodgerBlue: TColor; begin Result := $1E90FF; end;
class function TColorHelper.FireBrick: TColor; begin Result := $B22222; end;
class function TColorHelper.FloralWhite: TColor; begin Result := $FFFAF0; end;
class function TColorHelper.ForestGreen: TColor; begin Result := $228B22; end;
class function TColorHelper.Gainsboro: TColor; begin Result := $DCDCDC; end;
class function TColorHelper.GhostWhite: TColor; begin Result := $F8F8FF; end;
class function TColorHelper.Gold: TColor; begin Result := $FFD700; end;
class function TColorHelper.Goldenrod: TColor; begin Result := $DAA520; end;
class function TColorHelper.GreenYellow: TColor; begin Result := $ADFF2F; end;
class function TColorHelper.Honeydew: TColor; begin Result := $F0FFF0; end;
class function TColorHelper.HotPink: TColor; begin Result := $FF69B4; end;
class function TColorHelper.IndianRed: TColor; begin Result := $CD5C5C; end;
class function TColorHelper.Indigo: TColor; begin Result := $4B0082; end;
class function TColorHelper.Ivory: TColor; begin Result := $FFFFF0; end;
class function TColorHelper.Khaki: TColor; begin Result := $F0E68C; end;
class function TColorHelper.Lavender: TColor; begin Result := $E6E6FA; end;
class function TColorHelper.LavenderBlush: TColor; begin Result := $FFF0F5; end;
class function TColorHelper.LawnGreen: TColor; begin Result := $7CFC00; end;
class function TColorHelper.LemonChiffon: TColor; begin Result := $FFFACD; end;
class function TColorHelper.LightBlue: TColor; begin Result := $ADD8E6; end;
class function TColorHelper.LightCoral: TColor; begin Result := $F08080; end;
class function TColorHelper.LightCyan: TColor; begin Result := $E0FFFF; end;
class function TColorHelper.LightGoldenrodYellow: TColor; begin Result := $FAFAD2; end;
class function TColorHelper.LightGreen: TColor; begin Result := $90EE90; end;
class function TColorHelper.LightPink: TColor; begin Result := $FFB6C1; end;
class function TColorHelper.LightSalmon: TColor; begin Result := $FFA07A; end;
class function TColorHelper.LightSeaGreen: TColor; begin Result := $20B2AA; end;
class function TColorHelper.LightSkyBlue: TColor; begin Result := $87CEFA; end;
class function TColorHelper.LightSlateGray: TColor; begin Result := $778899; end;
class function TColorHelper.LightSteelBlue: TColor; begin Result := $B0C4DE; end;
class function TColorHelper.LightYellow: TColor; begin Result := $FFFFE0; end;
class function TColorHelper.LimeGreen: TColor; begin Result := $32CD32; end;
class function TColorHelper.Linen: TColor; begin Result := $FAF0E6; end;
class function TColorHelper.Magenta: TColor; begin Result := $FF00FF; end;
class function TColorHelper.MediumAquamarine: TColor; begin Result := $66CDAA; end;
class function TColorHelper.MediumBlue: TColor; begin Result := $0000CD; end;
class function TColorHelper.MediumOrchid: TColor; begin Result := $BA55D3; end;
class function TColorHelper.MediumPurple: TColor; begin Result := $9370DB; end;
class function TColorHelper.MediumSeaGreen: TColor; begin Result := $3CB371; end;
class function TColorHelper.MediumSlateBlue: TColor; begin Result := $7B68EE; end;
class function TColorHelper.MediumSpringGreen: TColor; begin Result := $00FA9A; end;
class function TColorHelper.MediumTurquoise: TColor; begin Result := $48D1CC; end;
class function TColorHelper.MediumVioletRed: TColor; begin Result := $C71585; end;
class function TColorHelper.MidnightBlue: TColor; begin Result := $191970; end;
class function TColorHelper.MintCream: TColor; begin Result := $F5FFFA; end;
class function TColorHelper.MistyRose: TColor; begin Result := $FFE4E1; end;
class function TColorHelper.Moccasin: TColor; begin Result := $FFE4B5; end;
class function TColorHelper.NavajoWhite: TColor; begin Result := $FFDEAD; end;
class function TColorHelper.OldLace: TColor; begin Result := $FDF5E6; end;
class function TColorHelper.OliveDrab: TColor; begin Result := $6B8E23; end;
class function TColorHelper.Orange: TColor; begin Result := $FFA500; end;
class function TColorHelper.OrangeRed: TColor; begin Result := $FF4500; end;
class function TColorHelper.Orchid: TColor; begin Result := $DA70D6; end;
class function TColorHelper.PaleGoldenrod: TColor; begin Result := $EEE8AA; end;
class function TColorHelper.PaleGreen: TColor; begin Result := $98FB98; end;
class function TColorHelper.PaleTurquoise: TColor; begin Result := $AFEEEE; end;
class function TColorHelper.PaleVioletRed: TColor; begin Result := $DB7093; end;
class function TColorHelper.PapayaWhip: TColor; begin Result := $FFEFD5; end;
class function TColorHelper.PeachPuff: TColor; begin Result := $FFDAB9; end;
class function TColorHelper.Peru: TColor; begin Result := $CD853F; end;
class function TColorHelper.Pink: TColor; begin Result := $FFC0CB; end;
class function TColorHelper.Plum: TColor; begin Result := $DDA0DD; end;
class function TColorHelper.PowderBlue: TColor; begin Result := $B0E0E6; end;
class function TColorHelper.RosyBrown: TColor; begin Result := $BC8F8F; end;
class function TColorHelper.RoyalBlue: TColor; begin Result := $4169E1; end;
class function TColorHelper.SaddleBrown: TColor; begin Result := $8B4513; end;
class function TColorHelper.Salmon: TColor; begin Result := $FA8072; end;
class function TColorHelper.SandyBrown: TColor; begin Result := $F4A460; end;
class function TColorHelper.SeaGreen: TColor; begin Result := $2E8B57; end;
class function TColorHelper.SeaShell: TColor; begin Result := $FFF5EE; end;
class function TColorHelper.Sienna: TColor; begin Result := $A0522D; end;
class function TColorHelper.SkyBlue: TColor; begin Result := $87CEEB; end;
class function TColorHelper.SlateBlue: TColor; begin Result := $6A5ACD; end;
class function TColorHelper.SlateGray: TColor; begin Result := $708090; end;
class function TColorHelper.Snow: TColor; begin Result := $FFFAFA; end;
class function TColorHelper.SpringGreen: TColor; begin Result := $00FF7F; end;
class function TColorHelper.SteelBlue: TColor; begin Result := $4682B4; end;
class function TColorHelper.Tan: TColor; begin Result := $D2B48C; end;
class function TColorHelper.Thistle: TColor; begin Result := $D8BFD8; end;
class function TColorHelper.Tomato: TColor; begin Result := $FF6347; end;
class function TColorHelper.Turquoise: TColor; begin Result := $40E0D0; end;
class function TColorHelper.Violet: TColor; begin Result := $EE82EE; end;
class function TColorHelper.Wheat: TColor; begin Result := $F5DEB3; end;
class function TColorHelper.WhiteSmoke: TColor; begin Result := $F5F5F5; end;
class function TColorHelper.YellowGreen: TColor; begin Result := $9ACD32; end;

end.
