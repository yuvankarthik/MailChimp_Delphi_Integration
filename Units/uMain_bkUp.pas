unit uMain_bkUp;

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
  uCampaign, uSetCampaignContent,inifiles,uSettings;

type
  TForm6 = class(TForm)
    ListDBGrid1: TDBGrid;
    ListFDMemTable: TFDMemTable;
    btnAdd: TButton;
    btnAddUpdate: TButton;
    Button1: TButton;
    btnAddUpdateDelets: TButton;
    StatusBar1: TStatusBar;
    MailChimpLists: TListBox;
    lbledtBoxSize1: TLabeledEdit;
    btnCreateList: TButton;
    MailChimpListCampaign: TListBox;
    DataSource1: TDataSource;
    strngfldFDMemTable1LASTNAME: TStringField;
    strngfldFDMemTable1NAME: TStringField;
    strngfldFDMemTable1address: TStringField;
    strngfldFDMemTable1city: TStringField;
    strngfldFDMemTable1State: TStringField;
    strngfldFDMemTable1zip: TStringField;
    strngfldFDMemTable1email: TStringField;
    btn1: TButton;
    strngfldFDMemTable1ID: TStringField;
    pnlList: TPanel;
    pnlCampaign: TPanel;
    LabeledEdit1: TLabeledEdit;
    btnAddCappaign: TButton;
    memo1: TMemo;
    btnLoadToCampaing: TButton;
    FileListBox1: TFileListBox;
    pnlExacute: TPanel;
    MailChimpList2: TListBox;
    MailChimpCampaign2: TListBox;
    btnExaute: TButton;
    btnSetup: TButton;
    IdHTTP1: TIdHTTP;
    Label1: TLabel;
    btnupdate: TButton;
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

    FDCol_StrList, MailChimpStrLists, MailChimpCampaignLists: TStringList;
    StartPath: String;

    HttpURL,Lists_HttpURL,Campaign_HttpURL,API_KEY ,Auth_UserName , Auth_Password : String;


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

    { Private declarations }
  public
    { Public declarations }
  end;

  // added by KarthikThirumoorthi
//Const
//  Lists_HttpURL = 'https://us15.api.mailchimp.com/3.0/lists';
//  Campaign_HttpURL = 'https://us15.api.mailchimp.com/3.0/campaigns';
//  API_KEY = 'e8b164b319d94fa2bc00e1678debb5a0';
//  Auth_UserName = 'dummy';
//  Auth_Password = API_KEY;

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
  fmListMember: TfmListMember;
  Inp_JSONStr: WideString;
  EMsg: String;
begin
  try
    EMsg := '';
    Application.CreateForm(TfmListMember, fmListMember);
    fmListMember.CboListItems.Items := MailChimpLists.Items;
    fmListMember.CboListItems_M.Items := MailChimpLists.Items;
    fmListMember.MCStrList := MailChimpStrLists;
    fmListMember.ShowModal;
    Inp_JSONStr := fmListMember.Input_JSONStr;
    if Inp_JSONStr <> '' then
      AddorUpdateMembersinList(fmListMember.Selected_ListID, Inp_JSONStr);
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmCreateList) then
    FreeAndNil(fmCreateList);
  if EMsg <> '' then
    raise exception.Create(EMsg);
  // ShowMessage('This should only ADD new emails to list and return a how many updated');
end;

procedure TForm6.btnAddUpdateClick(Sender: TObject);
begin
  btnAddClick(nil);
  // ShowMessage('This should only ADD new emails And UPDATE to list and return a how many ADDED and How Many updated');
end;

procedure TForm6.btnCreateListClick(Sender: TObject);
var
  fmCreateList: TfmCreateList;
  Inp_JSONStr: WideString;
begin
  try
    Application.CreateForm(TfmCreateList, fmCreateList);
    fmCreateList.CreateListResp := CreateListResp;
    fmCreateList.ShowModal;
    Inp_JSONStr := fmCreateList.List_Input_JSONStr;
    if Inp_JSONStr <> '' then
      AddList(Inp_JSONStr);
    ShowMessage('list created successfully.');
  except
    on e: exception do

  end;
  if assigned(fmCreateList) then
    FreeAndNil(fmCreateList);

  // ShowMessage('This creates a new Mailchimp List');
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
    SendMail(Sel_CampaignID);
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
    IdHTTP1.Request.BasicAuthentication := True;
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
  I: Integer;
  List_Id: String;
  S: TStringList;
  MailIds: WideString;
begin

  for I := 0 to ListFDMemTable.RecordCount - 1 do
  begin
    List_Id := VartoStr(ListFDMemTable.FieldByName('ID').Value);
    MailIds := GetMailIDsFromList(List_Id);
    CheckMailidsAndDeleteFromMailChimp(List_Id, '', MailIds);
  end;
  // ShowMessage('This should only Delete from list list any etery on list no email found for it in DATASET, return amount deleted' );
end;

function TForm6.GetMailIDsFromList(IP_ListID: String): WideString;
var
  I: Integer;
  FDQuery: TFDQuery;
  EmsgStr: String;
begin
  result := '';
  EmsgStr := '';
  try
    FDQuery := TFDQuery.Create(nil);
    FDQuery.CopyDataSet(ListFDMemTable);
    FDQuery.Filter := 'ID = ' + QuotedStr(IP_ListID);
    for I := 0 to FDQuery.RecordCount - 1 do
    begin
      if result = '' then
        result := VartoStr(FDQuery.FieldByName('email').Value)
      else
        result := result + ',' + VartoStr(FDQuery.FieldByName('email').Value);
    end;
  Except
    on e: exception do
      EmsgStr := e.Message;
  end;
  if EmsgStr <> '' then
    raise exception.Create(EmsgStr);
  if assigned(FDQuery) then
    FreeAndNil(FDQuery);
end;


Procedure TForm6.LoadSettings;
var
   Ini: TIniFile;
begin
   Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
   try
     HttpURL := Ini.ReadString( 'url', 'url', '' );
     if AnsiLastChar(HttpURL) = '/' then delete(HttpURL,length(HttpURL),1);
     Lists_HttpURL := HttpURL+'/lists';
     Campaign_HttpURL := HttpURL+'/campaigns';
     Auth_UserName := Ini.ReadString( 'username', 'username', '' );
     Auth_Password := Ini.ReadString( 'password', 'password', '' );
     API_KEY := Ini.ReadString( 'api', 'api', '' );
   finally
     Ini.Free;
   end;
end;



procedure TForm6.FormCreate(Sender: TObject);
begin
  LoadSettings;
  if (HttpURL = '') or (Auth_UserName = '') or (Auth_Password = '')
     or (API_KEY = '') then
  begin
    Application.CreateForm(TfmMailChimpAccount,fmMailChimpAccount);
    fmMailChimpAccount.ShowModal;
    if assigned(fmMailChimpAccount) then
       FreeAndNil(fmMailChimpAccount);
    LoadSettings;
  end;

  StartPath := ExtractFilePath(ParamStr(0));
  if AnsiLastChar(StartPath) <> '\' then
    StartPath := StartPath + '\';
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

  ListFDMemTable.LoadFromFile('mydata.fds');
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  if assigned(ListResp) then
    FreeAndNil(ListResp);
  if assigned(CreateListResp) then
    FreeAndNil(CreateListResp);

  if assigned(GetListResp) then
    FreeAndNil(GetListResp);
  if assigned(ErrorListResp) then
    FreeAndNil(ErrorListResp);
  if assigned(ListMemberResp) then
    FreeAndNil(ListMemberResp);
  if assigned(GetListMemberResp) then
    FreeAndNil(GetListMemberResp);

  if assigned(CreateCampaignClass) then
    FreeAndNil(CreateCampaignClass);
  if assigned(RespCreateCampaign) then
    FreeAndNil(RespCreateCampaign);
  if assigned(RespGetCampaign) then
    FreeAndNil(RespGetCampaign);
  if assigned(RespSetCampaignContent) then
    FreeAndNil(RespSetCampaignContent);
  if assigned(ErrClass) then
    FreeAndNil(ErrClass);

  if assigned(FDCol_StrList) then
    FreeAndNil(FDCol_StrList);
  if assigned(MailChimpStrLists) then
    FreeAndNil(MailChimpStrLists);

  if assigned(MailChimpCampaignLists) then
    FreeAndNil(MailChimpCampaignLists);

end;

procedure TForm6.FormShow(Sender: TObject);
begin
  UpdateMailChimpCampaign;
  UpdateMailChimpListsAndFDMemTable;
end;

procedure WriteStreamInt(Stream: TStream; Num: Integer);
{ writes an integer to the stream }
begin
  Stream.WriteBuffer(Num, SizeOf(Integer));
end;

Procedure TForm6.AddList(IP_Json_Str: WideString);
var
  jsonObj: TJSONObject;
  mStream: TMemoryStream;
  Url, JsonStr, JsResult, ErrMsg, Fname, TFile: String;
  InputJSONStr, ResultJSONStr: WideString;
  parameters: TStringStream;
  jsonArray: TJsonArray;
  jsonPair: TJsonPair;
  StrLen: Integer;
begin
  try
    ErrMsg := '';
    jsonObj := TJSONObject.Create;
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    ListResp := ListResp.FromJsonString(ResultJSONStr);

    if Assigned(ListResp.Errors) and (Trim(ListResp.Errors.Message) <> '') then
      raise exception.Create(ListResp.Errors.Message);

    UpdateMailChimpListsAndFDMemTable;

    // ListResp.id;   //List ID
    // ListResp.name; //List Name

  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(jsonObj) then
    FreeAndNil(jsonObj);
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
    Url := Lists_HttpURL;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Get(Url);
    // Parsing resultJSON string
    GetListResp := GetListResp.FromJsonString(ResultJSONStr);

    Idx := 0;
    MailChimpStrLists.Clear;
    MailChimpLists.Items.Clear;
    // ListFDMemTable.DisableControls;
    while Idx < GetListResp.total_items-1 do
    begin
      try
        ListID := GetListResp.lists[Idx].ID;
        ListName := GetListResp.lists[Idx].Name;
        // LastName := GetListResp.lists[Idx].campaign_defaults.from_name;

  //      Address := GetListResp.lists[Idx].contact.address1;
  //      City := GetListResp.lists[Idx].contact.City;
  //      State := GetListResp.lists[Idx].contact.State;
  //      Zip := GetListResp.lists[Idx].contact.Zip;
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

        //MailChimpStrLists.Add(ListID + '=' + ListName);
        MailChimpStrLists.Add(ListName + '=' + ListID);
        // UpdateFDMemTableandGrid(ListID, Address , City , State , Zip);
        Inc(Idx);
      Except on e:exception do
        begin
          Inc(Idx);
          Continue;
        end;
      end;
    end;
    MailChimpList2.Items.Clear;
    MailChimpList2.Items := MailChimpLists.Items;
    // ListFDMemTable.EnableControls;
    //ListDBGrid1.Refresh;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
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
  Url := Lists_HttpURL + '/' + Member_ListID + '/members';

  IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.BasicAuthentication := True;
  IdHTTP1.Request.UserName := Auth_UserName;
  IdHTTP1.Request.Password := Auth_Password;
  ResultJSONStr := IdHTTP1.Get(Url);

  ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
  if ErrorListResp.detail <> '' then
  begin
    raise exception.Create(FloattoStr(ErrorListResp.Status) + ' - ' +
      ErrorListResp.detail);
  end;
  // Parsing resultJSON string
  GetListMemberResp := GetListMemberResp.FromJsonString(ResultJSONStr);
  TotCount := Round(GetListMemberResp.total_items);
  ListID := GetListMemberResp.List_Id;
  ListFDMemTable.DisableControls;
  for Idx_Val := 0 to TotCount - 1 do
  begin
    MemberID := GetListMemberResp.members[Idx_Val].ID;
    Email_UniqueID := GetListMemberResp.members[Idx_Val].unique_email_id;
    Name := GetListMemberResp.members[Idx_Val].merge_fields.Fname;
    LastName := GetListMemberResp.members[Idx_Val].merge_fields.LNAME;
    Email := GetListMemberResp.members[Idx_Val].email_address;

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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Delete(Url);
    // Parsing resultJSON string
    if Trim(ResultJSONStr) = '' then
      ShowMessage('List deleted successfully.')
    else
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
      begin
        raise exception.Create(FloattoStr(ErrorListResp.Status) + ' - ' +
          ErrorListResp.detail);
      end;
    end;
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
  jsonObj: TJSONObject;
  Url, ErrMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
begin
  try
    ErrMsg := '';
    jsonObj := TJSONObject.Create;
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Patch(Url, parameters);

    // Parsing resultJSON string
    ListResp := ListResp.FromJsonString(ResultJSONStr);

    if Assigned(ListResp.Errors) and (Trim(ListResp.Errors.Message) <> '') then
      raise exception.Create(ListResp.Errors.Message)
    else if ListResp.ID <> List_Id then
      ShowMessage('List updated successfully.');
    UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(jsonObj) then
    FreeAndNil(jsonObj);
  if assigned(parameters) then
    FreeAndNil(parameters);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;

Procedure TForm6.AddorUpdateMembersinList(List_Id: String;
  InputJSONStr: WideString);
var
  jsonObj: TJSONObject;
  Url, ErrMsg, ErrFname, UserMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
  Idx: Integer;
begin
  try
    ErrMsg := '';
    jsonObj := TJSONObject.Create;
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    ListMemberResp := ListMemberResp.FromJsonString(ResultJSONStr);

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
        Free;
      end;
      UserMsg := UserMsg + #13 + ' Error file available in : ' + ErrFname;
    end;

    UpdateMailChimpListsAndFDMemTable;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(jsonObj) then
    FreeAndNil(jsonObj);
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Delete(Url);

    // Parsing resultJSON string
    if Trim(ResultJSONStr) = '' then
      ShowMessage('List member deleted successfully.')
    else
    begin
      ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
      if ErrorListResp.detail <> '' then
      begin
        raise exception.Create(FloattoStr(ErrorListResp.Status) + ' - ' +
          ErrorListResp.detail);
      end;
    end;
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

// Get given position of string from CommaText
Function TForm6.GetNthString(SrcString: String; StrPos: Integer): String;
Var
  I, k: Integer;
Begin
  result := '';
  I := 1;
  k := 1;
  while (k <= StrPos) and (I <= Length(SrcString)) do
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
      Url := Url + '/' + subscriber_hash;
    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Get(Url);

    ErrorListResp := ErrorListResp.FromJsonString(ResultJSONStr);
    if ErrorListResp.detail <> '' then
    begin
      raise exception.Create(FloattoStr(ErrorListResp.Status) + ' - ' +
        ErrorListResp.detail);
    end;
    // Parsing resultJSON string
    GetListMemberResp := GetListMemberResp.FromJsonString(ResultJSONStr);
    TotCount := Round(GetListMemberResp.total_items) - 1;
    ListID := GetListMemberResp.List_Id;

    // for Idx_Val := 0 to TotCount - 1 do
    // begin
    // MemberID := GetListMemberResp.members[Idx_Val].ID;
    // Email_UniqueID := GetListMemberResp.members[Idx_Val].unique_email_id;
    // Email := GetListMemberResp.members[Idx_Val].email_address;
    // end;

    while TotCount >= 0 do
    begin
      MemberID := GetListMemberResp.members[Idx_Val].ID;
      Email := GetListMemberResp.members[Idx_Val].email_address;
      subscr_hash := GetListMemberResp.members[Idx_Val].ID;
      // The MD5 hash of the lowercase version of the list member’s email address
      if StrList_MailIds.IndexOf(Email) < 0 then
      begin
        DeleteMembersFromList(MemberID, subscr_hash);
        Inc(DelCount);
      end;
    end;
    ShowMessage(InttoStr(DelCount) + ' memebers deleted from members list.');
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;
  if assigned(StrList_MailIds) then
    FreeAndNil(StrList_MailIds);
  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
end;



// MailChimp campaign

procedure TForm6.btnAddCappaignClick(Sender: TObject);
var
  Inp_JSONStr: WideString;
  EMsg: String;
begin
  try
    EMsg := '';
    Application.CreateForm(TfmCreateCamapign, fmCreateCamapign);
    fmCreateCamapign.Update_Flag := False;
    fmCreateCamapign.lblcampaignlist.Visible := False;
    fmCreateCamapign.cbocampaignlist.Visible := False;

    fmCreateCamapign.cboMailChimpList.Items := MailChimpLists.Items;
    fmCreateCamapign.MCStrList := MailChimpStrLists;
    fmCreateCamapign.ShowModal;
    Inp_JSONStr := fmCreateCamapign.Input_JSONStr;
    if Inp_JSONStr <> '' then CreateCampaign(Inp_JSONStr);
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmCreateCamapign) then
    FreeAndNil(fmCreateCamapign);
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

Procedure TForm6.CreateCampaign(Inp_JSONStr: WideString);
var
  jsonObj: TJSONObject;
  Url, ErrMsg, ErrFname, UserMsg: String;
  ResultJSONStr: WideString;
  parameters: TStringStream;
  Idx: Integer;
begin
  try
    ErrMsg := '';
    jsonObj := TJSONObject.Create;
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Post(Url, parameters);

    // Parsing resultJSON string
    RespCreateCampaign := RespCreateCampaign.FromJsonString(ResultJSONStr);
    if (Assigned(RespCreateCampaign.Errors)) and (RespCreateCampaign.Errors.Message <> '') then
      raise exception.Create(RespCreateCampaign.Errors.Message);
    if lowercase(RespCreateCampaign.Status) = 'save' then
      ShowMessage('Campaign saved successfully.');
    // RespCreateCampaign.

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
    Url := Url + '/' + Campaign_ID;

  IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodGet;
  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.BasicAuthentication := True;
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

    Idx := 0;
    MailChimpCampaignLists.Clear;
    MailChimpListCampaign.Items.Clear;
    while Idx < RespGetCampaign.total_items -1 do
    begin
      CampaignId := RespGetCampaign.campaigns[Idx].ID;
      CampaignTitle := RespGetCampaign.campaigns[Idx].settings.title;
      ListID := RespGetCampaign.campaigns[Idx].recipients.List_Id;
      if CampaignTitle = '' then
         CampaignTitle := RespGetCampaign.campaigns[Idx].settings.from_name;
      MailChimpListCampaign.Items.Add(CampaignTitle);
      //MailChimpCampaignLists.Add(CampaignId + '=' + CampaignTitle);
      MailChimpCampaignLists.Add(CampaignTitle + '=' + CampaignId);
      Inc(Idx);
    end;
    MailChimpCampaign2.Items.Clear;
    MailChimpCampaign2.Items := MailChimpListCampaign.Items;
  Except
    on e: exception do
      ErrMsg := e.Message;
  end;

  if ErrMsg <> '' then
    raise exception.Create(ErrMsg);
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Put(Url, parameters);

    // Parsing resultJSON string
    RespSetCampaignContent := RespSetCampaignContent.FromJsonString
      (ResultJSONStr);
    if (Assigned(RespSetCampaignContent.Errors)) and (RespSetCampaignContent.Errors.Message <> '') then
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

    fmSetCampaignContent.cbocampaignlist.Items := MailChimpListCampaign.Items;
    fmSetCampaignContent.CampaignStrList := MailChimpCampaignLists;
    fmSetCampaignContent.ShowModal;
    CampaignId := fmSetCampaignContent.Sel_Campaign_id;
    Inp_JSONStr := fmSetCampaignContent.Input_JSONStr;
    if Inp_JSONStr <> '' then Setcampaigncontent(CampaignId, Inp_JSONStr);
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmSetCampaignContent) then
    FreeAndNil(fmSetCampaignContent);
  if EMsg <> '' then
    raise exception.Create(EMsg);
end;

procedure TForm6.btnSetupClick(Sender: TObject);
begin
  if (HttpURL = '') or (Auth_UserName = '') or (Auth_Password = '')
     or (API_KEY = '') then
  begin
    Application.CreateForm(TfmMailChimpAccount,fmMailChimpAccount);
    fmMailChimpAccount.ShowModal;
    if assigned(fmMailChimpAccount) then
       FreeAndNil(fmMailChimpAccount);
    LoadSettings;
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

    fmCreateCamapign.cboMailChimpList.Items := MailChimpLists.Items;
    fmCreateCamapign.MCStrList := MailChimpStrLists;
    fmCreateCamapign.ShowModal;
    Sel_Campaign_id := fmCreateCamapign.Sel_Campaign_id;
    Inp_JSONStr := fmCreateCamapign.Input_JSONStr;
    if Inp_JSONStr <> '' then UpdateCampaign(Sel_Campaign_id, Inp_JSONStr);
  except
    on e: exception do
      EMsg := e.Message;
  end;
  if assigned(fmCreateCamapign) then
    FreeAndNil(fmCreateCamapign);
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
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultJSONStr := IdHTTP1.Patch(Url, parameters);

    // Parsing resultJSON string
    RespCreateCampaign := RespCreateCampaign.FromJsonString(ResultJSONStr);
    if Assigned(RespCreateCampaign.Errors) and (RespCreateCampaign.Errors.Message <> '') then
      raise exception.Create(RespCreateCampaign.Errors.Message);
    if lowercase(RespCreateCampaign.Status) = 'save' then
      ShowMessage('Campaign updated successfully.');
    // RespCreateCampaign.

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

end.

(*
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
