object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 343
  ClientWidth = 276
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Pitch = fpFixed
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 20
  object mStat: TMemo
    Left = 0
    Top = 41
    Width = 276
    Height = 302
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 6
    ExplicitTop = 88
    ExplicitWidth = 270
    ExplicitHeight = 216
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 276
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 84
    ExplicitTop = 272
    ExplicitWidth = 185
    object eDivisible: TEdit
      Left = 12
      Top = 8
      Width = 69
      Height = 28
      NumbersOnly = True
      TabOrder = 0
      Text = '42'
      TextHint = '(Enter number up to 10000)'
      OnChange = eDivisibleChange
    end
    object eDivisor: TEdit
      Left = 87
      Top = 8
      Width = 68
      Height = 28
      NumbersOnly = True
      TabOrder = 1
      Text = '2'
      TextHint = '(Enter number up to 10000)'
      OnChange = eDivisibleChange
    end
    object bCalc: TButton
      Left = 167
      Top = 7
      Width = 94
      Height = 28
      Caption = 'Calc'
      Default = True
      Enabled = False
      TabOrder = 2
      OnClick = bCalcClick
    end
  end
end
