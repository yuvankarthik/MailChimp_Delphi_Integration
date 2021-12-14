unit uCreateCampaign;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, uCompress,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCampaign, Inifiles;

type
  TfmCreateCamapign = class(TForm)
    lblCampaignName: TLabel;
    edCampaignName: TEdit;
    lblmailto: TLabel;
    cboMailChimpList: TComboBox;
    lblemailsubject: TLabel;
    edemailsubject: TEdit;
    lblfromname: TLabel;
    edfromname: TEdit;
    lblfromemailaddr: TLabel;
    Edfromemailaddr: TEdit;
    btnCreate: TButton;
    lblcampaignlist: TLabel;
    cbocampaignlist: TComboBox;
    procedure btnCreateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure LoadListInfo;
    { Private declarations }
  public
    CreateCampaign: TCreateCampaign;
    MCStrList, MC_CampaignList: TStringList;
    Sel_list_id, Sel_Campaign_ID, StartPath: String;
    Input_JSONStr: WideString;
    Update_Flag, isFirstTime: Boolean;

    { Public declarations }
  end;

var
  fmCreateCamapign: TfmCreateCamapign;

implementation

{$R *.dfm}

procedure TfmCreateCamapign.btnCreateClick(Sender: TObject);
begin

  if Update_Flag then
  begin
    if cbocampaignlist.text = '' then
      raise Exception.Create('Campaign should not be left as empty.');
  end;
  if edCampaignName.text = '' then
    raise Exception.Create('Campaign name should not be left as empty.');
  // if cbomailchimplist.text = '' then
  // raise Exception.Create('List should not be left as empty.');
  if edemailsubject.text = '' then
    raise Exception.Create('Email subject should not be left as empty.');
  if edfromname.text = '' then
    raise Exception.Create('From name should not be left as empty.');
  if Edfromemailaddr.text = '' then
    raise Exception.Create('From email address should not be left as empty.');
  if Update_Flag then
    Sel_Campaign_ID := MC_CampaignList.ValueFromIndex
      [MC_CampaignList.IndexOfName(cbocampaignlist.text)];
  if cboMailChimpList.text <> '' then
  begin
    Sel_list_id := MCStrList.ValueFromIndex
      [MCStrList.IndexOfName(cboMailChimpList.text)];
    CreateCampaign.recipients.list_id := Sel_list_id;
  end;
  CreateCampaign.&type := 'regular';
  CreateCampaign.settings.title := edCampaignName.text;
  CreateCampaign.settings.from_name := edfromname.text;
  CreateCampaign.settings.reply_to := Edfromemailaddr.text;
  CreateCampaign.settings.subject_line := edemailsubject.text;
  Input_JSONStr := CreateCampaign.ToJsonString;
  self.ModalResult := mrOK;
  self.CloseModal();
end;

procedure TfmCreateCamapign.FormCreate(Sender: TObject);
begin
  CreateCampaign := TCreateCampaign.Create;
  // MCStrList := TStringList.Create;
  // MC_CampaignList := TStringList.Create;
  Sel_list_id := '';
  isFirstTime := True;
end;

procedure TfmCreateCamapign.FormDestroy(Sender: TObject);
begin
  if assigned(CreateCampaign) then
    FreeAndNil(CreateCampaign);
  // if assigned(MCStrList) then
  // begin
  // MCStrList.Clear;
  // FreeAndNil(MCStrList);
  // end;
  // if assigned(MC_CampaignList) then
  // FreeAndNil(MC_CampaignList);

end;

procedure TfmCreateCamapign.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;
  if isFirstTime then
  begin
    LoadListInfo;
    isFirstTime := False;
  end;

end;

Procedure TfmCreateCamapign.LoadListInfo;
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
      edfromname.text := Ini.ReadString('fromname', 'fromname', '');
      Edfromemailaddr.text := Ini.ReadString('frommail', 'frommail', '');
    finally
      Ini.Free;
    end;
    if FileExists(D_Settings_Filename) then
      DeleteFile(D_Settings_Filename);
  end;
end;

end.
