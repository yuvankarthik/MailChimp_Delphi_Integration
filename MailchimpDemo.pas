unit MailchimpDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.StdCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FireDAC.Stan.StorageBin, Vcl.ExtCtrls, Vcl.FileCtrl,
  JSON,IdHTTP,IdCoderMIME,IdURI,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TForm6 = class(TForm)
    DBGrid1: TDBGrid;
    FDMemTable1: TFDMemTable;
    btnAdd: TButton;
    btnAddUpdate: TButton;
    Button1: TButton;
    btnAddUpdateDelets: TButton;
    StatusBar1: TStatusBar;
    lst1: TListBox;
    lbledtBoxSize1: TLabeledEdit;
    btnCreateList: TButton;
    lstCampaign: TListBox;
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
    lst2: TListBox;
    lst3: TListBox;
    btnExaute: TButton;
    btnSetup: TButton;
    IdHTTP1: TIdHTTP;
    procedure btnAddClick(Sender: TObject);
    procedure btnAddUpdateClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCreateListClick(Sender: TObject);
  private
    procedure AddList;
    { Private declarations }
  public
    { Public declarations }
  end;

//added by KarthikThirumoorthi
Const
  HttpURL = 'https://us15.api.mailchimp.com/3.0/lists';
  API_KEY = 'e8b164b319d94fa2bc00e1678debb5a0';
  Auth_UserName = 'dummy';
  Auth_Password = API_KEY;
var
  Form6: TForm6;


implementation

{$R *.dfm}

procedure TForm6.btn1Click(Sender: TObject);
begin
FDMemTable1.SaveToFile('myData');
end;

procedure TForm6.btnAddClick(Sender: TObject);
begin
  AddList;
//ShowMessage('This should only ADD new emails to list and return a how many updated');
end;

procedure TForm6.btnAddUpdateClick(Sender: TObject);
begin
ShowMessage('This should only ADD new emails And UPDATE to list and return a how many ADDED and How Many updated');
end;

procedure TForm6.btnCreateListClick(Sender: TObject);
begin
ShowMessage('This creates a new Mailchimp List');
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
ShowMessage('This should only Delete from list list any etery on list no email found for it in DATASET, return amount deleted' );
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
FDMemTable1.LoadFromFile('mydata.fds');
end;


procedure WriteStreamInt(Stream : TStream; Num : integer);
 {writes an integer to the stream}
begin
 Stream.WriteBuffer(Num, SizeOf(Integer));
end;


Procedure TForm6.AddList;
var
  jsonObj: TJSONObject;
  mStream: TMemoryStream;
  Url, ResultStr, JsonStr, JsResult, ErrMsg, Fname, TFile: String;
  JStr : WideString;
  parameters: TStringStream;
  jsonArray: TJsonArray;
  jsonPair: TJsonPair;
  StrLen : Integer;
begin
  try

    jsonObj := TJSONObject.Create;
    //mStream := TMemoryStream.Create;

    JStr := '{"name":"Freddies Favorite Hats","contact":{"company":"MailChimp",'+
            '"address1":"675 Ponce De Leon Ave NE","address2":"Suite 5000",'+
            '"city":"Atlanta","state":"GA","zip":"30308","country":"US","phone":""},'+
            '"permission_reminder":"You are receiving this email because you signed up'+
            ' for updates about Freddies newest hats.","campaign_defaults":'+
            '{"from_name":"Freddie","from_email":"freddie@freddiehats.com","subject":"",'+
            '"language":"en"},"email_type_option":true}';

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


    parameters := TStringStream.Create(JStr, TEncoding.UTF8);
    // in URL \ (backward slash) used for sending query parameters , so we have replaced backslash by tilt (~) in query parameters
    // After receiving request in server we are again replacing tilt by backslash
    Url := HttpURL;

    IdHTTP1.Request.Method := IdHTTP.Id_HTTPMethodPost;
    IdHTTP1.Request.ContentType := 'application/json';
    IdHTTP1.Request.BasicAuthentication := True;
    IdHTTP1.Request.UserName := Auth_UserName;
    IdHTTP1.Request.Password := Auth_Password;
    ResultStr := IdHTTP1.Post(Url, parameters);
    if ResultStr <> '' then
    Begin
      jsonObj := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(ResultStr),
        0) as TJSONObject;
      jsonPair := jsonObj.Get('result');
      if assigned(jsonPair) then
      begin
        jsonArray := jsonPair.JsonValue as TJsonArray;
        if assigned(jsonArray) then
        begin
          JsonStr := (jsonArray.Get(0) as TJSONString).Value;
          jsonObj := TJSONObject.ParseJSONValue
            (TEncoding.ASCII.GetBytes(JsonStr), 0) as TJSONObject;
          if assigned(jsonObj) then
          begin
            jsonPair := jsonObj.Get('error');
            if assigned(jsonPair) then
              JsResult := jsonPair.JsonValue.Value;
            if JsResult <> '' then
              raise exception.Create(JsResult);
          end;
        end;
      end;
    End;
  Except
    on e: exception do
      ErrMsg := e.message;
  end;
  if assigned(jsonObj) then
    FreeAndNil(jsonObj);
  if assigned(mStream) then
    FreeAndNil(mStream);
  if assigned(parameters) then
    FreeAndNil(parameters);
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

