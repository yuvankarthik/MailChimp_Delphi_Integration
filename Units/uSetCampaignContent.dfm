object fmSetCampaignContent: TfmSetCampaignContent
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Set Campaign Content'
  ClientHeight = 430
  ClientWidth = 443
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
  object lblcampaignlist: TLabel
    Left = 24
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Select campaign *'
  end
  object lblmemocaption: TLabel
    Left = 424
    Top = 54
    Width = 103
    Height = 13
    Caption = 'Select content type *'
    Visible = False
  end
  object Label1: TLabel
    Left = 24
    Top = 125
    Width = 75
    Height = 13
    Caption = 'HTML content *'
  end
  object Label2: TLabel
    Left = 24
    Top = 54
    Width = 87
    Height = 13
    Caption = 'Plain Text content'
  end
  object cbocampaignlist: TComboBox
    Left = 24
    Top = 27
    Width = 401
    Height = 21
    TabOrder = 0
  end
  object memoHTMLContent: TMemo
    Left = 24
    Top = 144
    Width = 401
    Height = 97
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object btnupdate: TButton
    Left = 350
    Top = 247
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 2
    OnClick = btnupdateClick
  end
  object cboContentType: TComboBox
    Left = 424
    Top = 73
    Width = 401
    Height = 21
    TabOrder = 3
    Visible = False
    OnChange = cboContentTypeChange
    Items.Strings = (
      'plain-text'
      'html')
  end
  object WebBrowser1: TWebBrowser
    Left = 24
    Top = 278
    Width = 401
    Height = 141
    Hint = 'Preview of HTML code'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    ControlData = {
      4C00000072290000930E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object BtnPreviewHTML: TButton
    Left = 24
    Top = 247
    Width = 86
    Height = 25
    Caption = 'Preview HTML'
    TabOrder = 5
    OnClick = BtnPreviewHTMLClick
  end
  object memPlainText: TMemo
    Left = 24
    Top = 73
    Width = 401
    Height = 46
    Lines.Strings = (
      '')
    TabOrder = 6
  end
end
