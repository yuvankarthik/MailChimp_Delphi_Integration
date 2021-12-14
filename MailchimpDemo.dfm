object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 619
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 600
    Width = 938
    Height = 19
    Panels = <
      item
        Text = 'Added 25'
        Width = 70
      end
      item
        Text = 'Update 80'
        Width = 80
      end
      item
        Text = 'Deleted 0'
        Width = 80
      end
      item
        Text = 'Last Run Command: Add To list '
        Width = 180
      end
      item
        Text = 'Time '
        Width = 50
      end>
  end
  object pnlList: TPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 281
    Align = alTop
    Caption = 'pnlList'
    TabOrder = 1
    object btn1: TButton
      Left = 227
      Top = 236
      Width = 536
      Height = 23
      Caption = 'Save MemData file to Mydata'
      TabOrder = 0
      OnClick = btn1Click
    end
    object btnAdd: TButton
      Left = 8
      Top = 17
      Width = 100
      Height = 25
      Caption = '&Add'
      TabOrder = 1
      OnClick = btnAddClick
    end
    object btnAddUpdate: TButton
      Left = 108
      Top = 17
      Width = 100
      Height = 25
      Caption = 'Add/ Update'
      TabOrder = 2
      OnClick = btnAddUpdateClick
    end
    object btnAddUpdateDelets: TButton
      Left = 227
      Top = 17
      Width = 100
      Height = 25
      Caption = 'Add Update Delete'
      TabOrder = 3
    end
    object btnCreateList: TButton
      Left = 135
      Top = 61
      Width = 177
      Height = 21
      Caption = 'Create New Mail Chimp List'
      TabOrder = 4
      OnClick = btnCreateListClick
    end
    object Button1: TButton
      Left = 333
      Top = 17
      Width = 100
      Height = 25
      Caption = 'Delete '
      TabOrder = 5
      OnClick = Button1Click
    end
    object DBGrid1: TDBGrid
      Left = 236
      Top = 88
      Width = 527
      Height = 139
      DataSource = DataSource1
      TabOrder = 6
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object lbledtBoxSize1: TLabeledEdit
      Left = 8
      Top = 61
      Width = 121
      Height = 21
      EditLabel.Width = 123
      EditLabel.Height = 13
      EditLabel.Caption = 'New MailChimp List Name '
      TabOrder = 7
    end
    object lst1: TListBox
      Left = 8
      Top = 88
      Width = 152
      Height = 139
      ItemHeight = 13
      Items.Strings = (
        'My old List'
        'My new list'
        'My best contacts ')
      TabOrder = 8
    end
  end
  object pnlCampaign: TPanel
    Left = 0
    Top = 281
    Width = 938
    Height = 192
    Align = alTop
    Caption = 'pnlCampaign'
    TabOrder = 2
    object lstCampaign: TListBox
      Left = 1
      Top = 53
      Width = 318
      Height = 97
      ItemHeight = 13
      Items.Strings = (
        'My Best MailChimpCampaign'
        'Old campaign')
      TabOrder = 0
    end
    object LabeledEdit1: TLabeledEdit
      Left = 1
      Top = 26
      Width = 121
      Height = 21
      EditLabel.Width = 125
      EditLabel.Height = 13
      EditLabel.Caption = 'New Mail chimp Campaign '
      TabOrder = 1
    end
    object btnAddCappaign: TButton
      Left = 128
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Add'
      TabOrder = 2
    end
    object memo1: TMemo
      Left = 352
      Top = 59
      Width = 185
      Height = 89
      Lines.Strings = (
        'copy HTML code or Drop A html file '
        'in this box '
        'and pres Load to Campaign ')
      TabOrder = 3
    end
    object btnLoadToCampaing: TButton
      Left = 355
      Top = 154
      Width = 182
      Height = 25
      Caption = 'Load HTML To Campaing'
      TabOrder = 4
    end
    object FileListBox1: TFileListBox
      Left = 567
      Top = 54
      Width = 145
      Height = 97
      ItemHeight = 13
      TabOrder = 5
    end
  end
  object pnlExacute: TPanel
    Left = 0
    Top = 473
    Width = 938
    Height = 128
    Align = alTop
    Caption = 'pnlExacute'
    TabOrder = 3
    object lst2: TListBox
      Left = 16
      Top = 15
      Width = 105
      Height = 91
      ItemHeight = 13
      Items.Strings = (
        'My old List'
        'My new list'
        'My best contacts ')
      TabOrder = 0
    end
    object lst3: TListBox
      Left = 135
      Top = 18
      Width = 161
      Height = 87
      ItemHeight = 13
      Items.Strings = (
        'My Best MailChimpCampaign'
        'Old campaign')
      TabOrder = 1
    end
    object btnExaute: TButton
      Left = 322
      Top = 28
      Width = 441
      Height = 64
      Caption = 
        'Select List Select Campign and press button in order to send To ' +
        'list '
      TabOrder = 2
    end
    object btnSetup: TButton
      Left = 769
      Top = 30
      Width = 160
      Height = 62
      Caption = 'Setup MailChimp Acount Info '
      TabOrder = 3
    end
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'LASTNAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'address'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'city'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'State'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'zip'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'email'
        DataType = ftString
        Size = 25
      end
      item
        Name = 'ID'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 847
    Top = 37
    Content = {
      414442530F009A19D4030000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C006500310005000A0000005400610062006C0065
      00060000000000070000080032000000090000FF0AFF0B0400100000004C0041
      00530054004E0041004D0045000500100000004C004100530054004E0041004D
      0045000C00010000000E000D000F001400000010000111000112000113000114
      00011500011600100000004C004100530054004E0041004D0045001700140000
      00FEFF0B0400080000004E0041004D0045000500080000004E0041004D004500
      0C00020000000E000D000F000F00000010000111000112000113000114000115
      00011600080000004E0041004D00450017000F000000FEFF0B04000E00000061
      0064006400720065007300730005000E00000061006400640072006500730073
      000C00030000000E000D000F0014000000100001110001120001130001140001
      15000116000E0000006100640064007200650073007300170014000000FEFF0B
      040008000000630069007400790005000800000063006900740079000C000400
      00000E000D000F000A0000001000011100011200011300011400011500011600
      08000000630069007400790017000A000000FEFF0B04000A0000005300740061
      007400650005000A000000530074006100740065000C00050000000E000D000F
      000A00000010000111000112000113000114000115000116000A000000530074
      0061007400650017000A000000FEFF0B0400060000007A006900700005000600
      00007A00690070000C00060000000E000D000F00050000001000011100011200
      011300011400011500011600060000007A0069007000170005000000FEFF0B04
      000A00000065006D00610069006C0005000A00000065006D00610069006C000C
      00070000000E000D000F00190000001000011100011200011300011400011500
      0116000A00000065006D00610069006C00170019000000FEFF0B040004000000
      49004400050004000000490044000C00080000000E000D000F00140000001000
      0111000112000113000114000115000116000400000049004400170014000000
      FEFEFF18FEFF19FEFF1AFF1B1C0000000000FF1D000008000000484F4C4F5749
      4E5A01000500000041444E455202000E00000031383820534944452044524956
      450400020000004E4A050005000000313135313606000D00000031323540676D
      61696C2E636F6D070003000000313131FEFEFF1B1C0001000000FF1D06001400
      00007468656C6173746F6E6540676D61696C2E636F6D070003000000323232FE
      FEFEFEFEFF1EFEFF1F20000B000000FF21FEFEFE0E004D0061006E0061006700
      650072001E005500700064006100740065007300520065006700690073007400
      7200790012005400610062006C0065004C006900730074000A00540061006200
      6C00650008004E0061006D006500140053006F0075007200630065004E006100
      6D0065000A0054006100620049004400240045006E0066006F00720063006500
      43006F006E00730074007200610069006E00740073001E004D0069006E006900
      6D0075006D004300610070006100630069007400790018004300680065006300
      6B004E006F0074004E0075006C006C00140043006F006C0075006D006E004C00
      6900730074000C0043006F006C0075006D006E00100053006F00750072006300
      65004900440018006400740041006E007300690053007400720069006E006700
      1000440061007400610054007900700065000800530069007A00650014005300
      65006100720063006800610062006C006500120041006C006C006F0077004E00
      75006C006C000800420061007300650014004F0041006C006C006F0077004E00
      75006C006C0012004F0049006E0055007000640061007400650010004F004900
      6E00570068006500720065001A004F0072006900670069006E0043006F006C00
      4E0061006D006500140053006F007500720063006500530069007A0065001C00
      43006F006E00730074007200610069006E0074004C0069007300740010005600
      6900650077004C006900730074000E0052006F0077004C006900730074000600
      52006F0077000A0052006F0077004900440010004F0072006900670069006E00
      61006C001800520065006C006100740069006F006E004C006900730074001C00
      55007000640061007400650073004A006F00750072006E0061006C0012005300
      61007600650050006F0069006E0074000E004300680061006E00670065007300}
    object strngfldFDMemTable1ID: TStringField
      DisplayWidth = 50
      FieldName = 'ID'
    end
    object strngfldFDMemTable1email: TStringField
      DisplayWidth = 10
      FieldName = 'email'
      Size = 25
    end
    object strngfldFDMemTable1LASTNAME: TStringField
      DisplayWidth = 24
      FieldName = 'LASTNAME'
    end
    object strngfldFDMemTable1NAME: TStringField
      DisplayWidth = 18
      FieldName = 'NAME'
      Size = 15
    end
    object strngfldFDMemTable1address: TStringField
      DisplayWidth = 24
      FieldName = 'address'
    end
    object strngfldFDMemTable1city: TStringField
      DisplayWidth = 12
      FieldName = 'city'
      Size = 10
    end
    object strngfldFDMemTable1State: TStringField
      DisplayWidth = 12
      FieldName = 'State'
      Size = 10
    end
    object strngfldFDMemTable1zip: TStringField
      DisplayWidth = 6
      FieldName = 'zip'
      Size = 5
    end
  end
  object DataSource1: TDataSource
    DataSet = FDMemTable1
    Left = 852
    Top = 95
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 736
    Top = 8
  end
end
