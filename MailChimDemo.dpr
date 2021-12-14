program MailChimDemo;

uses
  Vcl.Forms,
  uListResp in 'Units\uListResp.pas',
  uCreateList in 'Units\uCreateList.pas' {fmCreateList},
  uListMember in 'Units\uListMember.pas' {fmListMember},
  uCreateListJSON in 'Units\uCreateListJSON.pas',
  uListMemberJSON in 'Units\uListMemberJSON.pas',
  uCreateCampaign in 'Units\uCreateCampaign.pas' {fmCreateCamapign},
  uCampaign in 'Units\uCampaign.pas',
  uSetCampaignContent in 'Units\uSetCampaignContent.pas' {fmSetCampaignContent},
  uSettings in 'Units\uSettings.pas' {fmMailChimpAccount},
  uMain in 'Units\uMain.pas' {Form6},
  Vcl.Themes,
  Vcl.Styles,
  uCompress in 'Units\uCompress.pas',
  uExecCampaign in 'Units\uExecCampaign.pas' {fmExecCampaign};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TfmCreateList, fmCreateList);
  Application.CreateForm(TfmListMember, fmListMember);
  Application.CreateForm(TfmCreateCamapign, fmCreateCamapign);
  Application.CreateForm(TfmSetCampaignContent, fmSetCampaignContent);
  Application.CreateForm(TfmMailChimpAccount, fmMailChimpAccount);
  Application.CreateForm(TfmExecCampaign, fmExecCampaign);
  Application.Run;
end.
