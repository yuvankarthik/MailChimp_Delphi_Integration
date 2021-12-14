unit uCreateList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  uCreateListJSON, Inifiles, uCompress;

type
  TfmCreateList = class(TForm)
    grpListDetails: TGroupBox;
    brpnotifications: TGroupBox;
    cbsubscribe: TCheckBox;
    cbunsubscribe: TCheckBox;
    lblsubscribe: TLabel;
    edsubscribeEmail: TEdit;
    lblunsubscribe: TLabel;
    edunsubscribeEmail: TEdit;
    lbllistname: TLabel;
    edlistname: TEdit;
    lblfromname: TLabel;
    edfromname: TEdit;
    lblfrommail: TLabel;
    edfrommail: TEdit;
    lblremindpermission: TLabel;
    memoremindpermission: TMemo;
    lblcompany: TLabel;
    edcompany: TEdit;
    lbladdr1: TLabel;
    edaddr1: TEdit;
    lblcity: TLabel;
    edcity: TEdit;
    lblzipcode: TLabel;
    edzipcode: TEdit;
    lblcountry: TLabel;
    edcountry: TEdit;
    lblphone: TLabel;
    edphone: TEdit;
    lbladdr2: TLabel;
    edaddr2: TEdit;
    pnlBottom: TPanel;
    btnSave: TButton;
    btncancel: TButton;
    lblstate: TLabel;
    edstate: TEdit;
    cboRemindPeople: TComboBox;
    procedure cbsubscribeClick(Sender: TObject);
    procedure cbunsubscribeClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure EnableComps(EdComp: TEdit; Bool_val: Boolean);
    function ValidateListForm: Boolean;
    procedure LoadListInfo;

    { Private declarations }
  public
    CreateListResp: TCreateListJSON;
    List_Input_JSONStr: WideString;
    StartPath: String;
    isFirstTime: Boolean;

    { Public declarations }
  end;

var
  fmCreateList: TfmCreateList;

implementation

{$R *.dfm}

procedure TfmCreateList.btncancelClick(Sender: TObject);
begin
  self.ModalResult := mrCancel;
  self.CloseModal();
end;

(* InputJSONStr := '{"name":"Freddies Favorite Hats","contact":{"company":"MailChimp",'+
  '"address1":"675 Ponce De Leon Ave NE","address2":"Suite 5000",'+
  '"city":"Atlanta","state":"GA","zip":"30308","country":"US","phone":""},'+
  '"permission_reminder":"You are receiving this email because you signed up'+
  ' for updates about Freddies newest hats.","campaign_defaults":'+
  '{"from_name":"Freddie","from_email":"freddie@freddiehats.com","subject":"",'+
  '"language":"en"},"email_type_option":true}'; *)

procedure TfmCreateList.btnSaveClick(Sender: TObject);
begin
  if ValidateListForm then
  begin
    CreateListResp.name := edlistname.Text;
    CreateListResp.contact.company := edcompany.Text;
    CreateListResp.contact.address1 := edaddr1.Text;
    CreateListResp.contact.address2 := edaddr2.Text;
    CreateListResp.contact.city := edcity.Text;
    CreateListResp.contact.state := edstate.Text;
    CreateListResp.contact.country := edcountry.Text;
    CreateListResp.contact.zip := edzipcode.Text;
    CreateListResp.contact.phone := edphone.Text;
    CreateListResp.permission_reminder := cboRemindPeople.Text;
    // memoremindpermission.Text;
    CreateListResp.campaign_defaults.from_name := edfromname.Text;
    CreateListResp.campaign_defaults.from_email := edfrommail.Text;
    CreateListResp.campaign_defaults.subject := '';
    CreateListResp.campaign_defaults.language := 'en';
    CreateListResp.email_type_option := true;
    if cbsubscribe.Checked then
      CreateListResp.notify_on_subscribe := edsubscribeEmail.Text;
    if cbunsubscribe.Checked then
      CreateListResp.notify_on_unsubscribe := edunsubscribeEmail.Text;
  end;

  With TStringList.Create do
  begin
    StrictDelimiter := true;
    if fileexists(StartPath + 'remindme.lis') then
      LoadfromFile(StartPath + 'remindme.lis');
    if IndexOf(cboRemindPeople.Text) < 0 then
      Add(cboRemindPeople.Text);
    SavetoFile(StartPath + 'remindme.lis');
    Free;
  end;

  List_Input_JSONStr := CreateListResp.ToJsonString;
  self.ModalResult := mrOK;
  self.CloseModal();
end;

procedure TfmCreateList.cbsubscribeClick(Sender: TObject);
begin
  EnableComps(edsubscribeEmail, cbsubscribe.Checked);
end;

procedure TfmCreateList.cbunsubscribeClick(Sender: TObject);
begin
  EnableComps(edunsubscribeEmail, cbunsubscribe.Checked);
end;

Procedure TfmCreateList.EnableComps(EdComp: TEdit; Bool_val: Boolean);
begin
  EdComp.Enabled := Bool_val;
  if Not Bool_val then
    EdComp.Text := '';
end;

procedure TfmCreateList.FormCreate(Sender: TObject);
begin
  isFirstTime := true;
end;

procedure TfmCreateList.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;

  if (fileexists(ChangeFileExt(StartPath + ExtractFilename(Application.ExeName),
    '.INI'))) and isFirstTime then
  begin
    LoadListInfo;
    isFirstTime := False;
  end;

  if fileexists(StartPath + 'remindme.lis') then
  begin
    With TStringList.Create do
    begin
      StrictDelimiter := true;
      LoadfromFile(StartPath + 'remindme.lis');
      cboRemindPeople.Items.Text := Text;
      Free;
    end;
  end;
end;

function TfmCreateList.ValidateListForm: Boolean;
begin
  result := False;
  if edlistname.Text = '' then
    raise Exception.Create('List name should not be empty.')
  else if edfromname.Text = '' then
    raise Exception.Create('From name should not be empty.')
  else if edfrommail.Text = '' then
    raise Exception.Create('From mail address should not be empty.')
  else if { memoremindpermission.Text } cboRemindPeople.Text = '' then
    raise Exception.Create('Remind note should not be empty.')
  else if edcompany.Text = '' then
    raise Exception.Create('Company / Organization name should not be empty.')
  else if edaddr1.Text = '' then
    raise Exception.Create('Address should not be empty.')
  else if edcity.Text = '' then
    raise Exception.Create('City should not be empty.')
  else if edzipcode.Text = '' then
    raise Exception.Create('Zip / Postal code should not be empty.')
  else if edcountry.Text = '' then
    raise Exception.Create('Country should not be empty.');
  result := true;
end;

Procedure TfmCreateList.LoadListInfo;
var
  Ini: TIniFile;
  C_Settings_Filename, D_Settings_Filename: String;
begin
  C_Settings_Filename :=
    ChangeFileExt(StartPath + ExtractFilename(Application.ExeName), '.INI');
  D_Settings_Filename := ChangeFileExt(C_Settings_Filename, '.cmp');
  if fileexists(C_Settings_Filename) then
  begin
    with TCompress.Create do
    begin
      decompressfile(C_Settings_Filename, D_Settings_Filename);
      destroy;
    end;
    Ini := TIniFile.Create(D_Settings_Filename);
    try
      edfromname.Text := Ini.ReadString('fromname', 'fromname', '');
      edfrommail.Text := Ini.ReadString('frommail', 'frommail', '');
      edcompany.Text := Ini.ReadString('company', 'company', '');
      edaddr1.Text := Ini.ReadString('address1', 'address1', '');
      edaddr2.Text := Ini.ReadString('address2', 'address2', '');
      edcity.Text := Ini.ReadString('city', 'city', '');
      edstate.Text := Ini.ReadString('state', 'state', '');
      edcountry.Text := Ini.ReadString('country', 'country', '');
      edzipcode.Text := Ini.ReadString('zipcode', 'zipcode', '');
      edphone.Text := Ini.ReadString('phone', 'phone', '');
    finally
      Ini.Free;
    end;
    if fileexists(D_Settings_Filename) then
      DeleteFile(D_Settings_Filename);
  end;
end;

end.
