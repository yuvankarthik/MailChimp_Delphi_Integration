object fmCreateCamapign: TfmCreateCamapign
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create / Update campaign'
  ClientHeight = 241
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblCampaignName: TLabel
    Left = 24
    Top = 35
    Width = 85
    Height = 13
    Caption = 'Campaign name *'
  end
  object lblmailto: TLabel
    Left = 24
    Top = 177
    Width = 115
    Height = 13
    Caption = 'Who are you sending to'
    Visible = False
  end
  object lblemailsubject: TLabel
    Left = 24
    Top = 68
    Width = 71
    Height = 13
    Caption = 'Email subject *'
  end
  object lblfromname: TLabel
    Left = 24
    Top = 105
    Width = 62
    Height = 13
    Caption = 'From name *'
  end
  object lblfromemailaddr: TLabel
    Left = 24
    Top = 145
    Width = 101
    Height = 13
    Caption = 'From email address *'
  end
  object lblcampaignlist: TLabel
    Left = 23
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Select campaign *'
    Visible = False
  end
  object edCampaignName: TEdit
    Left = 160
    Top = 35
    Width = 321
    Height = 21
    TabOrder = 1
  end
  object cboMailChimpList: TComboBox
    Left = 160
    Top = 172
    Width = 321
    Height = 21
    TabOrder = 2
    Visible = False
  end
  object edemailsubject: TEdit
    Left = 160
    Top = 65
    Width = 321
    Height = 21
    TabOrder = 3
  end
  object edfromname: TEdit
    Left = 160
    Top = 105
    Width = 321
    Height = 21
    TabOrder = 4
  end
  object Edfromemailaddr: TEdit
    Left = 160
    Top = 145
    Width = 321
    Height = 21
    TabOrder = 5
  end
  object btnCreate: TButton
    Left = 408
    Top = 208
    Width = 73
    Height = 25
    Caption = 'Create '
    TabOrder = 6
    OnClick = btnCreateClick
  end
  object cbocampaignlist: TComboBox
    Left = 160
    Top = 8
    Width = 321
    Height = 21
    TabOrder = 0
    Visible = False
  end
end
