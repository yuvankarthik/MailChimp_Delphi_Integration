object fmListMember: TfmListMember
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Update member list'
  ClientHeight = 340
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object pnlBottom: TPanel
    Left = 0
    Top = 303
    Width = 403
    Height = 37
    Align = alBottom
    TabOrder = 0
    object btnSubscribe: TButton
      Left = 292
      Top = 6
      Width = 97
      Height = 25
      Caption = 'Subscribe'
      TabOrder = 0
      OnClick = btnSubscribeClick
    end
    object cbupdatemember: TCheckBox
      Left = 7
      Top = 0
      Width = 272
      Height = 39
      Caption = 'If this email is already on my lsit, update their profile.'
      Checked = True
      State = cbChecked
      TabOrder = 1
      Visible = False
      WordWrap = True
    end
  end
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 403
    Height = 303
    Align = alClient
    TabOrder = 1
    Tabs.Strings = (
      'Single member update')
    TabIndex = 0
    OnChange = TabControl1Change
    object pnlclient_multimemberupdate: TPanel
      Left = 4
      Top = 27
      Width = 395
      Height = 272
      Align = alClient
      TabOrder = 1
      Visible = False
      object lblmemupdatecaption: TLabel
        Left = 15
        Top = 56
        Width = 353
        Height = 16
        Caption = 'Copy and paste subscriber info [CSV or Tab delimited text ] *'
      end
      object lbltips: TLabel
        Left = 15
        Top = 230
        Width = 299
        Height = 16
        Caption = '2 :  testuser@testcmpny.com,testFname,TestLname'
        WordWrap = True
      end
      object lblListItems_M: TLabel
        Left = 15
        Top = 4
        Width = 125
        Height = 16
        Caption = 'Select list to update *'
      end
      object memoUpdateMembers: TMemo
        Left = 15
        Top = 78
        Width = 349
        Height = 146
        TabOrder = 0
      end
      object cboListItems_M: TComboBox
        Left = 15
        Top = 26
        Width = 349
        Height = 24
        TabOrder = 1
      end
    end
    object pnlclient_singleupdate: TPanel
      Left = 4
      Top = 27
      Width = 395
      Height = 272
      Align = alClient
      TabOrder = 0
      object lbllname: TLabel
        Left = 15
        Top = 153
        Width = 60
        Height = 16
        Caption = 'Last Name'
      end
      object lblfname: TLabel
        Left = 15
        Top = 106
        Width = 62
        Height = 16
        Caption = 'First Name'
      end
      object lblemailaddr: TLabel
        Left = 15
        Top = 56
        Width = 93
        Height = 16
        Caption = 'Email Address *'
      end
      object lblcbolistitems: TLabel
        Left = 15
        Top = 4
        Width = 125
        Height = 16
        Caption = 'Select list to update *'
        Visible = False
      end
      object edemailaddr: TEdit
        Left = 15
        Top = 78
        Width = 361
        Height = 24
        TabOrder = 1
      end
      object edfname: TEdit
        Left = 15
        Top = 128
        Width = 361
        Height = 24
        TabOrder = 2
      end
      object edlname: TEdit
        Left = 15
        Top = 175
        Width = 361
        Height = 24
        TabOrder = 3
      end
      object cboListItems: TComboBox
        Left = 15
        Top = 26
        Width = 361
        Height = 24
        TabOrder = 0
        Visible = False
      end
    end
  end
end
