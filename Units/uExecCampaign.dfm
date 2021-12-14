object fmExecCampaign: TfmExecCampaign
  Left = 0
  Top = 0
  Caption = 'Execute Campaign'
  ClientHeight = 466
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 656
    Height = 64
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 142
      Height = 13
      Caption = 'Select HTML file for Campaign'
    end
    object lblemailsubject: TLabel
      Left = 17
      Top = 42
      Width = 71
      Height = 13
      Caption = 'Email subject *'
    end
    object edemailsubject: TEdit
      Left = 160
      Top = 36
      Width = 321
      Height = 21
      TabOrder = 0
    end
    object edhtmlfile: TEdit
      Left = 160
      Top = 8
      Width = 321
      Height = 21
      TabOrder = 1
    end
    object btnselecthtml: TButton
      Left = 509
      Top = 6
      Width = 26
      Height = 21
      Caption = '...'
      TabOrder = 2
      OnClick = btnselecthtmlClick
    end
    object btn1: TButton
      Left = 509
      Top = 34
      Width = 103
      Height = 25
      Caption = 'Advanced Settings'
      TabOrder = 3
      OnClick = btn1Click
    end
  end
  object pnlEdvan: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 70
    Width = 656
    Height = 112
    Margins.Top = 0
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 1
    Visible = False
    object Label2: TLabel
      Left = 17
      Top = 87
      Width = 54
      Height = 13
      Caption = 'Select list *'
    end
    object lblCampaignName: TLabel
      Left = 18
      Top = 15
      Width = 85
      Height = 13
      Caption = 'Campaign name *'
    end
    object lblfromemailaddr: TLabel
      Left = 16
      Top = 64
      Width = 101
      Height = 13
      Caption = 'From email address *'
    end
    object lblfromname: TLabel
      Left = 17
      Top = 42
      Width = 62
      Height = 13
      Caption = 'From name *'
    end
    object edCampaignName: TEdit
      Left = 160
      Top = 8
      Width = 321
      Height = 21
      TabOrder = 0
    end
    object Edfromemailaddr: TEdit
      Left = 159
      Top = 59
      Width = 321
      Height = 21
      TabOrder = 1
    end
    object edfromname: TEdit
      Left = 160
      Top = 34
      Width = 321
      Height = 21
      TabOrder = 2
    end
    object cbomailchimplist: TComboBox
      Left = 159
      Top = 84
      Width = 321
      Height = 21
      TabOrder = 3
    end
  end
  object pnlHtml: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 185
    Width = 656
    Height = 278
    Align = alClient
    Caption = 'pnlHtml'
    TabOrder = 2
    ExplicitTop = 178
    ExplicitHeight = 285
    object WebBrowser1: TWebBrowser
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 648
      Height = 225
      Hint = 'Preview of HTML code'
      Align = alClient
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 546
      ExplicitHeight = 239
      ControlData = {
        4C000000F9420000411700000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object grp1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 235
      Width = 648
      Height = 39
      Align = alBottom
      TabOrder = 1
      ExplicitTop = 242
      object btnExecute: TButton
        Left = 569
        Top = 7
        Width = 75
        Height = 26
        Caption = 'Execute'
        TabOrder = 0
        OnClick = btnExecuteClick
      end
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultExtension = '*.htm;*.HTML'
    DefaultFolder = 'F:\SimchaL-Program'
    FavoriteLinks = <>
    FileName = 'C:\'
    FileTypes = <
      item
        DisplayName = 'HTML'
        FileMask = '*.html ; *.htm'
      end
      item
        DisplayName = 'All'
        FileMask = '*.*'
      end>
    FileTypeIndex = 0
    Options = []
    Left = 503
    Top = 134
  end
end
