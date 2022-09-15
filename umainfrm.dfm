object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Long numbers calculator'
  ClientHeight = 493
  ClientWidth = 619
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
    Top = 77
    Width = 619
    Height = 416
    Align = alClient
    ScrollBars = ssVertical
    TabOrder = 0
    WantReturns = False
    ExplicitWidth = 625
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 619
    Height = 77
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 461
    DesignSize = (
      619
      77)
    object eDivisible: TEdit
      Left = 12
      Top = 7
      Width = 500
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 0
      Text = 
        '1298319238192381293812391823912839128381927423847234423423423948' +
        '2039482034'
      OnChange = eDivisibleChange
    end
    object eDivisor: TEdit
      Left = 12
      Top = 41
      Width = 500
      Height = 28
      Anchors = [akLeft, akTop, akRight]
      NumbersOnly = True
      TabOrder = 1
      Text = '32487234827348237482374823748234728347 '
      OnChange = eDivisibleChange
    end
    object bCalc: TButton
      Left = 515
      Top = 7
      Width = 94
      Height = 28
      Anchors = [akTop, akRight]
      Caption = 'Calc'
      Default = True
      Enabled = False
      TabOrder = 2
      OnClick = bCalcClick
    end
  end
end
