unit uSetCampaignContent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uCampaign, Vcl.OleCtrls,
  SHDocVw;

type
  TUpdateCampaign = Procedure(CampaignId: String; Inp_JSONStr: WideString)
    of object;

  TfmSetCampaignContent = class(TForm)
    cbocampaignlist: TComboBox;
    lblcampaignlist: TLabel;
    memoHTMLContent: TMemo;
    lblmemocaption: TLabel;
    btnupdate: TButton;
    cboContentType: TComboBox;
    WebBrowser1: TWebBrowser;
    BtnPreviewHTML: TButton;
    Label1: TLabel;
    Label2: TLabel;
    memPlainText: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnupdateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cboContentTypeChange(Sender: TObject);
    procedure BtnPreviewHTMLClick(Sender: TObject);
  private
    procedure SetCampaignContentType(Content_Type: String);
    { Private declarations }
  public
    SetCampaignContent: TSetCampaignContent;
    CampaignStrList: TStringList;
    Sel_Campaign_id: String;
    Input_JSONStr: WideString;
    UpdateCampaign: TUpdateCampaign;
    { Public declarations }
  end;

var
  fmSetCampaignContent: TfmSetCampaignContent;

implementation

{$R *.dfm}

procedure TfmSetCampaignContent.BtnPreviewHTMLClick(Sender: TObject);
var
  Doc: Variant;
  HTMLCode: String;
begin
  HTMLCode := memoHTMLContent.Lines.Text;
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

procedure TfmSetCampaignContent.btnupdateClick(Sender: TObject);
begin
  if cbocampaignlist.Text = '' then
    raise Exception.Create('Campaign should not be left as empty.');
  // if cboContentType.text = '' then
  // raise Exception.Create('Content type should not be left as empty.');
  if memoHTMLContent.Text = '' then
    raise Exception.Create('Campaign content should not be left as empty.');

  Sel_Campaign_id := CampaignStrList.ValueFromIndex
    [CampaignStrList.IndexOfName(cbocampaignlist.Text)];
  // if cboContentType.Text = 'html' then
  // SetCampaignContent.html := memoHTMLContent.Lines.text
  // else
  // SetCampaignContent.plain_text :=  memoHTMLContent.Lines.text;
  SetCampaignContent.html := memoHTMLContent.Lines.Text;
  SetCampaignContent.plain_text := memPlainText.Lines.Text;
  Input_JSONStr := SetCampaignContent.ToJsonString;
  //
  SetCampaignContentType(cboContentType.Text);
  self.ModalResult := mrOK;
  self.CloseModal();
end;

Procedure TfmSetCampaignContent.SetCampaignContentType(Content_Type: String);
begin
  //
end;

procedure TfmSetCampaignContent.cboContentTypeChange(Sender: TObject);
begin
  if cboContentType.Text = 'html' then
  begin
    BtnPreviewHTML.Enabled := True;
    WebBrowser1.Enabled := True;
  end
  else
  begin
    BtnPreviewHTML.Enabled := False;
    WebBrowser1.Enabled := False;
  end;
end;

procedure TfmSetCampaignContent.FormCreate(Sender: TObject);
begin
  SetCampaignContent := TSetCampaignContent.Create;
  // CampaignStrList := TStringList.Create;
end;

procedure TfmSetCampaignContent.FormDestroy(Sender: TObject);
begin
  if Assigned(SetCampaignContent) then
    freeandnil(SetCampaignContent);
  // if assigned(CampaignStrList) then
  // freeandnil(CampaignStrList);
end;

procedure TfmSetCampaignContent.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;
end;

end.
