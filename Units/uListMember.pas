unit uListMember;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, uListMemberJSON, JSON;

type
  TfmListMember = class(TForm)
    btnSubscribe: TButton;
    pnlBottom: TPanel;
    TabControl1: TTabControl;
    pnlclient_singleupdate: TPanel;
    lblemailaddr: TLabel;
    lblfname: TLabel;
    lbllname: TLabel;
    edemailaddr: TEdit;
    edfname: TEdit;
    edlname: TEdit;
    pnlclient_multimemberupdate: TPanel;
    lblmemupdatecaption: TLabel;
    memoUpdateMembers: TMemo;
    lbltips: TLabel;
    cboListItems: TComboBox;
    lblcbolistitems: TLabel;
    lblListItems_M: TLabel;
    cboListItems_M: TComboBox;
    cbupdatemember: TCheckBox;
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSubscribeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    ListMemJSON: TListMemberJSON;
    Members: TJMembersClass;

    function GetNthString(SrcString: String; StrPos: Integer): String;
    { Private declarations }
  public

    MCStrList: TStringList;
    Input_JSONStr: WideString;
    Selected_ListID: String;
    { Public declarations }
  end;

var
  fmListMember: TfmListMember;

implementation

{$R *.dfm}

procedure TfmListMember.btnSubscribeClick(Sender: TObject);
var
  i: Integer;
  EMsg, S: String;
  JSONObj, MergeFields, JSONMainObj, RseultJson: TJSONObject;
  JSONArray: TJSONArray;
  JT: TJSONTrue;
begin
  try
    EMsg := '';
    // ListMemJSON := TListMemberJSON.Create;
    if TabControl1.TabIndex = 0 then
    begin
      if cboListItems.Text = '' then
        raise Exception.Create('Select list to add or update members.');
      if edemailaddr.Text = '' then
        raise Exception.Create('Email id shouldn''t be left as empty.');
      // if edfname.Text = '' then
      // raise Exception.Create('First name shouldn''t be left as empty.');
      // if edlname.Text = '' then
      // raise Exception.Create('Last name shouldn''t be left as empty.');
      Selected_ListID := MCStrList.ValueFromIndex
        [MCStrList.IndexOfName(cboListItems.Text)];

      //
      // JSONObj :=  TJSONObject.Create;
      // MergeFields := TJSONObject.Create;
      JSONMainObj := TJSONObject.Create;
      JSONArray := TJSONArray.Create;
      // RseultJson := TJSONObject.Create;
      //
      // JSONObj.AddPair('email_address',edemailaddr.Text);
      // JSONObj.AddPair('status','subscribed');
      //
      // MergeFields.AddPair('FNAME',edfname.Text);
      // MergeFields.AddPair('LNAME',edlname.Text);
      //
      // JSONObj.AddPair('merge_fields',MergeFields.ToString);
      //
      // JSONArray.Add(JSONObj);
      // JSONMainObj.AddPair('members',JSONArray.ToJSON);
      //
      // S := '"update_existing" : true';
      // if cbupdatemember.Checked then
      // JSONMainObj.AddPair('update_existing', JT.ToJSON)
      // else
      // JSONMainObj.AddPair('update_existing',  JT.ToJSON);

      // RseultJson.ParseJSONValue(S);
      // JSONMainObj.AddPair( JSONMainObj.ParseJSONValue(S).ToJSON;

      // ListMemJSON.members := TArray<TJMembersClass>;

      // ListMemJSON.members[0].email_address := edemailaddr.Text;
      // ListMemJSON.members[0].merge_fields.FNAME := edfname.Text;
      // ListMemJSON.members[0].merge_fields.LNAME := edlname.Text;
      // ListMemJSON.update_existing := cbupdatemember.Checked;

      // JSONMainObj.AddPair('dummy','dummy');
      Members.email_address := edemailaddr.Text;
      Members.status := 'subscribed';
      Members.merge_fields.FNAME := edfname.Text;
      Members.merge_fields.LNAME := edlname.Text;

      JSONArray.Add(JSONMainObj.ParseJSONValue(Members.ToJsonString)
        as TJSONObject);
      // JSONMainObj.AddPair('members', String(JSONArray.ToJSON));
      JSONMainObj.AddPair(TJSONPair.Create('members', JSONArray));

      // JSONMainObj := (JSONMainObj.ParseJSONValue(  StringReplace(JSONMainObj.ToString,'\"','"', [rfReplaceAll] )) as TJSONObject);

      // ListMemJSON.update_existing := cbupdatemember.Checked;

      JSONMainObj.AddPair('update_existing',
        TJSONBool.Create(cbupdatemember.Checked));

      // JSONMainObj.AddPair('update_existing',JSONMainObj.ParseJSONValue(ListMemJSON.ToJsonString).Value);

    end
    else if TabControl1.TabIndex = 1 then
    begin
      // if cboListItems_M.Text = '' then
      // raise Exception.Create('Select list to add or update members.');
      // if memoUpdateMembers.Lines.Text = '' then
      // raise Exception.Create('Email id shouldn''t be left as empty.');
      // Selected_ListID := MCStrList.ValueFromIndex
      // [MCStrList.IndexOfName(cboListItems_M.Text)];
      // for i := 0 to memoUpdateMembers.Lines.Count - 1 do
      // begin
      // ListMemJSON.members[i].email_address :=
      // GetNthString(memoUpdateMembers.Lines.Strings[i], 1);
      // ListMemJSON.members[i].merge_fields.FNAME :=
      // GetNthString(memoUpdateMembers.Lines.Strings[i], 2);
      // ListMemJSON.members[i].merge_fields.LNAME :=
      // GetNthString(memoUpdateMembers.Lines.Strings[i], 3);
      // end;
      // ListMemJSON.update_existing := cbupdatemember.Checked;
    end;
    Input_JSONStr := StringReplace(JSONMainObj.ToString, '\"', '"',
      [rfReplaceAll]); // JSONMainObj.ToString; // ListMemJSON.ToJsonString;
    Input_JSONStr := StringReplace(Input_JSONStr, 'fNAME', 'FNAME',
      [rfReplaceAll]);
    Input_JSONStr := StringReplace(Input_JSONStr, 'lNAME', 'LNAME',
      [rfReplaceAll]);
  Except
    on E: Exception do
      EMsg := E.Message;
  end;
  if Assigned(ListMemJSON) then
    FreeAndNil(ListMemJSON);
  if EMsg <> '' then
    raise Exception.Create(EMsg)
  else
  begin
    self.ModalResult := mrOK;
    self.CloseModal();
  end;
end;

// Get given position of string from CommaText
Function TfmListMember.GetNthString(SrcString: String; StrPos: Integer): String;
Var
  i, k: Integer;
Begin
  Result := '';
  i := 1;
  k := 1;
  while (k <= StrPos) and (i <= Length(SrcString)) do
  begin
    if SrcString[i] = ',' then
      Inc(k)
    else if k = StrPos then
      Result := Result + SrcString[i];
    Inc(i);
  end;
End;

procedure TfmListMember.FormCreate(Sender: TObject);
begin
  ListMemJSON := TListMemberJSON.Create;
  Members := TJMembersClass.Create;
  // MCStrList := TStringList.Create;
end;

procedure TfmListMember.FormDestroy(Sender: TObject);
begin
  if Assigned(ListMemJSON) then
    FreeAndNil(ListMemJSON);
  if Assigned(Members) then
    FreeAndNil(Members);
  // if Assigned(MCStrList) then
  // FreeAndNil(MCStrList);
end;

procedure TfmListMember.FormShow(Sender: TObject);
begin
  Left := (Screen.Width - Width) div 2;
  // Shows the Dlg Win In center of the screen
  Top := (Screen.Height - Height) div 2;
  TabControl1.TabIndex := 0;
  TabControl1Change(nil);
end;

procedure TfmListMember.TabControl1Change(Sender: TObject);
begin
  if TabControl1.TabIndex = 0 then
  begin
    pnlclient_multimemberupdate.Visible := false;
    pnlclient_multimemberupdate.SendToBack;
    pnlclient_singleupdate.Visible := true;
    pnlclient_singleupdate.BringToFront;
  end
  else if TabControl1.TabIndex = 1 then
  begin
    // pnlclient_singleupdate.Visible := false;
    // pnlclient_singleupdate.SendToBack;
    // pnlclient_multimemberupdate.Visible := true;
    // pnlclient_multimemberupdate.BringToFront;
  end

end;

end.
