object frmDatabaseExample: TfrmDatabaseExample
  Left = 0
  Top = 0
  Caption = 'Database Helpers - Demonstra'#231#227'o FDQuery e Field Helpers'
  ClientHeight = 550
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 784
    Height = 481
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnTestarFDQueryHelper: TButton
    Left = 8
    Top = 495
    Width = 150
    Height = 25
    Caption = 'Testar FDQuery Helper'
    TabOrder = 1
    OnClick = btnTestarFDQueryHelperClick
  end
  object btnTestarFieldHelper: TButton
    Left = 164
    Top = 495
    Width = 150
    Height = 25
    Caption = 'Testar Field Helper'
    TabOrder = 2
    OnClick = btnTestarFieldHelperClick
  end
  object btnExemplosAvancados: TButton
    Left = 320
    Top = 495
    Width = 150
    Height = 25
    Caption = 'Exemplos Avan'#231'ados'
    TabOrder = 3
    OnClick = btnExemplosAvancadosClick
  end
  object btnCriarDadosDemo: TButton
    Left = 476
    Top = 495
    Width = 150
    Height = 25
    Caption = 'Criar Dados Demo'
    TabOrder = 4
    OnClick = btnCriarDadosDemoClick
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\temp\exemplo.mdb'
      'DriverID=MSAcc')
    LoginPrompt = False
    Left = 720
    Top = 40
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 720
    Top = 88
  end
end
