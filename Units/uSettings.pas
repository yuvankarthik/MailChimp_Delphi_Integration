unit uSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Inifiles,
  uCompress;

type

  TDoConnection = function(HttpUrl, A_UserName, A_Password: String;
    Basic_Auth: Boolean): Boolean of object;

  TfmMailChimpAccount = class(TForm)
    GroupBox1: TGroupBox;
    lblURL: TLabel;
    lblauthuser: TLabel;
    lblauthpwd: TLabel;
    lblAPIkey: TLabel;
    edURL: TEdit;
    edauthuname: TEdit;
    edauthpwd: TEdit;
    edAPIkey: TEdit;
    btnsave: TButton;
    btnTestConnect: TButton;
    cbbasic_auth: TCheckBox;
    GroupBox2: TGroupBox;
    lblcompany: TLabel;
    edcompany: TEdit;
    lbladdr1: TLabel;
    edaddr1: TEdit;
    lbladdr2: TLabel;
    edaddr2: TEdit;
    lblcity: TLabel;
    lblstate: TLabel;
    edcity: TEdit;
    edstate: TEdit;
    lblzipcode: TLabel;
    edzipcode: TEdit;
    lblcountry: TLabel;
    edcountry: TEdit;
    lblphone: TLabel;
    edphone: TEdit;
    edfrommail: TEdit;
    lblfrommail: TLabel;
    edfromname: TEdit;
    lblfromname: TLabel;
    btnSaveListInfo: TButton;
    lblapppwd: TLabel;
    edapppassword: TEdit;
    chkshowpwd: TCheckBox;
    GroupBox3: TGroupBox;
    cboxSimpleMode: TCheckBox;
    Label1: TLabel;
    Button1: TButton;
    cbodefaultlist: TComboBox;
    procedure btnsaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnTestConnectClick(Sender: TObject);
    procedure edAPIkeyExit(Sender: TObject);
    procedure btnSaveListInfoClick(Sender: TObject);
    procedure chkshowpwdClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    C_Settings_Filename, D_Settings_Filename: String;

    procedure LoadSettings;
    procedure LoadListInfo;
    procedure Compressfile(C_fname, D_fname: String);
    procedure deCompressfile(C_fname, D_fname: String);
    procedure LoadCampaignSettings;
    procedure SaveAcnt;
    procedure SaveListInf;
    { Private declarations }
  public

    DoConnection: TDoConnection;
    StartPath, SetupWinPwd: String;
    { Public declarations }
  end;

var
  fmMailChimpAccount: TfmMailChimpAccount;

Const
  Def_URL = 'https://us15.api.mailchimp.com/3.0';

implementation

{$R *.dfm}

procedure TfmMailChimpAccount.SaveAcnt();
var
  Ini: TIniFile;
begin

  if (edURL.Text = '') or (edauthuname.Text = '') or (edauthpwd.Text = '') or
    (edAPIkey.Text = '') then
    raise Exception.Create
      ('All field values are required, so please fill all the values.');

  deCompressfile(C_Settings_Filename, D_Settings_Filename);

  Ini := TIniFile.Create(D_Settings_Filename);
  try
    Ini.WriteString('url', 'url', edURL.Text);
    Ini.WriteString('username', 'username', edauthuname.Text);
    Ini.WriteString('password', 'password', edauthpwd.Text);
    Ini.WriteString('api', 'api', edAPIkey.Text);
    Ini.WriteString('setupwinpwd', 'setupwinpwd', edapppassword.Text);
    if cbbasic_auth.Checked then
      Ini.WriteString('basicauth', 'basicauth', 'true');
    SetupWinPwd := edapppassword.Text;
    ShowMessage('Settings saved successfully.');
  finally
    Ini.Free;
  end;

  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
  self.ModalResult := mrOK;
  self.CloseModal();
end;


procedure TfmMailChimpAccount.btnsaveClick(Sender: TObject);
var
  Ini: TIniFile;
begin

  if (edURL.Text = '') or (edauthuname.Text = '') or (edauthpwd.Text = '') or
    (edAPIkey.Text = '') then
    raise Exception.Create
      ('All field values are required, so please fill all the values.');

  deCompressfile(C_Settings_Filename, D_Settings_Filename);

  Ini := TIniFile.Create(D_Settings_Filename);
  try
    Ini.WriteString('url', 'url', edURL.Text);
    Ini.WriteString('username', 'username', edauthuname.Text);
    Ini.WriteString('password', 'password', edauthpwd.Text);
    Ini.WriteString('api', 'api', edAPIkey.Text);
    Ini.WriteString('setupwinpwd', 'setupwinpwd', edapppassword.Text);
    if cbbasic_auth.Checked then
      Ini.WriteString('basicauth', 'basicauth', 'true');
    SetupWinPwd := edapppassword.Text;
    ShowMessage('Settings saved successfully.');
  finally
    Ini.Free;
  end;

  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
  self.ModalResult := mrOK;
  self.CloseModal();
end;

procedure TfmMailChimpAccount.btnTestConnectClick(Sender: TObject);
begin
  DoConnection(edURL.Text, edauthuname.Text, edauthpwd.Text,
    cbbasic_auth.Checked);
end;

procedure TfmMailChimpAccount.Button1Click(Sender: TObject);
var
  Ini: TIniFile;
begin
 SaveAcnt;
 SaveListInf;
   deCompressfile(C_Settings_Filename, D_Settings_Filename);
  Ini := TIniFile.Create(D_Settings_Filename);
  try
    Ini.WriteString('[campaignform]', 'campaignform', '');
    if cboxSimpleMode.Checked then
      Ini.WriteString('simplemode', 'simplemode', 'true')
    else
      Ini.WriteString('simplemode', 'simplemode', 'false');
    Ini.WriteString('defaultlist', 'defaultlist', cbodefaultlist.Text);
    ShowMessage('Campaign form settings saved successfully.');
  finally
    Ini.Free;
  end;
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
  self.ModalResult := mrOK;
  self.CloseModal();
end;

procedure TfmMailChimpAccount.chkshowpwdClick(Sender: TObject);
begin
  if chkshowpwd.Checked then
    edapppassword.PasswordChar := #0
  else
    edapppassword.PasswordChar := '*';
end;

procedure TfmMailChimpAccount.SaveListInf();
var
  Ini: TIniFile;
begin
  if (edfromname.Text = '') and (edfrommail.Text = '') and (edcompany.Text = '')
    and (edaddr1.Text = '') and (edaddr2.Text = '') and (edcity.Text = '') and
    (edstate.Text = '') and (edcountry.Text = '') and (edzipcode.Text = '') and
    (edphone.Text = '') then
    raise Exception.Create('Please do not left all fields value as empty.');
  deCompressfile(C_Settings_Filename, D_Settings_Filename);
  Ini := TIniFile.Create(D_Settings_Filename);
  try
    Ini.WriteString('[listinfo]', 'listinfo', '');
    Ini.WriteString('fromname', 'fromname', edfromname.Text);
    Ini.WriteString('frommail', 'frommail', edfrommail.Text);
    Ini.WriteString('company', 'company', edcompany.Text);
    Ini.WriteString('address1', 'address1', edaddr1.Text);
    Ini.WriteString('address2', 'address2', edaddr2.Text);
    Ini.WriteString('city', 'city', edcity.Text);
    Ini.WriteString('state', 'state', edstate.Text);
    Ini.WriteString('country', 'country', edcountry.Text);
    Ini.WriteString('zipcode', 'zipcode', edzipcode.Text);
    Ini.WriteString('phone', 'phone', edphone.Text);
    ShowMessage('List default informations saved successfully.');
  finally
    Ini.Free;
  end;
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
  fmMailChimpAccount.ModalResult := mrOK;
  fmMailChimpAccount.CloseModal();
end;

procedure TfmMailChimpAccount.btnSaveListInfoClick(Sender: TObject);
var
  Ini: TIniFile;
begin
  if (edfromname.Text = '') and (edfrommail.Text = '') and (edcompany.Text = '')
    and (edaddr1.Text = '') and (edaddr2.Text = '') and (edcity.Text = '') and
    (edstate.Text = '') and (edcountry.Text = '') and (edzipcode.Text = '') and
    (edphone.Text = '') then
    raise Exception.Create('Please do not left all fields value as empty.');
  deCompressfile(C_Settings_Filename, D_Settings_Filename);
  Ini := TIniFile.Create(D_Settings_Filename);
  try
    Ini.WriteString('[listinfo]', 'listinfo', '');
    Ini.WriteString('fromname', 'fromname', edfromname.Text);
    Ini.WriteString('frommail', 'frommail', edfrommail.Text);
    Ini.WriteString('company', 'company', edcompany.Text);
    Ini.WriteString('address1', 'address1', edaddr1.Text);
    Ini.WriteString('address2', 'address2', edaddr2.Text);
    Ini.WriteString('city', 'city', edcity.Text);
    Ini.WriteString('state', 'state', edstate.Text);
    Ini.WriteString('country', 'country', edcountry.Text);
    Ini.WriteString('zipcode', 'zipcode', edzipcode.Text);
    Ini.WriteString('phone', 'phone', edphone.Text);
    ShowMessage('List default informations saved successfully.');
  finally
    Ini.Free;
  end;
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
  self.ModalResult := mrOK;
  self.CloseModal();
end;


Procedure TfmMailChimpAccount.LoadListInfo;
var
  Ini: TIniFile;
begin
  deCompressfile(C_Settings_Filename, D_Settings_Filename);
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
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
end;

procedure TfmMailChimpAccount.edAPIkeyExit(Sender: TObject);
begin
  edauthpwd.Text := edAPIkey.Text;
end;

procedure TfmMailChimpAccount.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;
  C_Settings_Filename :=
    ChangeFileExt(StartPath + ExtractFilename(Application.ExeName), '.INI');
  D_Settings_Filename := ChangeFileExt(C_Settings_Filename, '.cmp');
  if FileExists(C_Settings_Filename) then
  begin
    LoadSettings;
    LoadListInfo;
    LoadCampaignSettings;
  end
  else
    edURL.Text := Def_URL;
end;

Procedure TfmMailChimpAccount.LoadCampaignSettings;
var
  Ini: TIniFile;
begin
  deCompressfile(C_Settings_Filename, D_Settings_Filename);
  Ini := TIniFile.Create(D_Settings_Filename);
  try
    cbodefaultlist.Text := Ini.ReadString('defaultlist', 'defaultlist', '');
    cboxSimpleMode.Checked :=
      ('true' = lowercase(Ini.ReadString('simplemode', 'simplemode', '')));
  finally
    Ini.Free;
  end;
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
end;


Procedure TfmMailChimpAccount.LoadSettings;
var
  Ini: TIniFile;
begin
  deCompressfile(C_Settings_Filename, D_Settings_Filename);
  Ini := TIniFile.Create(D_Settings_Filename);
  try
    edURL.Text := Ini.ReadString('url', 'url', '');
    edauthuname.Text := Ini.ReadString('username', 'username', '');
    edauthpwd.Text := Ini.ReadString('password', 'password', '');
    edAPIkey.Text := Ini.ReadString('api', 'api', '');
    edapppassword.Text := Ini.ReadString('setupwinpwd', 'setupwinpwd', '');
    cbbasic_auth.Checked :=
      ('true' = lowercase(Ini.ReadString('basicauth', 'basicauth', '')));
    SetupWinPwd := edapppassword.Text;
  finally
    Ini.Free;
  end;
  Compressfile(D_Settings_Filename, C_Settings_Filename);
  if FileExists(D_Settings_Filename) then
    DeleteFile(D_Settings_Filename);
end;

Procedure TfmMailChimpAccount.Compressfile(C_fname, D_fname: String);
begin
  if Not FileExists(C_fname) then
    exit;
  with TCompress.Create do
  begin
    Compressfile(C_fname, D_fname);
    destroy;
  end;
end;

Procedure TfmMailChimpAccount.deCompressfile(C_fname, D_fname: String);
begin
  if Not FileExists(C_fname) then
    exit;
  with TCompress.Create do
  begin
    deCompressfile(C_fname, D_fname);
    destroy;
  end;
end;

end.
