object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Demonstracao StringHelper - Class Helpers'
  ClientHeight = 350
  ClientWidth = 600
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lblTexto: TLabel
    Left = 16
    Top = 16
    Width = 81
    Height = 15
    Caption = 'Texto de Teste:'
  end
  object lblNumero: TLabel
    Left = 16
    Top = 64
    Width = 93
    Height = 15
    Caption = 'Numero de Teste:'
  end
  object edtTexto: TEdit
    Left = 16
    Top = 37
    Width = 350
    Height = 23
    TabOrder = 0
    Text = 'Hello World - Teste de String Helper!'
  end
  object edtNumero: TEdit
    Left = 16
    Top = 85
    Width = 150
    Height = 23
    TabOrder = 1
    Text = '123.45'
  end
  object btnTest: TButton
    Left = 400
    Top = 37
    Width = 75
    Height = 25
    Caption = 'Teste'
    TabOrder = 2
    OnClick = btnTestClick
  end
  object btnReverse: TButton
    Left = 16
    Top = 120
    Width = 100
    Height = 25
    Caption = 'Reverse'
    TabOrder = 3
    OnClick = btnReverseClick
  end
  object btnRemoveSpaces: TButton
    Left = 122
    Top = 120
    Width = 100
    Height = 25
    Caption = 'RemoveSpaces'
    TabOrder = 4
    OnClick = btnRemoveSpacesClick
  end
  object btnCapitalize: TButton
    Left = 228
    Top = 120
    Width = 100
    Height = 25
    Caption = 'Capitalize'
    TabOrder = 5
    OnClick = btnCapitalizeClick
  end
  object btnOnlyNumbers: TButton
    Left = 334
    Top = 120
    Width = 100
    Height = 25
    Caption = 'OnlyNumbers'
    TabOrder = 6
    OnClick = btnOnlyNumbersClick
  end
  object btnWordCount: TButton
    Left = 16
    Top = 151
    Width = 100
    Height = 25
    Caption = 'WordCount'
    TabOrder = 7
    OnClick = btnWordCountClick
  end
  object btnIsEmpty: TButton
    Left = 122
    Top = 151
    Width = 100
    Height = 25
    Caption = 'IsEmpty'
    TabOrder = 8
    OnClick = btnIsEmptyClick
  end
  object btnToInteger: TButton
    Left = 172
    Top = 85
    Width = 75
    Height = 23
    Caption = 'ToInteger'
    TabOrder = 9
    OnClick = btnToIntegerClick
  end
end
