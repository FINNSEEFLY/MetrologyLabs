object fmMain: TfmMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = #1056#1072#1089#1095#1077#1090' '#1084#1077#1090#1088#1080#1082' '#1082#1086#1076#1072
  ClientHeight = 611
  ClientWidth = 1559
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlbtnbox: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 611
    Align = alLeft
    TabOrder = 0
    object bbOpenFile: TButton
      Left = 1
      Top = 453
      Width = 351
      Height = 50
      Align = alBottom
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = bbOpenFileClick
    end
    object bbResearch: TButton
      Left = 1
      Top = 503
      Width = 351
      Height = 57
      Align = alBottom
      Caption = #1048#1089#1089#1083#1077#1076#1086#1074#1072#1090#1100' '#1082#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bbResearchClick
    end
    object pnlResults: TPanel
      Left = 1
      Top = 1
      Width = 351
      Height = 41
      Align = alTop
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1080#1089#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object mmResults: TMemo
      Left = 1
      Top = 42
      Width = 351
      Height = 339
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 3
    end
    object btnExit: TButton
      Left = 1
      Top = 560
      Width = 351
      Height = 50
      Align = alBottom
      Caption = #1042#1099#1093#1086#1076
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = btnExitClick
    end
    object cmbMode: TComboBox
      Left = 1
      Top = 422
      Width = 351
      Height = 31
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 5
      Text = #1052#1077#1090#1088#1080#1082#1072' '#1061#1086#1083#1089#1090#1077#1076#1072
      Items.Strings = (
        #1052#1077#1090#1088#1080#1082#1072' '#1061#1086#1083#1089#1090#1077#1076#1072
        #1052#1077#1090#1088#1080#1082#1080' '#1044#1078#1080#1083#1073#1072
        #1052#1077#1090#1088#1080#1082#1080' '#1089#1083#1086#1078#1085#1086#1089#1090#1080' '#1087#1086#1090#1086#1082#1072' '#1076#1072#1085#1085#1099#1093)
    end
    object pnlmode: TPanel
      Left = 1
      Top = 381
      Width = 351
      Height = 41
      Align = alBottom
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1088#1077#1078#1080#1084
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
  end
  object pnlcodebox: TPanel
    Left = 353
    Top = 0
    Width = 473
    Height = 611
    Align = alLeft
    TabOrder = 1
    object pnlCode: TPanel
      Left = 1
      Top = 1
      Width = 471
      Height = 41
      Align = alTop
      Caption = #1048#1089#1089#1083#1077#1076#1091#1077#1084#1099#1081' '#1082#1086#1076':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object mmCode: TMemo
      Left = 1
      Top = 42
      Width = 471
      Height = 568
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object pnlresbox: TPanel
    Left = 826
    Top = 0
    Width = 733
    Height = 611
    Align = alClient
    TabOrder = 2
    ExplicitWidth = 724
    object sgResults: TStringGrid
      Left = 1
      Top = 42
      Width = 731
      Height = 568
      Align = alClient
      ColCount = 4
      DefaultColWidth = 100
      RowCount = 1
      FixedRows = 0
      TabOrder = 0
      ExplicitWidth = 722
    end
    object pnlResTable: TPanel
      Left = 1
      Top = 1
      Width = 731
      Height = 41
      Align = alTop
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1086#1074
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 722
    end
  end
  object odOpenFile: TOpenDialog
    Filter = 'Groovy file|*.groovy'
    Left = 312
    Top = 8
  end
end
