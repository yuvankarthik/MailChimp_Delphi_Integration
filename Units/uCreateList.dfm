object fmCreateList: TfmCreateList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create list'
  ClientHeight = 593
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpListDetails: TGroupBox
    Left = 0
    Top = 0
    Width = 538
    Height = 417
    Align = alTop
    Caption = 'List details'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbllistname: TLabel
      Left = 12
      Top = 23
      Width = 67
      Height = 16
      Caption = 'List name *'
    end
    object lblfromname: TLabel
      Left = 275
      Top = 23
      Width = 119
      Height = 16
      Caption = 'Default from name *'
    end
    object lblfrommail: TLabel
      Left = 12
      Top = 70
      Width = 167
      Height = 16
      Caption = 'Default from email address *'
    end
    object lblremindpermission: TLabel
      Left = 12
      Top = 118
      Width = 276
      Height = 16
      Caption = 'Remind people how they signed up to your list *'
    end
    object lblcompany: TLabel
      Left = 12
      Top = 170
      Width = 150
      Height = 16
      Caption = 'Company / Organization *'
    end
    object lbladdr1: TLabel
      Left = 12
      Top = 217
      Width = 69
      Height = 16
      Caption = 'Address 1 *'
    end
    object lblcity: TLabel
      Left = 12
      Top = 319
      Width = 33
      Height = 16
      Caption = 'City *'
    end
    object lblzipcode: TLabel
      Left = 275
      Top = 319
      Width = 107
      Height = 16
      Caption = 'Zip / Postal code *'
    end
    object lblcountry: TLabel
      Left = 12
      Top = 363
      Width = 56
      Height = 16
      Caption = 'Country *'
    end
    object lblphone: TLabel
      Left = 275
      Top = 363
      Width = 96
      Height = 16
      Caption = 'Phone [Optional]'
    end
    object lbladdr2: TLabel
      Left = 12
      Top = 265
      Width = 57
      Height = 16
      Caption = 'Address 2'
    end
    object lblstate: TLabel
      Left = 143
      Top = 319
      Width = 42
      Height = 16
      Caption = 'State *'
    end
    object edlistname: TEdit
      Left = 12
      Top = 42
      Width = 245
      Height = 24
      TabOrder = 0
    end
    object edfromname: TEdit
      Left = 275
      Top = 42
      Width = 238
      Height = 24
      TabOrder = 1
    end
    object edfrommail: TEdit
      Left = 12
      Top = 88
      Width = 501
      Height = 24
      TabOrder = 2
    end
    object memoremindpermission: TMemo
      Left = 12
      Top = 137
      Width = 501
      Height = 8
      TabOrder = 4
      Visible = False
    end
    object edcompany: TEdit
      Left = 12
      Top = 188
      Width = 501
      Height = 24
      TabOrder = 5
    end
    object edaddr1: TEdit
      Left = 12
      Top = 234
      Width = 501
      Height = 24
      TabOrder = 6
    end
    object edcity: TEdit
      Left = 12
      Top = 336
      Width = 117
      Height = 24
      TabOrder = 8
    end
    object edzipcode: TEdit
      Left = 275
      Top = 336
      Width = 238
      Height = 24
      TabOrder = 10
    end
    object edcountry: TEdit
      Left = 12
      Top = 380
      Width = 245
      Height = 24
      TabOrder = 11
    end
    object edphone: TEdit
      Left = 275
      Top = 380
      Width = 238
      Height = 24
      TabOrder = 12
    end
    object edaddr2: TEdit
      Left = 12
      Top = 292
      Width = 501
      Height = 24
      TabOrder = 7
    end
    object edstate: TEdit
      Left = 143
      Top = 336
      Width = 117
      Height = 24
      TabOrder = 9
    end
    object cboRemindPeople: TComboBox
      Left = 12
      Top = 140
      Width = 501
      Height = 24
      TabOrder = 3
    end
  end
  object brpnotifications: TGroupBox
    Left = 0
    Top = 417
    Width = 538
    Height = 141
    Align = alClient
    Caption = 'Notifications'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lblsubscribe: TLabel
      Left = 163
      Top = 33
      Width = 170
      Height = 16
      Caption = 'Email subscribe notification to'
    end
    object lblunsubscribe: TLabel
      Left = 163
      Top = 89
      Width = 184
      Height = 16
      Caption = 'Email unsubscribe notification to'
    end
    object cbsubscribe: TCheckBox
      Left = 12
      Top = 32
      Width = 146
      Height = 17
      Caption = 'Notify on subscribe'
      TabOrder = 0
      OnClick = cbsubscribeClick
    end
    object cbunsubscribe: TCheckBox
      Left = 12
      Top = 88
      Width = 146
      Height = 17
      Caption = 'Notify on unsubscribe'
      TabOrder = 1
      OnClick = cbunsubscribeClick
    end
    object edsubscribeEmail: TEdit
      Left = 164
      Top = 55
      Width = 349
      Height = 24
      TabOrder = 2
    end
    object edunsubscribeEmail: TEdit
      Left = 164
      Top = 111
      Width = 349
      Height = 24
      TabOrder = 3
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 558
    Width = 538
    Height = 35
    Align = alBottom
    TabOrder = 2
    object btnSave: TButton
      Left = 357
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btncancel: TButton
      Left = 438
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = btncancelClick
    end
  end
end
