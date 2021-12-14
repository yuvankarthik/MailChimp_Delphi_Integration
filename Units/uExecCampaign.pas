unit uExecCampaign;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.OleCtrls, SHDocVw,uCampaign, Vcl.ExtCtrls;



type

  TCreateNewCampaign = Procedure(Sender: TObject) of object;
  TExecuteCampaign = Procedure(Sel_List , Sel_Campaign : String) of object;
  TSetcampaigncontent_Proc = procedure (Campaign_ID: String; InputJSONStr: WideString) of object;

  TfmExecCampaign = class(TForm)
    Label1: TLabel;
    lblCampaignName: TLabel;
    edCampaignName: TEdit;
    lblemailsubject: TLabel;
    edemailsubject: TEdit;
    edfromname: TEdit;
    lblfromname: TLabel;
    Label2: TLabel;
    WebBrowser1: TWebBrowser;
    FileOpenDialog1: TFileOpenDialog;
    edhtmlfile: TEdit;
    btnselecthtml: TButton;
    cbomailchimplist: TComboBox;
    btnExecute: TButton;
    lblfromemailaddr: TLabel;
    Edfromemailaddr: TEdit;
    pnl1: TPanel;
    pnlEdvan: TPanel;
    pnlHtml: TPanel;
    btn1: TButton;
    grp1: TGroupBox;
    procedure BtnPreviewHTMLClick(Sender: TObject);
    procedure btnselecthtmlClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);

  private
    procedure CreateCampaign;
    procedure SetContentToCampaign;
    procedure previewHtml;
    { Private declarations }
  public
    CreateCampaign_ : TCreateCampaign;
    CreateNewCampaign : TCreateNewCampaign;
    ExecuteCampaign : TExecuteCampaign;
    MCStrList : TStringList;
    Sel_list_id, StartPath: String;
    Input_JSONStr: WideString;
    DefaultFromName , DefaultFromEmail : String;
    SetCampaignContent: TSetCampaignContent;
    Setcampaigncontent_Proc : TSetcampaigncontent_Proc;
    CampaignStrList: TStringList;

    //Update_Flag, isFirstTime: Boolean;
    { Public declarations }
  end;

var
  fmExecCampaign: TfmExecCampaign;

implementation

{$R *.dfm}

procedure TfmExecCampaign.btn1Click(Sender: TObject);
begin
pnlEdvan.Visible := not pnlEdvan.Visible;
end;

procedure TfmExecCampaign.btnExecuteClick(Sender: TObject);
begin
  CreateCampaign;
  SetContentToCampaign;
  ExecuteCampaign(cbomailchimplist.Text,edCampaignName.text);
end;


procedure TfmExecCampaign.CreateCampaign;
begin
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

  if cboMailChimpList.text <> '' then
  begin
    Sel_list_id := MCStrList.ValueFromIndex
      [MCStrList.IndexOfName(cboMailChimpList.text)];
    CreateCampaign_.recipients.list_id := Sel_list_id;
  end;
  CreateCampaign_.&type := 'regular';
  CreateCampaign_.settings.title := edCampaignName.text;
  CreateCampaign_.settings.from_name := edfromname.text;
  CreateCampaign_.settings.reply_to := Edfromemailaddr.text;
  CreateCampaign_.settings.subject_line := edemailsubject.text;
  Input_JSONStr := CreateCampaign_.ToJsonString;
  CreateNewCampaign(nil);
end;

procedure TfmExecCampaign.FormDestroy(Sender: TObject);
begin
  if assigned(CreateCampaign_) then
    FreeAndNil(CreateCampaign_);
  if assigned(SetCampaignContent) then
    FreeAndNil(SetCampaignContent);
end;

procedure TfmExecCampaign.FormShow(Sender: TObject);
begin
  CreateCampaign_ := TCreateCampaign.Create;
  SetCampaignContent := TSetCampaignContent.Create;
end;

procedure TfmExecCampaign.BtnPreviewHTMLClick(Sender: TObject);
begin
  previewHtml()
end;


procedure TfmExecCampaign.btnselecthtmlClick(Sender: TObject);
var
  fname : String;
  Sep_Pos : Integer;
begin
  if FileOpenDialog1.Execute then
  begin
    fname := FileOpenDialog1.FileName;
    edhtmlfile.Text := fname;
    fname := ExtractFileName(fname);
    Sep_Pos := LastDelimiter('.',fname);
    Delete(fname,Sep_Pos,length(fname));

    edCampaignName.Text := fname;
    edemailsubject.Text := fname;
    if edfromname.Text = '' then edfromname.Text := fname;
    previewHtml ;

  end;
end;


procedure TfmExecCampaign.SetContentToCampaign;
var
  HtmlContent,Sel_Campaign_id : String;
begin
  if edCampaignName.Text = '' then
    raise Exception.Create('Campaign should not be left as empty.');
  // if cboContentType.text = '' then
  // raise Exception.Create('Content type should not be left as empty.');
  with TStringList.Create do
  begin
     LoadFromFile(edhtmlfile.Text);
     HtmlContent := Text;
     Free;
  end;
  if  HtmlContent = '' then
    raise Exception.Create('Campaign content should not be left as empty.');

  Sel_Campaign_id := CampaignStrList.ValueFromIndex
    [CampaignStrList.IndexOfName(edCampaignName.Text)];
  // if cboContentType.Text = 'html' then
  // SetCampaignContent.html := memoHTMLContent.Lines.text
  // else
  // SetCampaignContent.plain_text :=  memoHTMLContent.Lines.text;
  SetCampaignContent.html := HtmlContent;
  SetCampaignContent.plain_text := '';
  Input_JSONStr := SetCampaignContent.ToJsonString;
  Setcampaigncontent_Proc(Sel_Campaign_id,Input_JSONStr);
  //
  //SetCampaignContentType(cboContentType.Text);

end;

procedure TfmExecCampaign.previewHtml() ;
var
  Doc: Variant;
  HTMLCode , Fname : String;
begin
  Fname := edhtmlfile.Text;
  if Trim(Fname) = '' then Exit;
  With TStringList.Create do
  begin
    LoadFromFile(Fname);
    HTMLCode := Text;
    Clear;
    Free;
  end;
  if HTMLCode = '' then
  begin
    WebBrowser1.Navigate('about:blank');
    exit;
  end;
  if NOT Assigned(WebBrowser1.Document) then
    WebBrowser1.Navigate('about:blank');

  Doc := WebBrowser1.Document;
  Doc.Clear;
  Doc.Write(HTMLCode);
  Doc.Close;

end;

end.
