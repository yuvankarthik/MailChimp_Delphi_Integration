object fmMailChimpAccount: TfmMailChimpAccount
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Settings'
  ClientHeight = 710
  ClientWidth = 412
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 412
    Height = 177
    Align = alTop
    Caption = 'Account information'
    TabOrder = 0
    object lblURL: TLabel
      Left = 24
      Top = 24
      Width = 19
      Height = 13
      Caption = 'URL'
    end
    object lblauthuser: TLabel
      Left = 24
      Top = 51
      Width = 73
      Height = 13
      Caption = 'Auth username'
    end
    object lblauthpwd: TLabel
      Left = 24
      Top = 105
      Width = 72
      Height = 13
      Caption = 'Auth password'
      Visible = False
    end
    object lblAPIkey: TLabel
      Left = 24
      Top = 78
      Width = 37
      Height = 13
      Caption = 'API key'
    end
    object lblapppwd: TLabel
      Left = 24
      Top = 105
      Width = 90
      Height = 13
      Caption = 'Setup password'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edURL: TEdit
      Left = 120
      Top = 24
      Width = 265
      Height = 21
      TabOrder = 0
      Text = 'https://us15.api.mailchimp.com/3.0'
    end
    object edauthuname: TEdit
      Left = 120
      Top = 51
      Width = 265
      Height = 21
      TabOrder = 1
    end
    object edauthpwd: TEdit
      Left = 120
      Top = 105
      Width = 265
      Height = 21
      TabOrder = 2
      Visible = False
    end
    object edAPIkey: TEdit
      Left = 120
      Top = 78
      Width = 265
      Height = 21
      TabOrder = 3
      OnExit = edAPIkeyExit
    end
    object btnsave: TButton
      Left = 310
      Top = 140
      Width = 75
      Height = 25
      Caption = 'Save'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnsaveClick
    end
    object btnTestConnect: TButton
      Left = 205
      Top = 140
      Width = 99
      Height = 25
      Caption = 'Test Connection'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = btnTestConnectClick
    end
    object cbbasic_auth: TCheckBox
      Left = 24
      Top = 140
      Width = 129
      Height = 17
      Caption = 'Basic authentication'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object edapppassword: TEdit
      Left = 120
      Top = 105
      Width = 161
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 7
      TextHint = 'Setup window password'
    end
    object chkshowpwd: TCheckBox
      Left = 289
      Top = 107
      Width = 96
      Height = 17
      Caption = 'show password'
      TabOrder = 8
      OnClick = chkshowpwdClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 177
    Width = 412
    Height = 417
    Align = alClient
    Caption = 'List Information'
    TabOrder = 1
    object lblcompany: TLabel
      Left = 24
      Top = 115
      Width = 119
      Height = 13
      Caption = 'Company / Organization '
    end
    object lbladdr1: TLabel
      Left = 24
      Top = 164
      Width = 51
      Height = 13
      Caption = 'Address 1 '
    end
    object lbladdr2: TLabel
      Left = 24
      Top = 213
      Width = 48
      Height = 13
      Caption = 'Address 2'
    end
    object lblcity: TLabel
      Left = 24
      Top = 265
      Width = 22
      Height = 13
      Caption = 'City '
    end
    object lblstate: TLabel
      Left = 215
      Top = 262
      Width = 29
      Height = 13
      Caption = 'State '
    end
    object lblzipcode: TLabel
      Left = 24
      Top = 329
      Width = 82
      Height = 13
      Caption = 'Zip / Postal code '
    end
    object lblcountry: TLabel
      Left = 24
      Top = 296
      Width = 42
      Height = 13
      Caption = 'Country '
    end
    object lblphone: TLabel
      Left = 24
      Top = 356
      Width = 33
      Height = 13
      Caption = 'Phone '
    end
    object lblfrommail: TLabel
      Left = 24
      Top = 66
      Width = 131
      Height = 13
      Caption = 'Default from email address '
    end
    object lblfromname: TLabel
      Left = 24
      Top = 32
      Width = 92
      Height = 13
      Caption = 'Default from name '
    end
    object edcompany: TEdit
      Left = 24
      Top = 134
      Width = 361
      Height = 21
      TabOrder = 2
    end
    object edaddr1: TEdit
      Left = 24
      Top = 183
      Width = 361
      Height = 21
      TabOrder = 3
    end
    object edaddr2: TEdit
      Left = 24
      Top = 232
      Width = 361
      Height = 21
      TabOrder = 4
    end
    object edcity: TEdit
      Left = 76
      Top = 262
      Width = 117
      Height = 21
      TabOrder = 5
    end
    object edstate: TEdit
      Left = 268
      Top = 262
      Width = 117
      Height = 21
      TabOrder = 6
    end
    object edzipcode: TEdit
      Left = 128
      Top = 353
      Width = 257
      Height = 21
      TabOrder = 8
    end
    object edcountry: TEdit
      Left = 76
      Top = 293
      Width = 309
      Height = 21
      TabOrder = 7
    end
    object edphone: TEdit
      Left = 128
      Top = 323
      Width = 257
      Height = 21
      TabOrder = 9
    end
    object edfrommail: TEdit
      Left = 24
      Top = 85
      Width = 361
      Height = 21
      TabOrder = 1
    end
    object edfromname: TEdit
      Left = 121
      Top = 29
      Width = 264
      Height = 21
      TabOrder = 0
    end
    object btnSaveListInfo: TButton
      Left = 248
      Top = 385
      Width = 137
      Height = 25
      Caption = 'Save list information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = btnSaveListInfoClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 594
    Width = 412
    Height = 116
    Align = alBottom
    Caption = 'Campaign form settings'
    TabOrder = 2
    object Label1: TLabel
      Left = 24
      Top = 53
      Width = 82
      Height = 13
      Caption = 'Select default list'
    end
    object cboxSimpleMode: TCheckBox
      Left = 24
      Top = 22
      Width = 129
      Height = 17
      Caption = '    Simple mode'
      TabOrder = 0
    end
    object cbodefaultlist: TComboBox
      Left = 128
      Top = 50
      Width = 257
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 192
      Top = 77
      Width = 193
      Height = 25
      Caption = 'Save campaign form settings'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = Button1Click
    end
  end
end
