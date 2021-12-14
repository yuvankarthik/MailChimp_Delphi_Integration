unit uCampaign;

interface

uses Generics.Collections, Rest.Json;

type

  // Create campaign

  TSettingsClass = class
  private
    FTitle: String;
    FFrom_name: String;
    FReply_to: String;
    FSubject_line: String;
  public
    property title: String read FTitle write FTitle;
    property from_name: String read FFrom_name write FFrom_name;
    property reply_to: String read FReply_to write FReply_to;
    property subject_line: String read FSubject_line write FSubject_line;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSettingsClass;
  end;

  TRecipientsClass = class
  private
    FList_id: String;
  public
    property list_id: String read FList_id write FList_id;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRecipientsClass;
  end;

  TCreateCampaign = class
  private
    FRecipients: TRecipientsClass;
    FSettings: TSettingsClass;
    FType: String;
  public
    property recipients: TRecipientsClass read FRecipients write FRecipients;
    property settings: TSettingsClass read FSettings write FSettings;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TCreateCampaign;
  end;


  // Result of create campaign

  TDelivery_statusClass = class
  private
    FEnabled: Boolean;
  public
    property enabled: Boolean read FEnabled write FEnabled;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDelivery_statusClass;
  end;

  TTrackingClass = class
  private
    FClicktale: String;
    FEcomm360: Boolean;
    FGoal_tracking: Boolean;
    FGoogle_analytics: String;
    FHtml_clicks: Boolean;
    FOpens: Boolean;
    FText_clicks: Boolean;
  public
    property clicktale: String read FClicktale write FClicktale;
    property ecomm360: Boolean read FEcomm360 write FEcomm360;
    property goal_tracking: Boolean read FGoal_tracking write FGoal_tracking;
    property google_analytics: String read FGoogle_analytics
      write FGoogle_analytics;
    property html_clicks: Boolean read FHtml_clicks write FHtml_clicks;
    property opens: Boolean read FOpens write FOpens;
    property text_clicks: Boolean read FText_clicks write FText_clicks;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TTrackingClass;
  end;

  TRespSettingsClass = class
  private
    FAuthenticate: Boolean;
    FAuto_footer: Boolean;
    FAuto_tweet: Boolean;
    FDrag_and_drop: Boolean;
    FFb_comments: Boolean;
    FFolder_id: String;
    FFrom_name: String;
    FInline_css: Boolean;
    FReply_to: String;
    FSubject_line: String;
    FTemplate_id: Extended;
    FTimewarp: Boolean;
    FTitle: String;
    FTo_name: String;
    FUse_conversation: Boolean;
  public
    property authenticate: Boolean read FAuthenticate write FAuthenticate;
    property auto_footer: Boolean read FAuto_footer write FAuto_footer;
    property auto_tweet: Boolean read FAuto_tweet write FAuto_tweet;
    property drag_and_drop: Boolean read FDrag_and_drop write FDrag_and_drop;
    property fb_comments: Boolean read FFb_comments write FFb_comments;
    property folder_id: String read FFolder_id write FFolder_id;
    property from_name: String read FFrom_name write FFrom_name;
    property inline_css: Boolean read FInline_css write FInline_css;
    property reply_to: String read FReply_to write FReply_to;
    property subject_line: String read FSubject_line write FSubject_line;
    property template_id: Extended read FTemplate_id write FTemplate_id;
    property timewarp: Boolean read FTimewarp write FTimewarp;
    property title: String read FTitle write FTitle;
    property to_name: String read FTo_name write FTo_name;
    property use_conversation: Boolean read FUse_conversation
      write FUse_conversation;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespSettingsClass;
  end;

  TRespRecipientsClass = class
  private
    FList_id: String;
    FSegment_text: String;
  public
    property list_id: String read FList_id write FList_id;
    property segment_text: String read FSegment_text write FSegment_text;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespRecipientsClass;
  end;

  TErrorsClass = class
  private
    FField: String;
    FMessage: String;
  public
    property field: String read FField write FField;
    property message: String read FMessage write FMessage;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TErrorsClass;
  end;

  TRespCreateCampaign = class
  private
    FArchive_url: String;
    FContent_type: String;
    FCreate_time: String;
    FDelivery_status: TDelivery_statusClass;
    FErrors: TErrorsClass;
    FEmails_sent: Extended;
    FId: String;
    FRecipients: TRespRecipientsClass;
    FSend_time: String;
    FSettings: TRespSettingsClass;
    FStatus: String;
    FTracking: TTrackingClass;
    FType: String;
  public
    property errors: TErrorsClass read FErrors write FErrors;
    property archive_url: String read FArchive_url write FArchive_url;
    property content_type: String read FContent_type write FContent_type;
    property create_time: String read FCreate_time write FCreate_time;
    property delivery_status: TDelivery_statusClass read FDelivery_status
      write FDelivery_status;
    property emails_sent: Extended read FEmails_sent write FEmails_sent;
    property id: String read FId write FId;
    property recipients: TRespRecipientsClass read FRecipients
      write FRecipients;
    property send_time: String read FSend_time write FSend_time;
    property settings: TRespSettingsClass read FSettings write FSettings;
    property status: String read FStatus write FStatus;
    property tracking: TTrackingClass read FTracking write FTracking;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespCreateCampaign;
  end;

  TGetCampaign = class
  private
    FCampaigns: TArray<TRespCreateCampaign>;
    FTotal_items: Extended;
  public

    property campaigns: TArray<TRespCreateCampaign> read FCampaigns
      write FCampaigns;
    property total_items: Extended read FTotal_items write FTotal_items;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TGetCampaign;
  end;

  TSetCampaignContent = class
  private
    FHtml: String;
    FPlain_text: String;
  public
    property html: String read FHtml write FHtml;
    property plain_text: String read FPlain_text write FPlain_text;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSetCampaignContent;
  end;

  TRespSetCampaignContent = class
  private
    FHtml: String;
    FPlain_text: String;
    FErrors: TErrorsClass;
  public
    property errors: TErrorsClass read FErrors write FErrors;
    property html: String read FHtml write FHtml;
    property plain_text: String read FPlain_text write FPlain_text;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRespSetCampaignContent;
  end;

implementation

{ TSettingsClass }

function TSettingsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSettingsClass.FromJsonString(AJsonString: string)
  : TSettingsClass;
begin
  result := TJson.JsonToObject<TSettingsClass>(AJsonString)
end;

{ TRecipientsClass }

function TRecipientsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRecipientsClass.FromJsonString(AJsonString: string)
  : TRecipientsClass;
begin
  result := TJson.JsonToObject<TRecipientsClass>(AJsonString)
end;

{ TCreateCampaign }

constructor TCreateCampaign.Create;
begin
  inherited;
  FRecipients := TRecipientsClass.Create();
  FSettings := TSettingsClass.Create();
end;

destructor TCreateCampaign.Destroy;
begin
  FRecipients.free;
  FSettings.free;
  inherited;
end;

function TCreateCampaign.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TCreateCampaign.FromJsonString(AJsonString: string)
  : TCreateCampaign;
begin
  result := TJson.JsonToObject<TCreateCampaign>(AJsonString)
end;

{ TDelivery_statusClass }

function TDelivery_statusClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDelivery_statusClass.FromJsonString(AJsonString: string)
  : TDelivery_statusClass;
begin
  result := TJson.JsonToObject<TDelivery_statusClass>(AJsonString)
end;

{ TTrackingClass }

function TTrackingClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTrackingClass.FromJsonString(AJsonString: string)
  : TTrackingClass;
begin
  result := TJson.JsonToObject<TTrackingClass>(AJsonString)
end;

{ TSettingsClass }

function TRespSettingsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespSettingsClass.FromJsonString(AJsonString: string)
  : TRespSettingsClass;
begin
  result := TJson.JsonToObject<TRespSettingsClass>(AJsonString)
end;

{ TRecipientsClass }

function TRespRecipientsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespRecipientsClass.FromJsonString(AJsonString: string)
  : TRespRecipientsClass;
begin
  result := TJson.JsonToObject<TRespRecipientsClass>(AJsonString)
end;

{ TErrorsClass }

function TErrorsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TErrorsClass.FromJsonString(AJsonString: string): TErrorsClass;
begin
  result := TJson.JsonToObject<TErrorsClass>(AJsonString)
end;

{ TRootClass }

constructor TRespCreateCampaign.Create;
begin
  inherited;
  FRecipients := TRespRecipientsClass.Create();
  FSettings := TRespSettingsClass.Create();
  FTracking := TTrackingClass.Create();
  FDelivery_status := TDelivery_statusClass.Create();
end;

destructor TRespCreateCampaign.Destroy;
begin
  FRecipients.free;
  FSettings.free;
  FTracking.free;
  FDelivery_status.free;
  inherited;
end;

function TRespCreateCampaign.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespCreateCampaign.FromJsonString(AJsonString: string)
  : TRespCreateCampaign;
begin
  result := TJson.JsonToObject<TRespCreateCampaign>(AJsonString)
end;

{ TGetCampaign }

destructor TGetCampaign.Destroy;
var
  LcampaignsItem: TRespCreateCampaign;
begin

  for LcampaignsItem in FCampaigns do
    LcampaignsItem.free;

  inherited;
end;

function TGetCampaign.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TGetCampaign.FromJsonString(AJsonString: string): TGetCampaign;
begin
  result := TJson.JsonToObject<TGetCampaign>(AJsonString)
end;

{ TCampaignSetContent }

function TSetCampaignContent.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSetCampaignContent.FromJsonString(AJsonString: string)
  : TSetCampaignContent;
begin
  result := TJson.JsonToObject<TSetCampaignContent>(AJsonString)
end;

{ TRootClass }

function TRespSetCampaignContent.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRespSetCampaignContent.FromJsonString(AJsonString: string)
  : TRespSetCampaignContent;
begin
  result := TJson.JsonToObject<TRespSetCampaignContent>(AJsonString)
end;

end.
