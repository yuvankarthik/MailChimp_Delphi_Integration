unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FireDAC.Stan.StorageBin, Vcl.ExtCtrls,
  Vcl.FileCtrl,
  JSON, IdHTTP, IdCoderMIME, IdURI, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient,
  uListResp, uCreateList, uCreateListJSON, uListMember, uCreateCampaign,
  uCampaign, uSetCampaignContent, inifiles, uSettings, FireDAC.DApt,
  FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, uCompress,
  uListMemberJSON, uExecCampaign, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, cxTextEdit, cxMaskEdit, cxButtonEdit, Vcl.DBCtrls, Vcl.Buttons,
  IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL;

const
  InputBoxMessage = WM_USER + 200;

type
  TForm6 = class(TForm)
    ListDBGrid1: TDBGrid;
    ListFDMemTable: TFDMemTable;
    StatusBar1: TStatusBar;
    MailChimpListCampaign: TListBox;
    DataSource1: TDataSource;
    strngfldFDMemTable1LASTNAME: TStringField;
    strngfldFDMemTable1NAME: TStringField;
    strngfldFDMemTable1address: TStringField;
    strngfldFDMemTable1city: TStringField;
    strngfldFDMemTable1State: TStringField;
    strngfldFDMemTable1zip: TStringField;
    strngfldFDMemTable1email: TStringField;
    strngfldFDMemTable1ID: TStringField;
    btnAddCappaign: TButton;
    btnLoadToCampaing: TButton;
    FileListBox1: TFileListBox;
    pnlExacute: TPanel;
    MailChimpList2: TListBox;
    MailChimpCampaign2: TListBox;
    btnExaute: TButton;
    IdHTTP1: TIdHTTP;
    btnupdate: TButton;
    gbLists: TGroupBox;
    gbcampaign: TGroupBox;
    gbexec: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    cbUpdateLocalmember: TCheckBox;
    btnrefresh: TcxButtonEdit;
    btnSetup: TcxButtonEdit;
    pnlXsimple: TPanel;
    pnlList: TGroupBox;
    btnAddUpdate: TButton;
    btnAddUpdateDelets: TButton;
    btnCreateList: TButton;
    Button1: TButton;
    lbledtBoxSize1: TLabeledEdit;
    MailChimpLists: TListBox;
    BtnDelALL: TButton;
    pnlSettings: TPanel;
    grpBTNs: TGroupBox;
    lbl1: TLabel;
    btnAdd: TSpeedButton;
    btnAddandExecute_Campaign: TSpeedButton;
    btnDelCampaigns: TSpeedButton;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    procedure btnAddClick(Sender: TObject);
    procedure btnAddUpdateClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCreateListClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAddCappaignClick(Sender: TObject);
    procedure btnLoadToCampaingClick(Sender: TObject);
    procedure btnupdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExauteClick(Sender: TObject);
    procedure btnSetupClick(Sender: TObject);
    procedure btnrefreshClick(Sender: TObject);
    procedure BtnDelALLClick(Sender: TObject);
    procedure btnDelCampaignsClick(Sender: TObject);
    procedure btnAddandExecute_CampaignClick(Sender: TObject);
    procedure pnlListClick(Sender: TObject);
  private

    ListResp: TList;
    CreateListResp: TCreateListJSON;
    GetListResp: TGetListClass;
    ErrorListResp: TDelListClass;
    ListMemberResp: TListMemberClass;
    GetListMemberResp: TGetListMemberClass;
    ErrClass: TListErrorsClass;

    CreateCampaignClass: TCreateCampaign;
    RespCreateCampaign: TRespCreateCampaign;
    RespGetCampaign: TGetCampaign;
    RespSetCampaignContent: TRespSetCampaignContent;
    SimpleMode, Basic_Auth, IsTrace, ISBulkListDEL, ISBulkCampaignDEL: Boolean;
    SimpleCampaign_Exec: Boolean;

    FDCol_StrList, MailChimpStrLists, MailChimpCampaignLists: TStringList;
    StartPath: String;

    HttpURL, Lists_HttpURL, Campaign_HttpURL, API_KEY, Auth_UserName,
      Auth_Password: String;

    ListAction, CampaignAction, SetupWinPwd, CampaignDefaultList: String;
    DefaultFromName, DefaultFromEmail: String;

    procedure AddList(IP_Json_Str: WideString);
    procedure CreateFDColList(Col_StrList: TStringList);
    function NewFDMemTable: TFDMemTable;
    function GetNthString(SrcString: String; StrPos: Integer): String;
    // procedure UpdateJSONResultIntoFDMemTable;
    procedure UpdateMailChimpListsAndFDMemTable;
    procedure DeleteList(ListID: String);
    procedure UpdateList(List_Id: String; InputJSONStr: WideString);
    procedure AddorUpdateMembersinList(List_Id: String;
      InputJSONStr: WideString);
    procedure DeleteMembersFromList(List_Id, subscriber_hash: String);
    procedure UpdateFDMemTableandGrid(Member_ListID, Address, City, State,
      Zip: String);
    function GetMailIDsFromList(IP_ListID: String): WideString;
    procedure CheckMailidsAndDeleteFromMailChimp(Member_ListID, subscriber_hash,
      MailIds: String);
    procedure CreateCampaign(Inp_JSONStr: WideString);
    procedure UpdateMailChimpCampaign;
    procedure Setcampaigncontent(Campaign_ID: String; InputJSONStr: WideString);
    procedure UpdateCampaign(CampaignId: String; Inp_JSONStr: WideString);
    function GetMailChimpCampaign(Campaign_ID: String = ''): String;
    procedure SendMail(CampaignId: String);
    procedure LoadSettings;
    function DoConnection(HttpURL, A_UserName, A_Password: String;
      Basic_Auth: Boolean): Boolean;
    procedure WriteLog(Msg: String);
    procedure InputBoxSetPasswordChar(var Msg: TMessage);
      message InputBoxMessage;
    procedure LoadListandCampaign;
    procedure LoadSetupPwd;
    function DoDummyConnection(HttpURL, A_UserName, A_Password: String;
      Basic_Auth: Boolean): Boolean;
    procedure AddorUpdateLocalMemberIntoMailChimp(UpdateFlag: Boolean);
    procedure DeleteCampaign(CampaignId: String);
    procedure CreateandExecuteCampaign(Sel_List, Sel_Campaign: String);
    procedure ExecuteCampaign(Sel_List, Sel_Campaign: String);
    procedure LoadSimpleModeCampaign;

    { Private declarations }
  public
    { Public declarations }
  end;

  // added by KarthikThirumoorthi
  // Const
  // Lists_HttpURL = 'https://us15.api.mailchimp.com/3.0/lists';
  // Campaign_HttpURL = 'https://us15.api.mailchimp.com/3.0/campaigns';
  // API_KEY = 'e8b164b319d94fa2bc00e1678debb5a0';
  // Auth_UserName = 'dummy';
  // Auth_Password = API_KEY;

Const
  Max_Count = '1000';
  Offset_Count = '?offset=0&count=' + Max_Count;

var
  Form6: TForm6;

implementation

{$R *.dfm}

procedure TForm6.btn1Click(Sender: TObject);
begin
  ListFDMemTable.SaveToFile('myData');
end;

procedure TForm6.btnAddClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  EMsg, LEMsg: String;
  fmListMember: TfmListMember;
begin
  try
    EMsg := '';
    fmListMember := nil;
    if Not cbUpdateLocalmember.Checked then
    begin
      // Application.CreateForm(TfmListMember, fmListMember);
      fmListMember := TfmListMember.Create(self);
      fmListMember.CboListItems.Items := MailChimpLists.Items;
      fmListMember.CboListItems_M.Items := MailChimpLists.Items;
      fmListMember.MCStrList := MailChimpStrLists;
      fmListMember.cboListItems.Text := CampaignDefaultList;
      fmListMember.ShowModal;

      While (fmListMember.ModalResult = mrOk) do
      begin
        try
          LEMsg := '';
          Inp_JSONStr := fmListMember.Input_JSONStr;
          if Inp_JSONStr <> '' then
            AddorUpdateMembersinList(fmListMember.Selected_ListID, Inp_JSONStr);
        except
          on e: exception do
            LEMsg := e.Message;
        end;
        if LEMsg <> '' then
        begin
          ShowMessage('List member not created/updated, try again');
          fmListMember.ShowModal;
        end
        else
        begin
          ShowMessage('List member created/updated successfully.');
          Break;
        end;
      end;
    end
    else
    begin
      if MessageDlg
        ('Do you want to Add/Update Local list members into MailChimp ?',
        mtConfirmation, [mbYes, mbNo], 1) = mrYes then
      begin
        AddorUpdateLocalMemberIntoMailChimp(False);
      end
      else
        Exit;
    end;

  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmListMember) then
  begin
    fmListMember.free;
    fmListMember := nil;
    // FreeAndNil(fmListMember);
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
  // ShowMessage('This should only ADD new emails to list and return a how many updated');
end;

procedure TForm6.AddorUpdateLocalMemberIntoMailChimp(UpdateFlag: Boolean);
var
  IdxVal, Idx1, Idx2: Integer;
  Sel_List, Sel_ListID: String;
  EMsg, Input_JSONStr: String;
  JSONObj, MergeFields, JSONMainObj, RseultJson: TJSONObject;
  JSONArray: TJSONArray;
  JT: TJSONTrue;
  Members: TJMembersClass;
  DataSet: TDataSet;
  LM_EmailAddr, LM_FName, LM_LName, Inp_JSONStr: String;
begin
  if ListDBGrid1.SelectedRows.Count <= 0 then
    raise exception.Create('Row not selected in Local list member.');
  EMsg := '';
  for Idx1 := 0 to MailChimpLists.Items.Count - 1 do
  begin
    if MailChimpLists.Selected[Idx1] then
    begin
      Sel_List := MailChimpLists.Items.Strings[Idx1];
      Break;
    end;
  end;
  if Sel_List = '' then
    raise exception.Create('List not selected.');
  Sel_ListID := MailChimpStrLists.ValueFromIndex
    [MailChimpStrLists.IndexOfName(Sel_List)];
  Members := TJMembersClass.Create;
  JSONArray := TJSONArray.Create;
  JSONMainObj := TJSONObject.Create;
  if ListDBGrid1.SelectedRows.Count > 0 then
  begin
    DataSet := ListDBGrid1.DataSource.DataSet;
    // with DBGrid1.DataSource.DataSet do
    try
      try
        for Idx1 := 0 to ListDBGrid1.SelectedRows.Count - 1 do
        begin
          DataSet.GotoBookmark(ListDBGrid1.SelectedRows.Items[Idx1]);
          // for Idx2 := 0 to DataSet.FieldCount - 1 do
          // begin
          LM_EmailAddr := DataSet.FieldByName('email').AsString;
          LM_FName := DataSet.FieldByName('NAME').AsString;
          LM_LName := DataSet.FieldByName('LASTNAME').AsString;
          // end;

          Members.email_address := LM_EmailAddr;
          Members.status := 'subscribed';
          Members.merge_fields.FNAME := LM_FName;
          Members.merge_fields.LNAME := LM_LName;

          JSONArray.Add(JSONMainObj.ParseJSONValue(Members.ToJsonString)
            as TJSONObject);
          JSONMainObj.AddPair(TJSONPair.Create('members', JSONArray));

          JSONMainObj.AddPair('update_existing', TJSONBool.Create(UpdateFlag));

          // Input_JSONStr := StringReplace(JSONMainObj.ToString, '\"', '"',
          // [rfReplaceAll]);
          // // JSONMainObj.ToString; // ListMemJSON.ToJsonString;
          // Input_JSONStr := StringReplace(Input_JSONStr, 'fNAME', 'FNAME',
          // [rfReplaceAll]);
          // Input_JSONStr := StringReplace(Input_JSONStr, 'lNAME', 'LNAME',
          // [rfReplaceAll]);
          // Inp_JSONStr := Input_JSONStr;
          // if Inp_JSONStr <> '' then
          // AddorUpdateMembersinList(Sel_ListID, Inp_JSONStr)
          // else
          // raise Exception.Create('Error in adding member to list.');

        end;
        Input_JSONStr := StringReplace(JSONMainObj.ToString, '\"', '"',
          [rfReplaceAll]);
        // JSONMainObj.ToString; // ListMemJSON.ToJsonString;
        Input_JSONStr := StringReplace(Input_JSONStr, 'fNAME', 'FNAME',
          [rfReplaceAll]);
        Input_JSONStr := StringReplace(Input_JSONStr, 'lNAME', 'LNAME',
          [rfReplaceAll]);
        Inp_JSONStr := Input_JSONStr;
        if Inp_JSONStr <> '' then
          AddorUpdateMembersinList(Sel_ListID, Inp_JSONStr)
        else
          raise exception.Create('Error in adding member to list.');
      except
        on e: exception do
        begin
          EMsg := e.Message;
          WriteLog('Error while adding list member (LM_EmailAddr) :' + EMsg);
        end;
      end;
    finally
      if EMsg <> '' then
        ShowMessage
          ('Some list member''s not created/updated properly, Please check tracemsg for more info & try again')
      else
        ShowMessage('List member''s created/updated successfully.');
    end;
  end;
  if assigned(Members) then
    FreeAndNil(Members);
end;

procedure TForm6.btnAddUpdateClick(Sender: TObject);
begin
  if Not cbUpdateLocalmember.Checked then
    btnAddClick(nil)
  else
    AddorUpdateLocalMemberIntoMailChimp(True);
  // ShowMessage('This should only ADD new emails And UPDATE to list and return a how many ADDED and How Many updated');
end;

procedure TForm6.btnCreateListClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  LEMsg: String;
begin
  try
    Application.CreateForm(TfmCreateList, fmCreateList);
    fmCreateList.CreateListResp := CreateListResp;
    fmCreateList.StartPath := StartPath;
    fmCreateList.ShowModal;

    While (fmCreateList.ModalResult = mrOk) do
    begin
      try
        LEMsg := '';
        Inp_JSONStr := fmCreateList.List_Input_JSONStr;
        if Inp_JSONStr <> '' then
        begin
          AddList(Inp_JSONStr);
          ShowMessage('list created successfully.');
        end;
      except
        on e: exception do
          LEMsg := e.Message;
      end;
      if LEMsg <> '' then
      begin
        ShowMessage
          ('List not created, please check the entered data and try again');
        fmCreateList.ShowModal;
      end
      else
        Break;
    end;

  except
    on e: exception do

  end;
  if assigned(fmCreateList) then
  begin
    fmCreateList.free;
    fmCreateList := nil;
    // FreeAndNil(fmCreateList);
  end;

  // ShowMessage('This creates a new Mailchimp List');
end;

procedure TForm6.BtnDelALLClick(Sender: TObject);
var
  I: Integer;
  Del_List_Id: String;
  DelListErr: Boolean;
begin
  ISBulkListDEL := True;
  DelListErr := False;
  for I := 0 to MailChimpStrLists.Count - 1 do
  begin
    Del_List_Id := MailChimpStrLists.ValueFromIndex[I];
    try
      DeleteList(Del_List_Id);
    Except
      on e: exception do
      begin
        DelListErr := True;
        WriteLog('Error while deleting List (' + Del_List_Id + ') ' +
          e.Message);
      end;
    end;
  end;
  ISBulkListDEL := False;
  if DelListErr then
    ShowMessage
      ('Error while deleting Lists , please check TraceMsg file for more info.')
  else
    ShowMessage('Lists are deleted successfully.');
  UpdateMailChimpListsAndFDMemTable;
end;

procedure TForm6.btnDelCampaignsClick(Sender: TObject);
var
  I: Integer;
  Del_Campaign_Id: String;
  DelCampaignErr: Boolean;
begin
  ISBulkCampaignDEL := True;
  DelCampaignErr := False;
  for I := 0 to MailChimpCampaignLists.Count - 1 do
  begin
    Del_Campaign_Id := MailChimpCampaignLists.ValueFromIndex[I];
    try
      DeleteCampaign(Del_Campaign_Id);
    Except
      on e: exception do
      begin
        DelCampaignErr := True;
        WriteLog('Error while deleting Campaign (' + Del_Campaign_Id + ') ' +
          e.Message);
      end;
    end;
  end;
  ISBulkCampaignDEL := False;
  if DelCampaignErr then
    ShowMessage
      ('Error while deleting Campaign , please check TraceMsg file for more info.')
  else
    ShowMessage('Campaigns are deleted successfully.');
  UpdateMailChimpCampaign;
end;

procedure TForm6.ExecuteCampaign(Sel_List, Sel_Campaign: String);
var
  Sel_ListID, Sel_CampaignID, EMsg: String;
  Idx1: Integer;
  ResultJSONStr: WideString;
begin
  try
    EMsg := '';
    // Sel_List := '';
    // Sel_Campaign := '';

    if Sel_List = '' then
      raise exception.Create('List not selected.');
    if Sel_Campaign = '' then
      raise exception.Create('Campaign not selected.');

    UpdateMailChimpCampaign;
    Sel_ListID := MailChimpStrLists.ValueFromIndex
      [MailChimpStrLists.IndexOfName(Sel_List)];
    Sel_CampaignID := MailChimpCampaignLists.ValueFromIndex
      [MailChimpCampaignLists.IndexOfName(Sel_Campaign)];
    ResultJSONStr := GetMailChimpCampaign(Sel_CampaignID);
    // Parsing resultJSON string
    CreateCampaignClass := CreateCampaignClass.FromJsonString(ResultJSONStr);
    CreateCampaignClass.recipients.List_Id := Sel_ListID;
    ResultJSONStr := CreateCampaignClass.ToJsonString;
    UpdateCampaign(Sel_CampaignID, ResultJSONStr);
    try
      SendMail(Sel_CampaignID);
    Except
      raise exception.Create
        ('Campaign might have sent already,Please check it.');
    end;
  Except
    on e: exception do
      EMsg := e.Message;
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.btnExauteClick(Sender: TObject);
var
  Sel_List, Sel_Campaign, Sel_ListID, Sel_CampaignID, EMsg: String;
  Idx1: Integer;
  ResultJSONStr: WideString;
begin
  try
    EMsg := '';
    Sel_List := '';
    Sel_Campaign := '';
    for Idx1 := 0 to MailChimpList2.Items.Count - 1 do
    begin
      if MailChimpList2.Selected[Idx1] then
      begin
        Sel_List := MailChimpList2.Items.Strings[Idx1];
        Break;
      end;
    end;

    for Idx1 := 0 to MailChimpCampaign2.Items.Count - 1 do
    begin
      if MailChimpCampaign2.Selected[Idx1] then
      begin
        Sel_Campaign := MailChimpCampaign2.Items.Strings[Idx1];
        Break;
      end;
    end;

    if Sel_List = '' then
      raise exception.Create('List not selected.');
    if Sel_Campaign = '' then
      raise exception.Create('Campaign not selected.');

    Sel_ListID := MailChimpStrLists.ValueFromIndex
      [MailChimpStrLists.IndexOfName(Sel_List)];
    Sel_CampaignID := MailChimpCampaignLists.ValueFromIndex
      [MailChimpCampaignLists.IndexOfName(Sel_Campaign)];
    ResultJSONStr := GetMailChimpCampaign(Sel_CampaignID);
    // Parsing resultJSON string
    CreateCampaignClass := CreateCampaignClass.FromJsonString(ResultJSONStr);
    CreateCampaignClass.recipients.List_Id := Sel_ListID;
    ResultJSONStr := CreateCampaignClass.ToJsonString;
    UpdateCampaign(Sel_CampaignID, ResultJSONStr);
    try
      SendMail(Sel_CampaignID);
    Except
      raise exception.Create
        ('Campaign might have sent already,Please check it.');
    end;
  Except
    on e: exception do
      EMsg := e.Message;
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.SendMail(CampaignId: String);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  DummyStrList: TStringList;
begin
  try
    ErrMsg := '';
    DummyStrList := TStringList.Create;

    Url := Campaign_HttpURL + '/' + CampaignId + '/actions/send';

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPost;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, DummyStrList);

    // Parsing resultJSON string
    if ResultJSONStr <> '' then
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
        raise exception.Create(ErrorListResp.detail)
    end;
    StatusBar1.Panels[0].Text := 'Added 0';
    StatusBar1.Panels[1].Text := 'Updated 0';
    StatusBar1.Panels[2].Text := 'Deleted 0';
    StatusBar1.Panels[3].Text := 'Run Command: Send mail ';
    StatusBar1.Panels[4].Text := DateTimeToStr(Now());
    ShowMessage('Mail has sent successfully.');
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(DummyStrList) then
    FreeAndNil(DummyStrList);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);

end;

procedure TForm6.Button1Click(Sender: TObject);
var
  I, Idx1, Idx2: Integer;
  List_Id, EMsg, Sel_List, Sel_ListID, LM_EmailAddr: String;
  S: TStringList;
  MailIds: WideString;
  DataSet: TDataSet;
begin
  if ListDBGrid1.SelectedRows.Count <= 0 then
    raise exception.Create('Row not selected in Local list member.');
  EMsg := '';
  for Idx1 := 0 to MailChimpLists.Items.Count - 1 do
  begin
    if MailChimpLists.Selected[Idx1] then
    begin
      Sel_List := MailChimpLists.Items.Strings[Idx1];
      Break;
    end;
  end;
  if Sel_List = '' then
    raise exception.Create('List not selected.');
  Sel_ListID := MailChimpStrLists.ValueFromIndex
    [MailChimpStrLists.IndexOfName(Sel_List)];

  if ListDBGrid1.SelectedRows.Count > 0 then
  begin
    DataSet := ListDBGrid1.DataSource.DataSet;
    // with DBGrid1.DataSource.DataSet do

    for Idx1 := 0 to ListDBGrid1.SelectedRows.Count - 1 do
    begin
      DataSet.GotoBookmark(ListDBGrid1.SelectedRows.Items[Idx1]);
      // for Idx2 := 0 to DataSet.FieldCount - 1 do
      // begin
      LM_EmailAddr := DataSet.FieldByName('email').AsString;
      if MailIds = '' then
        MailIds := LM_EmailAddr
      else
        MailIds := MailIds + ',' + LM_EmailAddr;
      // end;
    end;

    // for I := 0 to ListFDMemTable.RecordCount - 1 do
    // begin
    List_Id := Sel_ListID; // VartoStr(ListFDMemTable.FieldByName('ID').Value);
    // MailIds := GetMailIDsFromList(List_Id);
    CheckMailidsAndDeleteFromMailChimp(List_Id, '', MailIds);
    // end;
  end;
  // ShowMessage('This should only Delete from list list any etery on list no email found for it in DATASET, return amount deleted' );
end;

function TForm6.GetMailIDsFromList(IP_ListID: String): WideString;
var
  I: Integer;
  FDQuery: TFDQuery;
  DummyFDMemtable: TFDMemTable;
  EmsgStr: String;
begin
  result := '';
  EmsgStr := '';
  try
    // FDQuery := TFDQuery.Create(nil);
    DummyFDMemtable := TFDMemTable.Create(nil);
    DummyFDMemtable.FieldDefs.Clear;
    DummyFDMemtable := NewFDMemTable;
    DummyFDMemtable.CopyDataSet(ListFDMemTable);
    // FDQuery.Active := True;
    // FDQuery.CopyDataSet(ListFDMemTable);
    // FDQuery.Filter := 'ID = ' + QuotedStr(IP_ListID);
    DummyFDMemtable.Filter := 'ID = ' + QuotedStr(IP_ListID);
    DummyFDMemtable.Filtered := True;
    for I := 0 to DummyFDMemtable.RecordCount - 1 do
    begin
      if result = '' then
        result := VartoStr(DummyFDMemtable.FieldByName('email').Value)
      else
        result := result + ',' +
          VartoStr(DummyFDMemtable.FieldByName('email').Value);
    end;
  Except
    on e: exception do
      EmsgStr := e.Message;
  end;
  if EmsgStr <> '' then
    raise exception.Create(EmsgStr);
  if assigned(DummyFDMemtable) then
    FreeAndNil(DummyFDMemtable);
end;

Procedure TForm6.LoadSettings;
var
  Ini: TIniFile;
  C_Settings_Filename, D_Settings_Filename: String;
begin
  C_Settings_Filename :=
    ChangeFileExt(StartPath + ExtractFilename(Application.ExeName), '.INI');
  D_Settings_Filename := ChangeFileExt(C_Settings_Filename, '.cmp');
  if FileExists(C_Settings_Filename) then
  begin
    with TCompress.Create do
    begin
      decompressfile(C_Settings_Filename, D_Settings_Filename);
      destroy;
    end;
    Ini := TIniFile.Create(D_Settings_Filename);
    try
      HttpURL := Ini.ReadString('url', 'url', '');
      if AnsiLastChar(HttpURL) = '/' then
        delete(HttpURL, length(HttpURL), 1);
      Lists_HttpURL := HttpURL + '/lists';
      Campaign_HttpURL := HttpURL + '/campaigns';
      Auth_UserName := Ini.ReadString('username', 'username', '');
      Auth_Password := Ini.ReadString('password', 'password', '');
      API_KEY := Ini.ReadString('api', 'api', '');
      Basic_Auth := ('true' = Ini.ReadString('basicauth', 'basicauth', ''));
      SimpleMode := ('true' = Ini.ReadString('simplemode', 'simplemode', ''));
      CampaignDefaultList := Ini.ReadString('defaultlist', 'defaultlist', '');
      DefaultFromName := Ini.ReadString('fromname', 'fromname', '');
      DefaultFromEmail := Ini.ReadString('frommail', 'frommail', '');
    finally
      Ini.free;
    end;
    if FileExists(D_Settings_Filename) then
      DeleteFile(D_Settings_Filename);
  end;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  StartPath := ExtractFilePath(ParamStr(0));
  if AnsiLastChar(StartPath) <> '\' then
    StartPath := StartPath + '\';
  SetupWinPwd := '';
  IsTrace := True;
  if FileExists(ChangeFileExt(StartPath + ExtractFilename(Application.ExeName),
    '.INI')) then
  begin
    LoadSettings;
    if (HttpURL = '') or (Auth_UserName = '') or (Auth_Password = '') or
      (API_KEY = '') then
    begin
      Application.CreateForm(TfmMailChimpAccount, fmMailChimpAccount);
      fmMailChimpAccount.ShowModal;
      if assigned(fmMailChimpAccount) then
      begin
        fmMailChimpAccount.free;
        fmMailChimpAccount := nil;
        // FreeAndNil(fmMailChimpAccount);
      end;
      LoadSettings;
    end;
  end;

  ISBulkListDEL := False;
  ISBulkCampaignDEL := False;
  ListResp := TList.Create;
  CreateListResp := TCreateListJSON.Create;
  GetListResp := TGetListClass.Create;
  ErrorListResp := TDelListClass.Create;
  ListMemberResp := TListMemberClass.Create;
  GetListMemberResp := TGetListMemberClass.Create;

  CreateCampaignClass := TCreateCampaign.Create;
  RespCreateCampaign := TRespCreateCampaign.Create;
  RespGetCampaign := TGetCampaign.Create;
  RespSetCampaignContent := TRespSetCampaignContent.Create;
  ErrClass := TListErrorsClass.Create;

  FDCol_StrList := TStringList.Create;
  CreateFDColList(FDCol_StrList);
  MailChimpStrLists := TStringList.Create;
  MailChimpCampaignLists := TStringList.Create;

  // ListFDMemTable.Edit;
  // ListFDMemTable.ClearFields;
  ListFDMemTable.FieldDefs.Clear;
  ListFDMemTable := NewFDMemTable;
  if FileExists(StartPath + 'mydata.fds') then
    ListFDMemTable.LoadFromFile('mydata.fds');
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  if assigned(ListResp) then
  begin
    ListResp.free;
    ListResp := nil;
    // FreeAndNil(ListResp);
  end;
  if assigned(CreateListResp) then
  begin
    CreateListResp.free;
    CreateListResp := nil;
    // FreeAndNil(CreateListResp);
  end;

  if assigned(GetListResp) then
  begin
    GetListResp.free;
    GetListResp := nil;
    // FreeAndNil(GetListResp);
  end;
  if assigned(ErrorListResp) then
  begin
    ErrorListResp.free;
    ErrorListResp := nil;
    // FreeAndNil(ErrorListResp);
  end;
  if assigned(ListMemberResp) then
  begin
    ListMemberResp.free;
    ListMemberResp := nil;
    // FreeAndNil(ListMemberResp);
  end;
  if assigned(GetListMemberResp) then
  begin
    GetListMemberResp.free;
    GetListMemberResp := nil;
    // FreeAndNil(GetListMemberResp);
  end;

  if assigned(CreateCampaignClass) then
  begin
    CreateCampaignClass.free;
    CreateCampaignClass := nil;
    // FreeAndNil(CreateCampaignClass);
  end;
  if assigned(RespCreateCampaign) then
  begin
    RespCreateCampaign.free;
    RespCreateCampaign := nil;
    // FreeAndNil(RespCreateCampaign);
  end;
  if assigned(RespGetCampaign) then
  begin
    RespGetCampaign.free;
    RespGetCampaign := nil;
    // FreeAndNil(RespGetCampaign);
  end;
  if assigned(RespSetCampaignContent) then
  begin
    RespSetCampaignContent.free;
    RespSetCampaignContent := nil;
    // FreeAndNil(RespSetCampaignContent);
  end;
  if assigned(ErrClass) then
  begin
    ErrClass.free;
    ErrClass := nil;
    // FreeAndNil(ErrClass);
  end;

  if assigned(FDCol_StrList) then
    FreeAndNil(FDCol_StrList);
  if assigned(MailChimpStrLists) then
    FreeAndNil(MailChimpStrLists);

  if assigned(MailChimpCampaignLists) then
    FreeAndNil(MailChimpCampaignLists);

end;

procedure TForm6.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;
  CampaignAction := '';
  ListAction := '';
  LoadListandCampaign;
  LoadSimpleModeCampaign;
end;

Procedure TForm6.LoadSimpleModeCampaign;
begin
  // Simple mode
  if SimpleMode then
  begin
    // gbcampaign.Visible := False;
    // gbexec.Visible := False;
    btnAddandExecute_Campaign.Visible := True;
    btnAddandExecute_Campaign.BringToFront;
    //btnAddandExecute_Campaign.Align := alBottom;
    btnAddandExecute_Campaign.Refresh;
    gbexec.Visible:= False;
    pnlXsimple.Visible:= False;
    grpBTNs.Visible:=False;
    ListDBGrid1.Visible:=False;
    Form6.Refresh;
  end
  else
  begin
    // gbcampaign.Visible := True;
    // gbexec.Visible := True;
    btnAddandExecute_Campaign.Visible := False;
  end;
end;

Procedure TForm6.LoadListandCampaign;
begin
  if (HttpURL <> '') and (Auth_UserName <> '') and (API_KEY <> '') then
  begin
    UpdateMailChimpCampaign;
    UpdateMailChimpListsAndFDMemTable;
  end;
end;

procedure WriteStreamInt(Stream: TStream; Num: Integer);
{ writes an integer to the stream }
begin
  Stream.WriteBuffer(Num, SizeOf(Integer));
end;

Procedure TForm6.AddList(IP_Json_Str: WideString);
var
  JSONObj: TJSONObject;
  mStream: TMemoryStream;
  Url, JsonStr, JsResult, ErrMsg, FNAME, TFile: String;
  InputJSONStr, ResultJSONStr: WideString;
  parameters: TStringStream;
  JSONArray: TJSONArray;
  jsonPair: TJSONPair;
  StrLen: Integer;
begin
  try
    ErrMsg := '';
    JSONObj := TJSONObject.Create;
    // mStream := TMemoryStream.Create;

    InputJSONStr := IP_Json_Str;

    if InputJSONStr = '' then
    begin
      InputJSONStr :=
        '{"name":"Freddies Favorite Hats11","contact":{"company":"MailChimp",' +
        '"address1":"675 Ponce De Leon Ave NE","address2":"Suite 5000",' +
        '"city":"Atlanta","state":"GA","zip":"30308","country":"US","phone":""},'
        + '"permission_reminder":"You are receiving this email because you signed up'
        + ' for updates about Freddies newest hats.","campaign_defaults":' +
        '{"from_name":"Freddie","from_email":"freddie@freddiehats.com","subject":"",'
        + '"language":"en"},"email_type_option":true}';
    end;

    (*
      {get length of string}
      StrLen := Length(JStr);
      {write length of string}
      WriteStreamInt(mStream, StrLen);
      if StrLen > 0 then
      {write characters}
      mStream.Write(Str[1], StrLen * SizeOf(Str[1]));
      mStream.Position := 0;
      jsonObj.AddPair('filedata', TIdEncoderMIME.EncodeStream(mStream));
    *)

    parameters := TStringStream.Create(InputJSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Lists_HttpURL;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPost;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    ListResp := ListResp.FromJsonString(ResultJSONStr);

    if assigned(ListResp.Errors) and (Trim(ListResp.Errors.Message) <> '') then
      raise exception.Create(ListResp.Errors.Message);
    ListAction := 'add';
    UpdateMailChimpListsAndFDMemTable;

    // ListResp.id;   //List ID
    // ListResp.name; //List Name

  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(JSONObj) then
    FreeAndNil(JSONObj);
  if assigned(mStream) then
    FreeAndNil(mStream);
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

{ procedure TForm6.UpdateJSONResultIntoFDMemTable;
  var
  ListID , LastName , Address , City , State , Zip , Email : String;
  begin
  ListID := ListResp.id;
  LastName := ListResp.campaign_defaults.from_name;
  Address := ListResp.contact.address1;
  City := ListResp.contact.city;
  State := ListResp.contact.state;
  Zip := ListResp.contact.zip;
  Email := ListResp.campaign_defaults.from_email;

  ListFDMemTable.DisableControls;
  ListFDMemTable.Append;
  ListFDMemTable.FieldByName('ListID').Value := ListID;
  ListFDMemTable.FieldByName('LastName').Value := LastName;
  ListFDMemTable.FieldByName('Address').Value := Address;
  ListFDMemTable.FieldByName('City').Value := City;
  ListFDMemTable.FieldByName('State').Value := State;
  ListFDMemTable.FieldByName('Zip').Value := Zip;
  ListFDMemTable.FieldByName('Email').Value := Email;
  ListFDMemTable.Post;
  ListFDMemTable.EnableControls;

  ListDBGrid1.Refresh;
  UpdateMailChimpLists;
  end; }

procedure TForm6.UpdateMailChimpListsAndFDMemTable;
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  Idx: Integer;
  ListID, ID, ListName, Email_UniqueID, Name, LastName, Address, City, State,
    Zip, Email: String;
begin
  try
    ErrMsg := '';
    Url := Lists_HttpURL + Offset_Count;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Get(Url);
    // Parsing resultJSON string
    GetListResp := GetListResp.FromJsonString(ResultJSONStr);
    if ListAction <> '' then
    begin
      if ListAction = 'add' then
      begin
        StatusBar1.Panels[0].Text := 'Added ' +
          FloattoStr(GetListResp.total_items);
        StatusBar1.Panels[1].Text := 'Updated 0';
        StatusBar1.Panels[2].Text := 'Deleted 0';
      end
      else if ListAction = 'delete' then
      begin
        StatusBar1.Panels[0].Text := 'Added 0';
        StatusBar1.Panels[1].Text := 'Updated 0';
        StatusBar1.Panels[2].Text := 'Deleted 1';
      end
      else if ListAction = 'update' then
      begin
        StatusBar1.Panels[0].Text := 'Added 0';
        StatusBar1.Panels[1].Text := 'Updated 1';
        StatusBar1.Panels[2].Text := 'Deleted 0';
      end;
      StatusBar1.Panels[3].Text := 'Run Command: ' + ListAction + ' list ';
      StatusBar1.Panels[4].Text := DateTimeToStr(Now());
    end;

    Idx := 0;
    MailChimpStrLists.Clear;
    MailChimpLists.Items.Clear;
    // ListFDMemTable.DisableControls;
    while Idx <= GetListResp.total_items - 1 do
    begin
      try
        if assigned(GetListResp.lists[Idx]) then
        begin
          ListID := GetListResp.lists[Idx].ID;
          ListName := GetListResp.lists[Idx].Name;
          // LastName := GetListResp.lists[Idx].campaign_defaults.from_name;

          // Address := GetListResp.lists[Idx].contact.address1;
          // City := GetListResp.lists[Idx].contact.City;
          // State := GetListResp.lists[Idx].contact.State;
          // Zip := GetListResp.lists[Idx].contact.Zip;
          // Email := GetListResp.lists[Idx].campaign_defaults.from_email;

          // ListFDMemTable.Append;
          // ListFDMemTable.FieldByName('LastName').Value := LastName;
          // ListFDMemTable.FieldByName('Name').Value := Name;
          // ListFDMemTable.FieldByName('Address').Value := Address;
          // ListFDMemTable.FieldByName('City').Value := City;
          // ListFDMemTable.FieldByName('State').Value := State;
          // ListFDMemTable.FieldByName('Zip').Value := Zip;
          // ListFDMemTable.FieldByName('Email').Value := Email;
          // ListFDMemTable.FieldByName('ID').Value := ID;
          // ListFDMemTable.Post;

          MailChimpLists.Items.Add(ListName);

          // MailChimpStrLists.Add(ListID + '=' + ListName);
          MailChimpStrLists.Add(ListName + '=' + ListID);
          // UpdateFDMemTableandGrid(ListID, Address , City , State , Zip);
        end;
        Inc(Idx);
      Except
        on e: exception do
        begin
          Inc(Idx);
          Continue;
        end;
      end;
    end;
    MailChimpList2.Items.Clear;
    MailChimpList2.Items := MailChimpLists.Items;
    // ListFDMemTable.EnableControls;
    // ListDBGrid1.Refresh;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
  begin
    if pos('Socket ', ErrMsg) > 0 then
      raise exception.Create('Please check your internet connection.')
    else
      raise exception.Create(ErrMsg);
  end;
end;

Procedure TForm6.UpdateFDMemTableandGrid(Member_ListID, Address, City, State,
  Zip: String);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  Idx_Val, TotCount: Integer;
  ListID, MemberID, Email_UniqueID, Name, LastName, Email: String;
begin
  // try
  ErrMsg := '';
  Url := Lists_HttpURL + '/' + Member_ListID + '/members' + Offset_Count;

  IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.BasicAuthentication := Basic_Auth;
  IdHTTP1.Request.UserName := Auth_UserName;
  IdHTTP1.Request.Password := Auth_Password;
  ResultJSONStr := IdHTTP1.Get(Url);

  ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
  if ErrorListResp.detail <> '' then
  begin
    raise exception.Create(FloattoStr(ErrorListResp.status) + ' - ' +
      ErrorListResp.detail);
  end;
  // Parsing resultJSON string
  GetListMemberResp := GetListMemberResp.FromJsonString(ResultJSONStr);
  TotCount := Round(GetListMemberResp.total_items);
  ListID := GetListMemberResp.List_Id;
  ListFDMemTable.DisableControls;
  for Idx_Val := 0 to TotCount - 1 do
  begin
    MemberID := GetListMemberResp.Members[Idx_Val].ID;
    // Email_UniqueID := GetListMemberResp.Members[Idx_Val].unique_email_id;
    Name := GetListMemberResp.Members[Idx_Val].merge_fields.FNAME;
    LastName := GetListMemberResp.Members[Idx_Val].merge_fields.LNAME;
    Email := GetListMemberResp.Members[Idx_Val].email_address;

    ListFDMemTable.Append;
    ListFDMemTable.FieldByName('LastName').Value := LastName;
    ListFDMemTable.FieldByName('Name').Value := Name;
    ListFDMemTable.FieldByName('Address').Value := Address;
    ListFDMemTable.FieldByName('City').Value := City;
    ListFDMemTable.FieldByName('State').Value := State;
    ListFDMemTable.FieldByName('Zip').Value := Zip;
    ListFDMemTable.FieldByName('Email').Value := Email;
    ListFDMemTable.FieldByName('ID').Value := MemberID;
    ListFDMemTable.Post;
  end;
  ListFDMemTable.EnableControls;
  // ListDBGrid1.Refresh;
  // Except on E:Exception do
  // ErrMsg := E.Message;
  // end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.DeleteList(ListID: String);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
begin
  try
    ErrMsg := '';
    Url := Lists_HttpURL + '/' + ListID;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodDelete;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.delete(Url);
    // Parsing resultJSON string
    if Trim(ResultJSONStr) = '' then
    begin
      if Not ISBulkListDEL then
        ShowMessage('List deleted successfully.');
    end
    else
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
      begin
        raise exception.Create(FloattoStr(ErrorListResp.status) + ' - ' +
          ErrorListResp.detail);
      end;
    end;
    ListAction := 'delete';
    if Not ISBulkListDEL then
      UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.DeleteCampaign(CampaignId: String);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
begin
  try
    ErrMsg := '';
    Url := Campaign_HttpURL + '/' + CampaignId;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodDelete;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.delete(Url);
    // Parsing resultJSON string
    if Trim(ResultJSONStr) = '' then
    begin
      if Not ISBulkCampaignDEL then
        ShowMessage('Campaign deleted successfully.');
    end
    else
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
      begin
        raise exception.Create(FloattoStr(ErrorListResp.status) + ' - ' +
          ErrorListResp.detail);
      end;
    end;
    ListAction := 'delete';
    if Not ISBulkCampaignDEL then
      UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.UpdateList(List_Id: String; InputJSONStr: WideString);
var
  JSONObj: TJSONObject;
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
begin
  try
    ErrMsg := '';
    JSONObj := TJSONObject.Create;
    if InputJSONStr = '' then
      InputJSONStr :=
        '{"name":"Freddies Update Patch call","contact":{"company":"Test MailChimp",'
        + '"address1":"675 Ponce De Leon Ave NE","address2":"Suite 5000",' +
        '"city":"Atlanta","state":"GA","zip":"30308","country":"US","phone":""},'
        + '"permission_reminder":"You are receiving this email because you signed up'
        + ' for updates about Freddies  ABCD.","campaign_defaults":' +
        '{"from_name":"Freddie","from_email":"freddie123@freddiehats.com","subject":"abcd",'
        + '"language":"en"},"email_type_option":true}';

    parameters := TStringStream.Create(InputJSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Lists_HttpURL + '/' + List_Id;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPatch;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Patch(Url, parameters);

    // Parsing resultJSON string
    ListResp := ListResp.FromJsonString(ResultJSONStr);

    if assigned(ListResp.Errors) and (Trim(ListResp.Errors.Message) <> '') then
      raise exception.Create(ListResp.Errors.Message)
    else if ListResp.ID <> List_Id then
      ShowMessage('List updated successfully.');
    ListAction := 'update';
    UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(JSONObj) then
    FreeAndNil(JSONObj);
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.AddorUpdateMembersinList(List_Id: String;
  InputJSONStr: WideString);
var
  JSONObj: TJSONObject;
  Url, ErrMsg, ErrFname, UserMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
  Idx: Integer;
begin
  try
    ErrMsg := '';
    JSONObj := TJSONObject.Create;
    if InputJSONStr = '' then
      InputJSONStr :=
        '{"members": [{"email_address": "urist.mcvankab@freddiesjokes.com",' +
        '"status": "subscribed"}, {"email_address": "urist.mcvankab+1@freddiesjokes.com", '
        + '"status": "subscribed"}, {"email_address": "urist.mcvankab+2@freddiesjokes.com",'
        + ' "status_if_new": "subscribed"}], "update_existing": true}';

    parameters := TStringStream.Create(InputJSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Lists_HttpURL + '/' + List_Id;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPost;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;

    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    ListMemberResp := ListMemberResp.FromJsonString(ResultJSONStr);

    StatusBar1.Panels[0].Text := 'Added ' +
      FloattoStr(ListMemberResp.total_created);
    StatusBar1.Panels[1].Text := 'Updated ' +
      FloattoStr(ListMemberResp.total_updated);
    StatusBar1.Panels[2].Text := 'Deleted 0';
    StatusBar1.Panels[3].Text := 'Run Command: Add/update member in list ';
    StatusBar1.Panels[4].Text := DateTimeToStr(Now());

    UserMsg := ' Total no.of new records : ' +
      FloattoStr(ListMemberResp.total_created) + #13 +
      ' Total no.of updated records : ' +
      FloattoStr(ListMemberResp.total_updated) + #13 +
      ' Total no.of error records : ' + FloattoStr(ListMemberResp.error_count);

    if ListMemberResp.error_count > 0 then
    begin
      Idx := 0;
      ErrFname := StartPath + 'UpadteMemberListError.txt';
      with TStringList.Create do
      begin
        while Idx < ListMemberResp.error_count do
        begin
          Add('Email : ' + ListMemberResp.Errors[Idx].email_address);
          Add('Error : ' + ListMemberResp.Errors[Idx].email_address);
          Add(' ');
        end;
        SaveToFile(ErrFname);
        free;
      end;
      UserMsg := UserMsg + #13 + ' Error file available in : ' + ErrFname;
    end;
    ListAction := '';
    UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(JSONObj) then
    FreeAndNil(JSONObj);
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.DeleteMembersFromList(List_Id, subscriber_hash: String);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
begin
  try
    ErrMsg := '';
    if subscriber_hash <> '' then
      Url := Lists_HttpURL + '/' + List_Id + '/members/' + subscriber_hash;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodDelete;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.delete(Url);

    // Parsing resultJSON string
    if Trim(ResultJSONStr) = '' then
      // ShowMessage('List member deleted successfully.')
    else
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
      begin
        raise exception.Create(FloattoStr(ErrorListResp.status) + ' - ' +
          ErrorListResp.detail);
      end;
    end;
    ListAction := '';
    UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

(* //Delphi FieldType

  TFieldType = (ftUnknown, ftString, ftSmallint, ftInteger, ftWord, // 0..4
  ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime, // 5..11
  ftBytes, ftVarBytes, ftAutoInc, ftBlob, ftMemo, ftGraphic, ftFmtMemo, // 12..18
  ftParadoxOle, ftDBaseOle, ftTypedBinary, ftCursor, ftFixedChar, ftWideString, // 19..24
  ftLargeint, ftADT, ftArray, ftReference, ftDataSet, ftOraBlob, ftOraClob, // 25..31
  ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd, // 32..37
  ftFixedWideChar, ftWideMemo, ftOraTimeStamp, ftOraInterval, // 38..41
  ftLongWord, ftShortint, ftByte, ftExtended, ftConnection, ftParams, ftStream, //42..48
  ftTimeStampOffset, ftObject, ftSingle); //49..51 *)
Procedure TForm6.CreateFDColList(Col_StrList: TStringList);
begin
  if Not assigned(Col_StrList) then
    Col_StrList := TStringList.Create;
  Col_StrList.Clear;
  Col_StrList.StrictDelimiter := True;
  // 1-ftString
  // Col_StrList.Add('ListID=1,20,0'); // FldName , Fldtype , FldSize , FldPrecision
  Col_StrList.Add('LastName=1,20,0');
  Col_StrList.Add('Name=1,20,0');
  Col_StrList.Add('Address=1,50,0');
  Col_StrList.Add('City=1,15,0');
  Col_StrList.Add('State=1,15,0');
  Col_StrList.Add('Zip=1,10,0');
  Col_StrList.Add('Email=1,30,0');
  Col_StrList.Add('ID=1,20,0');

end;

// Creating FDMTable Dataset
function TForm6.NewFDMemTable: TFDMemTable;
var
  I: Integer;
  FldName: String;
  FldType: TFieldType;
  FldSize, FldPrecision, tmpsize: Integer;
  FDQuery1: TFDQuery;
begin
  result := TFDMemTable.Create(nil);
  with result do
  begin
    for I := 0 to FDCol_StrList.Count - 1 do
    begin
      FldSize := 0;
      FldPrecision := 0;
      FldName := FDCol_StrList.Names[I];
      FldType := TFieldType
        (StrtoInt(GetNthString(FDCol_StrList.ValueFromIndex[I], 1)));
      FldSize := StrtoInt(GetNthString(FDCol_StrList.ValueFromIndex[I], 2));
      FldPrecision :=
        StrtoInt(GetNthString(FDCol_StrList.ValueFromIndex[I], 3));

      FieldDefs.Add(FldName, FldType, FldSize, False);
      FieldDefs.Find(FldName).Precision := FldPrecision;
    end;
    CreateDataSet;
    LogChanges := False;
  end;
end;

procedure TForm6.pnlListClick(Sender: TObject);
begin

end;

// Get given position of string from CommaText
Function TForm6.GetNthString(SrcString: String; StrPos: Integer): String;
Var
  I, k: Integer;
Begin
  result := '';
  I := 1;
  k := 1;
  while (k <= StrPos) and (I <= length(SrcString)) do
  begin
    if SrcString[I] = ',' then
      Inc(k)
    else if k = StrPos then
      result := result + SrcString[I];
    Inc(I);
  end;
End;

procedure TForm6.CheckMailidsAndDeleteFromMailChimp(Member_ListID,
  subscriber_hash, MailIds: String);
var
  Url, ErrMsg, subscr_hash: String;
  ResultJSONStr: WideString;
  Idx_Val, TotCount: Integer;
  ListID, MemberID, Email_UniqueID, Name, LastName, Email: String;
  StrList_MailIds: TStringList;
  DelCount: Integer;
  JObj_ListMember: TJSONObject;
  JArr_ListMember: TJSONArray;
begin
  // try
  DelCount := 0;
  ErrMsg := '';
  subscr_hash := '';
  StrList_MailIds := TStringList.Create;
  StrList_MailIds.StrictDelimiter := True;
  StrList_MailIds.CommaText := MailIds;
  try
    Url := Lists_HttpURL + '/' + Member_ListID + '/members';
    if subscriber_hash <> '' then
      Url := Url + '/' + subscriber_hash
    else
      Url := Url + Offset_Count;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Get(Url);

    ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
    if ErrorListResp.detail <> '' then
    begin
      raise exception.Create(FloattoStr(ErrorListResp.status) + ' - ' +
        ErrorListResp.detail);
    end;

    JObj_ListMember := TJSONObject.Create;
    JArr_ListMember := TJSONArray.Create;

    JObj_ListMember := JObj_ListMember.ParseJSONValue(ResultJSONStr)
      As TJSONObject;
    TotCount := StrtoInt(JObj_ListMember.GetValue('total_items').Value);
    ListID := JObj_ListMember.GetValue('list_id').Value;

    JArr_ListMember := JObj_ListMember.Get(0).JsonValue As TJSONArray;

    while TotCount >= 0 do
    begin
      // MemberID :=   JArr_ListMember.Get(Idx_Val).GetValue('id');
      Email := (JArr_ListMember.Get(Idx_Val) As TJSONObject)
        .GetValue('email_address').Value; // .Value.ToString;
      subscr_hash := (JArr_ListMember.Get(Idx_Val) As TJSONObject)
        .GetValue('id').Value; // .Value.ToString;
      // The MD5 hash of the lowercase version of the list member’s email address
      if StrList_MailIds.IndexOf(Email) > -1 then
      begin
        try
          DeleteMembersFromList( { MemberID } ListID, subscr_hash);
        Except

        end;
        Inc(DelCount);
      end;
      Dec(TotCount);
    end;

    // // Parsing resultJSON string
    // GetListMemberResp := GetListMemberResp.FromJsonString(ResultJSONStr);
    // TotCount := Round(GetListMemberResp.total_items) - 1;
    // ListID := GetListMemberResp.List_Id;
    // for Idx_Val := 0 to TotCount - 1 do
    // begin
    // MemberID := GetListMemberResp.members[Idx_Val].ID;
    // Email_UniqueID := GetListMemberResp.members[Idx_Val].unique_email_id;
    // Email := GetListMemberResp.members[Idx_Val].email_address;
    // end;

    // while TotCount >= 0 do
    // begin
    // MemberID :=   GetListMemberResp.Members[Idx_Val].ID;
    // Email := GetListMemberResp.Members[Idx_Val].email_address;
    // subscr_hash := GetListMemberResp.Members[Idx_Val].ID;
    // // The MD5 hash of the lowercase version of the list member’s email address
    // if StrList_MailIds.IndexOf(Email) < 0 then
    // begin
    // try
    // DeleteMembersFromList(MemberID, subscr_hash);
    // Except
    //
    // end;
    // Inc(DelCount);
    // end;
    // end;
    ShowMessage(InttoStr(DelCount) + ' memebers deleted from members list.');
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(StrList_MailIds) then
    FreeAndNil(StrList_MailIds);
  JObj_ListMember := Nil;
  if ErrMsg <> '' then
  begin
    if ErrMsg = 'HTTP/1.1 404 Not Found' then
      ErrMsg := 'The requested List/Member could not be found';
    raise exception.Create(ErrMsg);
  end;
end;



// MailChimp campaign

procedure TForm6.btnAddandExecute_CampaignClick(Sender: TObject);
var
  EMsg: String;
begin
  //
  try
    SimpleCampaign_Exec := True;
    Application.CreateForm(TfmExecCampaign, fmExecCampaign);
    fmExecCampaign.cbomailchimplist.Items := MailChimpLists.Items;
    fmExecCampaign.cbomailchimplist.Text := CampaignDefaultList;
    fmExecCampaign.MCStrList := MailChimpStrLists;
    fmExecCampaign.StartPath := StartPath;
    fmExecCampaign.CreateNewCampaign := btnAddCappaignClick;
    fmExecCampaign.ExecuteCampaign := ExecuteCampaign;
    // fmExecCampaign.DefaultFromName := DefaultFromName;
    // fmExecCampaign.DefaultFromemail := DefaultFromEmail;
    fmExecCampaign.edfromname.Text := DefaultFromName;
    fmExecCampaign.Edfromemailaddr.Text := DefaultFromEmail;
    fmExecCampaign.CampaignStrList := MailChimpCampaignLists;
    //fmExecCampaign.cbocampaignlist.Items :=  MailChimpCampaignLists;
    fmExecCampaign.Setcampaigncontent_Proc := Setcampaigncontent;
    fmExecCampaign.ShowModal;
    SimpleCampaign_Exec := False;

  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmExecCampaign) then
  begin
    fmExecCampaign.free;
    fmExecCampaign := nil;
    // FreeAndNil(fmCreateCamapign);
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.btnAddCappaignClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  EMsg, LEMsg: String;
  JObj: TJSONObject;
  fmResult: Integer;
begin
  try
    EMsg := '';
    fmResult := mrOk;
    if Not SimpleCampaign_Exec then
    begin
      Application.CreateForm(TfmCreateCamapign, fmCreateCamapign);
      fmCreateCamapign.Update_Flag := False;
      fmCreateCamapign.lblcampaignlist.Visible := False;
      fmCreateCamapign.cbocampaignlist.Visible := False;

      fmCreateCamapign.cbomailchimplist.Items := MailChimpLists.Items;
      fmCreateCamapign.MCStrList := MailChimpStrLists;
      fmCreateCamapign.StartPath := StartPath;
      fmCreateCamapign.ShowModal;
      fmResult := fmCreateCamapign.ModalResult;
    end;

    While (fmResult = mrOk) do
    begin
      try
        LEMsg := '';
        if Not SimpleCampaign_Exec then
          Inp_JSONStr := fmCreateCamapign.Input_JSONStr
        else
          Inp_JSONStr := fmExecCampaign.Input_JSONStr;
        JObj := TJSONObject.Create;
        JObj := TJSONObject.ParseJSONValue(Inp_JSONStr) as TJSONObject;
        JObj.RemovePair('recipients');
        Inp_JSONStr := JObj.ToString;
        if Inp_JSONStr <> '' then
          CreateCampaign(Inp_JSONStr);
      except
        on e: exception do
          LEMsg := e.Message;
      end;
      if LEMsg <> '' then
      begin
        ShowMessage('Camapign not created/updated, try again');
        if Not SimpleCampaign_Exec then
          fmResult := fmCreateCamapign.ShowModal
        else
          fmResult := fmExecCampaign.ShowModal;
      end
      else
        Break;
    end;

  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmCreateCamapign) then
  begin
    fmCreateCamapign.free;
    fmCreateCamapign := nil;
    // FreeAndNil(fmCreateCamapign);
  end;
  if assigned(JObj) then
    JObj := nil;

  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.CreateandExecuteCampaign(Sel_List, Sel_Campaign: String);
begin

end;

Procedure TForm6.CreateCampaign(Inp_JSONStr: WideString);
var
  JSONObj: TJSONObject;
  Url, ErrMsg, ErrFname, UserMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
  Idx: Integer;
begin
  try
    ErrMsg := '';
    JSONObj := TJSONObject.Create;
    if Inp_JSONStr = '' then
      Inp_JSONStr :=
        '{"recipients":{"list_id":"3c307a9f3f"},"type":"regular","settings":' +
        '{"subject_line":"Your Purchase Receipt","reply_to":"orders@mammothhouse.com",'
        + '"from_name":"Customer Service"}}';

    parameters := TStringStream.Create(Inp_JSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Campaign_HttpURL;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPost;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    RespCreateCampaign := RespCreateCampaign.FromJsonString(ResultJSONStr);
    if (assigned(RespCreateCampaign.Errors)) and
      (RespCreateCampaign.Errors.Message <> '') then
      raise exception.Create(RespCreateCampaign.Errors.Message);
    if lowercase(RespCreateCampaign.status) = 'save' then
    begin
      if Not SimpleCampaign_Exec then
        ShowMessage('Campaign saved successfully.');
    end;
    // RespCreateCampaign.
    CampaignAction := 'add';
    UpdateMailChimpCampaign;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

function TForm6.GetMailChimpCampaign(Campaign_ID: String = ''): String;
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  Idx: Integer;
begin
  result := '';
  Url := Campaign_HttpURL;
  if Campaign_ID <> '' then
    Url := Url + '/' + Campaign_ID
  else
    Url := Url + Offset_Count;

  IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.BasicAuthentication := Basic_Auth;
  IdHTTP1.Request.UserName := Auth_UserName;
  IdHTTP1.Request.Password := Auth_Password;
  result := IdHTTP1.Get(Url);
end;

procedure TForm6.UpdateMailChimpCampaign;
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  Idx: Integer;
  CampaignId, CampaignTitle, ListID, ListName: String;
begin
  try
    ErrMsg := '';
    ResultJSONStr := GetMailChimpCampaign;
    // Parsing resultJSON string
    RespGetCampaign := RespGetCampaign.FromJsonString(ResultJSONStr);

    if CampaignAction <> '' then
    begin
      if CampaignAction = 'add' then
      begin
        StatusBar1.Panels[0].Text := 'Added ' +
          FloattoStr(RespGetCampaign.total_items);
        StatusBar1.Panels[1].Text := 'Updated 0';
        StatusBar1.Panels[2].Text := 'Deleted 0';
      end
      else if CampaignAction = 'delete' then
      begin
        StatusBar1.Panels[0].Text := 'Added 0';
        StatusBar1.Panels[1].Text := 'Updated 0';
        StatusBar1.Panels[2].Text := 'Deleted 1';
      end
      else if CampaignAction = 'update' then
      begin
        StatusBar1.Panels[0].Text := 'Added 0';
        StatusBar1.Panels[1].Text := 'Updated 1';
        StatusBar1.Panels[2].Text := 'Deleted 0';
      end;
      StatusBar1.Panels[3].Text := 'Run Command: Add To campaign ';
      StatusBar1.Panels[4].Text := DateTimeToStr(Now());
    end;

    // with tstringlist.create do
    // begin
    // add(ResultJSONStr);
    // savetofile('campaign_json.txt');
    // free;
    // end;

    Idx := 0;
    MailChimpCampaignLists.Clear;
    MailChimpListCampaign.Items.Clear;
    while Idx <= RespGetCampaign.total_items - 1 do
    begin
      if assigned(RespGetCampaign.campaigns[Idx]) then
      begin
        CampaignId := RespGetCampaign.campaigns[Idx].ID;
        CampaignTitle := RespGetCampaign.campaigns[Idx].settings.title;
        ListID := RespGetCampaign.campaigns[Idx].recipients.List_Id;
        if CampaignTitle = '' then
          CampaignTitle := RespGetCampaign.campaigns[Idx].settings.from_name;
        MailChimpListCampaign.Items.Add(CampaignTitle);
        // MailChimpCampaignLists.Add(CampaignId + '=' + CampaignTitle);
        MailChimpCampaignLists.Add(CampaignTitle + '=' + CampaignId);
      end;
      Inc(Idx);
    end;
    MailChimpCampaign2.Items.Clear;
    MailChimpCampaign2.Items := MailChimpListCampaign.Items;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
  begin
    if pos('Socket ', ErrMsg) > 0 then
      raise exception.Create('Please check your network connections.')
    else
      raise exception.Create(ErrMsg);
  end;
end;

Procedure TForm6.Setcampaigncontent(Campaign_ID: String;
  InputJSONStr: WideString);
var
  Url, ErrMsg, ErrFname, UserMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
  Idx: Integer;
begin
  try
    ErrMsg := '';
    if InputJSONStr = '' then
      InputJSONStr :=
        '{"html": "<p>The HTML to use for the saved campaign<./p>"}';

    parameters := TStringStream.Create(InputJSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Campaign_HttpURL + '/' + Campaign_ID + '/content';

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPut;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Put(Url, parameters);

    // Parsing resultJSON string
    RespSetCampaignContent := RespSetCampaignContent.FromJsonString
      (ResultJSONStr);
    if (assigned(RespSetCampaignContent.Errors)) and
      (RespSetCampaignContent.Errors.Message <> '') then
    begin
      raise exception.Create(RespSetCampaignContent.Errors.Message);
    end;

  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

procedure TForm6.btnLoadToCampaingClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  EMsg, CampaignId: String;
begin
  try
    EMsg := '';
    Application.CreateForm(TfmSetCampaignContent, fmSetCampaignContent);
    fmSetCampaignContent.CampaignStrList := MailChimpCampaignLists;
    fmSetCampaignContent.UpdateCampaign := UpdateCampaign;
    fmSetCampaignContent.ShowModal;
    CampaignId := fmSetCampaignContent.Sel_Campaign_id;
    Inp_JSONStr := fmSetCampaignContent.Input_JSONStr;
    if Inp_JSONStr <> '' then
    begin
      Setcampaigncontent(CampaignId, Inp_JSONStr);
      if Not SimpleCampaign_Exec then ShowMessage('Campaign content update successfully.');
    end;
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmSetCampaignContent) then
  begin
    fmSetCampaignContent.free;
    fmSetCampaignContent := nil;
    // FreeAndNil(fmSetCampaignContent);
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.btnrefreshClick(Sender: TObject);
begin
  if FileExists(ChangeFileExt(StartPath + ExtractFilename(Application.ExeName),
    '.INI')) then
  begin
    LoadSettings;
    if (HttpURL = '') or (Auth_UserName = '') or (Auth_Password = '') or
      (API_KEY = '') then
    begin
      Application.CreateForm(TfmMailChimpAccount, fmMailChimpAccount);
      fmMailChimpAccount.ShowModal;
      if assigned(fmMailChimpAccount) then
      begin
        fmMailChimpAccount.free;
        fmMailChimpAccount := nil;
        // FreeAndNil(fmMailChimpAccount);
      end;
      LoadSettings;
    end;
  end;
  LoadSimpleModeCampaign;
  LoadListandCampaign;
end;

procedure TForm6.btnSetupClick(Sender: TObject);
var
  PasswordStr: String;
begin
  LoadSetupPwd;
  PasswordStr := '';
  if SetupWinPwd <> '' then
  begin
    PostMessage(Handle, InputBoxMessage, 0, 0);
    PasswordStr := InputBox('Password', 'Please Enter a Password', '');
  end;
  if PasswordStr = SetupWinPwd { 'delphi' } then
  begin
    Application.CreateForm(TfmMailChimpAccount, fmMailChimpAccount);
    fmMailChimpAccount.StartPath := StartPath;
    fmMailChimpAccount.cbodefaultlist.Items := MailChimpLists.Items;
    fmMailChimpAccount.DoConnection := DoConnection;
    fmMailChimpAccount.ShowModal;
    if fmMailChimpAccount.ModalResult = mrOk then
    begin
      SetupWinPwd := fmMailChimpAccount.SetupWinPwd;
      LoadSettings;
      LoadListandCampaign;
    end;
    if assigned(fmMailChimpAccount) then
    begin
      fmMailChimpAccount.free;
      fmMailChimpAccount := nil;
      // FreeAndNil(fmMailChimpAccount);
    end;
  end
  else
    raise exception.Create('Incorrect password.');
end;

Procedure TForm6.LoadSetupPwd;
var
  Ini: TIniFile;
  C_Settings_Filename, D_Settings_Filename: String;
begin
  if SetupWinPwd = '' then
  begin
    C_Settings_Filename :=
      ChangeFileExt(StartPath + ExtractFilename(Application.ExeName), '.INI');
    D_Settings_Filename := ChangeFileExt(C_Settings_Filename, '.cmp');
    if FileExists(C_Settings_Filename) then
    begin
      with TCompress.Create do
      begin
        decompressfile(C_Settings_Filename, D_Settings_Filename);
        destroy;
      end;
      Ini := TIniFile.Create(D_Settings_Filename);
      try
        SetupWinPwd := Ini.ReadString('setupwinpwd', 'setupwinpwd', '');
      finally
        Ini.free;
      end;
      if FileExists(D_Settings_Filename) then
        DeleteFile(D_Settings_Filename);
    end;
  end;
end;

procedure TForm6.InputBoxSetPasswordChar(var Msg: TMessage);
var
  hInputForm, hEdit, hButton: HWND;
begin
  hInputForm := Screen.Forms[0].Handle;
  if (hInputForm <> 0) then
  begin
    hEdit := FindWindowEx(hInputForm, 0, 'TEdit', nil);
    {
      // Change button text:
      hButton := FindWindowEx(hInputForm, 0, 'TButton', nil);
      SendMessage(hButton, WM_SETTEXT, 0, Integer(PChar('Cancel')));
    }
    SendMessage(hEdit, EM_SETPASSWORDCHAR, Ord('*'), 0);
  end;
end;

procedure TForm6.btnupdateClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  EMsg, Sel_Campaign_id: String;
begin
  try
    EMsg := '';
    Application.CreateForm(TfmCreateCamapign, fmCreateCamapign);
    fmCreateCamapign.Update_Flag := True;
    fmCreateCamapign.lblcampaignlist.Visible := True;
    fmCreateCamapign.cbocampaignlist.Visible := True;
    fmCreateCamapign.cbocampaignlist.Items := MailChimpListCampaign.Items;
    fmCreateCamapign.MC_CampaignList := MailChimpCampaignLists;

    fmCreateCamapign.cbomailchimplist.Items := MailChimpLists.Items;
    fmCreateCamapign.MCStrList := MailChimpStrLists;
    fmCreateCamapign.StartPath := StartPath;
    fmCreateCamapign.ShowModal;
    Sel_Campaign_id := fmCreateCamapign.Sel_Campaign_id;
    Inp_JSONStr := fmCreateCamapign.Input_JSONStr;
    if Inp_JSONStr <> '' then
      UpdateCampaign(Sel_Campaign_id, Inp_JSONStr);
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmCreateCamapign) then
  begin
    fmCreateCamapign.free;
    fmCreateCamapign := nil;
    // FreeAndNil(fmCreateCamapign);
  end;
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

Procedure TForm6.UpdateCampaign(CampaignId: String; Inp_JSONStr: WideString);
var
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
begin
  try
    ErrMsg := '';
    if Inp_JSONStr = '' then
      Inp_JSONStr :=
        '{"recipients":{"list_id":"3c307a9f3f"},"type":"regular","settings":' +
        '{"subject_line":"This is an updated subject line","reply_to":' +
        '"orders@mammothhouse.com","from_name":"Customer Service"}}';

    parameters := TStringStream.Create(Inp_JSONStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := Campaign_HttpURL + '/' + CampaignId;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPatch;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Patch(Url, parameters);

    // Parsing resultJSON string
    RespCreateCampaign := RespCreateCampaign.FromJsonString(ResultJSONStr);
    if assigned(RespCreateCampaign.Errors) and
      (RespCreateCampaign.Errors.Message <> '') then
      raise exception.Create(RespCreateCampaign.Errors.Message);
    if lowercase(RespCreateCampaign.status) = 'save' then
    begin
      if Not SimpleCampaign_Exec then
        ShowMessage('Campaign updated successfully.');
    end;
    // RespCreateCampaign.
    CampaignAction := 'update';
    UpdateMailChimpCampaign;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

function TForm6.DoDummyConnection(HttpURL, A_UserName, A_Password: String;
  Basic_Auth: Boolean): Boolean;
var
  ResultJSONStr: String;
begin
  try
    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := A_UserName;
    IdHTTP1.Request.Password := A_Password;
    ResultJSONStr := IdHTTP1.Get(HttpURL + '/lists');
  Except
    on e: exception do

  end;
end;

function TForm6.DoConnection(HttpURL, A_UserName, A_Password: String;
  Basic_Auth: Boolean): Boolean;
var
  ResultJSONStr: String;
begin
  try

    DoDummyConnection(HttpURL + 'dummy', A_UserName, A_Password, Basic_Auth);

    // IdHTTP1.destroy;
    // IdHTTP1 := TIdHTTP.Create(nil);

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';

    IdHTTP1.Request.BasicAuthentication := Basic_Auth;
    IdHTTP1.Request.UserName := A_UserName;
    IdHTTP1.Request.Password := A_Password;
    ResultJSONStr := IdHTTP1.Get(HttpURL + '/lists');
    // Parsing resultJSON string
    GetListResp := GetListResp.FromJsonString(ResultJSONStr);
    if assigned(GetListResp) then
    begin
      if GetListResp.total_items >= 0 then
        ShowMessage('Test connection successful.')
      else
        ShowMessage('Test connection failed.');
    end
    else
      ShowMessage('Test connection failed.');
  Except
    on e: exception do
      ShowMessage('Error ' + e.Message);
  end;
end;

Procedure TForm6.WriteLog(Msg: String);
var
  FileName: String;
begin
  try
    if Not IsTrace then
      Exit;
    FileName := StartPath + 'tracemsg.txt';
    With TStringList.Create do
    begin
      if FileExists(FileName) then
        LoadFromFile(FileName);
      Add(Msg);
      SaveToFile(FileName);
      free;
    end;
  Except
    on e: exception do

  end;
end;

end.

(* {Dummy codes}
  procedure SaveData(FileName: TFileName);
  var
  MemStr: TMemoryStream;
  Title: String;
  begin
  MemStr:= TMemoryStream.Create;
  try
  MemStr.Seek(0, soFromBeginning);
  WriteStreamStr( MemStr, TItle );
  MemStr.SaveToFile(FileName);
  finally
  MemStr.Free;
  end;
  end;

  procedure LoadData(FileName: TFileName);
  var
  MemStr: TMemoryStream;
  Title: String;
  begin
  MemStr:= TMemoryStream.Create;
  try
  MemStr.LoadFromFile(FileName);
  MemStr.Seek(0, soFromBeginning);
  Title := ReadStreamStr( MemStr );
  finally
  MemStr.Free;
  end;
  end;



  procedure WriteStreamInt(Stream : TStream; Num : integer);
  {writes an integer to the stream}
  begin
  Stream.WriteBuffer(Num, SizeOf(Integer));
  end;

  procedure WriteStreamStr(Stream : TStream; Str : string);
  {writes a string to the stream}
  var
  StrLen : integer;
  begin
  {get length of string}
  StrLen := Length(Str);
  {write length of string}
  WriteStreamInt(Stream, StrLen);
  if StrLen > 0 then
  {write characters}
  Stream.Write(Str[1], StrLen);
  end;


  function ReadStreamInt(Stream : TStream) : integer;
  {returns an integer from stream}
  begin
  Stream.ReadBuffer(Result, SizeOf(Integer));
  end;

  function ReadStreamStr(Stream : TStream) : string;
  {returns a string from the stream}
  var
  LenStr : integer;
  begin
  Result := '';
  {get length of string}
  LenStr := ReadStreamInt(Stream);
  {set string to get memory}
  SetLength(Result, LenStr);
  {read characters}
  Stream.Read(Result[1], LenStr);
  end;
*)
