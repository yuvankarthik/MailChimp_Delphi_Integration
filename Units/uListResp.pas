unit uListResp;

interface

uses Generics.Collections, Rest.Json;

type

  // create / update List

  TListStatsClass = class
  private
    FAvg_sub_rate: Extended;
    FAvg_unsub_rate: Extended;
    FCampaign_count: Extended;
    FCampaign_last_sent: String;
    FCleaned_count: Extended;
    FCleaned_count_since_send: Extended;
    FClick_rate: Extended;
    FLast_sub_date: String;
    FLast_unsub_date: String;
    FMember_count: Extended;
    FMember_count_since_send: Extended;
    FMerge_field_count: Extended;
    FOpen_rate: Extended;
    FTarget_sub_rate: Extended;
    FUnsubscribe_count: Extended;
    FUnsubscribe_count_since_send: Extended;
  public
    property avg_sub_rate: Extended read FAvg_sub_rate write FAvg_sub_rate;
    property avg_unsub_rate: Extended read FAvg_unsub_rate
      write FAvg_unsub_rate;
    property campaign_count: Extended read FCampaign_count
      write FCampaign_count;
    property campaign_last_sent: String read FCampaign_last_sent
      write FCampaign_last_sent;
    property cleaned_count: Extended read FCleaned_count write FCleaned_count;
    property cleaned_count_since_send: Extended read FCleaned_count_since_send
      write FCleaned_count_since_send;
    property click_rate: Extended read FClick_rate write FClick_rate;
    property last_sub_date: String read FLast_sub_date write FLast_sub_date;
    property last_unsub_date: String read FLast_unsub_date
      write FLast_unsub_date;
    property member_count: Extended read FMember_count write FMember_count;
    property member_count_since_send: Extended read FMember_count_since_send
      write FMember_count_since_send;
    property merge_field_count: Extended read FMerge_field_count
      write FMerge_field_count;
    property open_rate: Extended read FOpen_rate write FOpen_rate;
    property target_sub_rate: Extended read FTarget_sub_rate
      write FTarget_sub_rate;
    property unsubscribe_count: Extended read FUnsubscribe_count
      write FUnsubscribe_count;
    property unsubscribe_count_since_send: Extended
      read FUnsubscribe_count_since_send write FUnsubscribe_count_since_send;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TListStatsClass;
  end;

  TListCampaign_defaultsClass = class
  private
    FFrom_email: String;
    FFrom_name: String;
    FLanguage: String;
    FSubject: String;
  public
    property from_email: String read FFrom_email write FFrom_email;
    property from_name: String read FFrom_name write FFrom_name;
    property language: String read FLanguage write FLanguage;
    property subject: String read FSubject write FSubject;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string)
      : TListCampaign_defaultsClass;
  end;

  TListContactClass = class
  private
    FAddress1: String;
    FAddress2: String;
    FCity: String;
    FCompany: String;
    FCountry: String;
    FPhone: String;
    FState: String;
    FZip: String;
  public
    property address1: String read FAddress1 write FAddress1;
    property address2: String read FAddress2 write FAddress2;
    property city: String read FCity write FCity;
    property company: String read FCompany write FCompany;
    property country: String read FCountry write FCountry;
    property phone: String read FPhone write FPhone;
    property state: String read FState write FState;
    property zip: String read FZip write FZip;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TListContactClass;
  end;

  TListErrorsClass = class
  private
    FField: String;
    FMessage: String;
  public
    property field: String read FField write FField;
    property message: String read FMessage write FMessage;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TListErrorsClass;
  end;

  TList = class
  private
    FBeamer_address: String;
    FCampaign_defaults: TListCampaign_defaultsClass;
    FContact: TListContactClass;
    FErrors: TListErrorsClass;
    FDate_created: String;
    FEmail_type_option: Boolean;
    FId: String;
    FList_rating: Extended;
    FName: String;
    FNotify_on_subscribe: String;
    FNotify_on_unsubscribe: String;
    FPermission_reminder: String;
    FStats: TListStatsClass;
    FSubscribe_url_long: String;
    FSubscribe_url_short: String;
    FUse_archive_bar: Boolean;
    FVisibility: String;
  public
    property beamer_address: String read FBeamer_address write FBeamer_address;
    property campaign_defaults: TListCampaign_defaultsClass
      read FCampaign_defaults write FCampaign_defaults;
    property contact: TListContactClass read FContact write FContact;
    property errors: TListErrorsClass read FErrors write FErrors;
    property date_created: String read FDate_created write FDate_created;
    property email_type_option: Boolean read FEmail_type_option
      write FEmail_type_option;
    property id: String read FId write FId;
    property list_rating: Extended read FList_rating write FList_rating;
    property name: String read FName write FName;
    property notify_on_subscribe: String read FNotify_on_subscribe
      write FNotify_on_subscribe;
    property notify_on_unsubscribe: String read FNotify_on_unsubscribe
      write FNotify_on_unsubscribe;
    property permission_reminder: String read FPermission_reminder
      write FPermission_reminder;
    property stats: TListStatsClass read FStats write FStats;
    property subscribe_url_long: String read FSubscribe_url_long
      write FSubscribe_url_long;
    property subscribe_url_short: String read FSubscribe_url_short
      write FSubscribe_url_short;
    property use_archive_bar: Boolean read FUse_archive_bar
      write FUse_archive_bar;
    property visibility: String read FVisibility write FVisibility;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TList;
  end;


  // Get list

  TGetListClass = class
  private
    FLists: TArray<TList>;
    FTotal_items: Extended;
  public
    property lists: TArray<TList> read FLists write FLists;
    property total_items: Extended read FTotal_items write FTotal_items;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TGetListClass;
  end;


  // Delete list

  TDelListClass = class
  private
    FDetail: String;
    FInstance: String;
    FStatus: Extended;
    FTitle: String;
    FType: String;
  public
    property detail: String read FDetail write FDetail;
    property instance: String read FInstance write FInstance;
    property status: Extended read FStatus write FStatus;
    property title: String read FTitle write FTitle;
    property &type: String read FType write FType;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDelListClass;
  end;



  // list members update

  TErrorsClass = class
  private
    FEmail_address: String;
    FError: String;
  public
    property email_address: String read FEmail_address write FEmail_address;
    property error: String read FError write FError;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TErrorsClass;
  end;

  TMerge_fieldsClass = class
  private
    FFNAME: String;
    FLNAME: String;
    FMMERGE3: String;
    FMMERGE4: String;
  public
    property FName: String read FFNAME write FFNAME;
    property LNAME: String read FLNAME write FLNAME;
    property MMERGE3: String read FMMERGE3 write FMMERGE3;
    property MMERGE4: String read FMMERGE4 write FMMERGE4;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMerge_fieldsClass;
  end;

  TUpdated_membersClass = class
  private
    FEmail_address: String;
    FEmail_client: String;
    FEmail_type: String;
    FId: String;
    FIp_opt: String;
    FIp_signup: String;
    FLanguage: String;
    FLast_changed: String;
    FList_id: String;
    FMember_rating: Extended;
    FMerge_fields: TMerge_fieldsClass;
    FStatus: String;
    FTimestamp_opt: String;
    FTimestamp_signup: String;
    FUnique_email_id: String;
    FVip: Boolean;
  public
    property email_address: String read FEmail_address write FEmail_address;
    property email_client: String read FEmail_client write FEmail_client;
    property email_type: String read FEmail_type write FEmail_type;
    property id: String read FId write FId;
    property ip_opt: String read FIp_opt write FIp_opt;
    property ip_signup: String read FIp_signup write FIp_signup;
    property language: String read FLanguage write FLanguage;
    property last_changed: String read FLast_changed write FLast_changed;
    property list_id: String read FList_id write FList_id;
    property member_rating: Extended read FMember_rating write FMember_rating;
    property merge_fields: TMerge_fieldsClass read FMerge_fields
      write FMerge_fields;
    property status: String read FStatus write FStatus;
    property timestamp_opt: String read FTimestamp_opt write FTimestamp_opt;
    property timestamp_signup: String read FTimestamp_signup
      write FTimestamp_signup;
    property unique_email_id: String read FUnique_email_id
      write FUnique_email_id;
    property vip: Boolean read FVip write FVip;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TUpdated_membersClass;
  end;

  TNew_membersClass = class
  private
    FEmail_address: String;
    FEmail_client: String;
    FEmail_type: String;
    FId: String;
    FIp_opt: String;
    FIp_signup: String;
    FLanguage: String;
    FLast_changed: String;
    FList_id: String;
    FMember_rating: Extended;
    FMerge_fields: TMerge_fieldsClass;
    FStatus: String;
    FTimestamp_opt: String;
    FTimestamp_signup: String;
    FUnique_email_id: String;
    FVip: Boolean;
  public
    property email_address: String read FEmail_address write FEmail_address;
    property email_client: String read FEmail_client write FEmail_client;
    property email_type: String read FEmail_type write FEmail_type;
    property id: String read FId write FId;
    property ip_opt: String read FIp_opt write FIp_opt;
    property ip_signup: String read FIp_signup write FIp_signup;
    property language: String read FLanguage write FLanguage;
    property last_changed: String read FLast_changed write FLast_changed;
    property list_id: String read FList_id write FList_id;
    property member_rating: Extended read FMember_rating write FMember_rating;
    property merge_fields: TMerge_fieldsClass read FMerge_fields
      write FMerge_fields;
    property status: String read FStatus write FStatus;
    property timestamp_opt: String read FTimestamp_opt write FTimestamp_opt;
    property timestamp_signup: String read FTimestamp_signup
      write FTimestamp_signup;
    property unique_email_id: String read FUnique_email_id
      write FUnique_email_id;
    property vip: Boolean read FVip write FVip;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TNew_membersClass;
  end;

  TListMemberClass = class
  private
    FError_count: Extended;
    FErrors: TArray<TErrorsClass>;
    FNew_members: TArray<TNew_membersClass>;
    FTotal_created: Extended;
    FTotal_updated: Extended;
    FUpdated_members: TArray<TUpdated_membersClass>;
  public
    property error_count: Extended read FError_count write FError_count;
    property errors: TArray<TErrorsClass> read FErrors write FErrors;
    property new_members: TArray<TNew_membersClass> read FNew_members
      write FNew_members;
    property total_created: Extended read FTotal_created write FTotal_created;
    property total_updated: Extended read FTotal_updated write FTotal_updated;
    property updated_members: TArray<TUpdated_membersClass>
      read FUpdated_members write FUpdated_members;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TListMemberClass;
  end;

  // Get List Members

  TMembersClass = class
  private
    FEmail_address: String;
    FEmail_client: String;
    FEmail_type: String;
    FId: String;
    FIp_opt: String;
    FIp_signup: String;
    FLanguage: String;
    FLast_changed: TDateTime;
    FList_id: String;
    FMember_rating: Extended;
    FMerge_fields: TMerge_fieldsClass;
    FStatus: String;
    FStatus_if_new: String;
    FTimestamp_opt: TDateTime;
    FTimestamp_signup: TDateTime;
    FUnique_email_id: String;
    FVip: Boolean;
  public
    property email_address: String read FEmail_address write FEmail_address;
    property email_client: String read FEmail_client write FEmail_client;
    property email_type: String read FEmail_type write FEmail_type;
    property id: String read FId write FId;
    // property ip_opt: String read FIp_opt write FIp_opt;
    // property ip_signup: String read FIp_signup write FIp_signup;
    // property language: String read FLanguage write FLanguage;
    // property last_changed: TDateTime read FLast_changed write FLast_changed;
    property list_id: String read FList_id write FList_id;
    // property member_rating: Extended read FMember_rating write FMember_rating;
    property merge_fields: TMerge_fieldsClass read FMerge_fields
      write FMerge_fields;
    // property status: String read FStatus write FStatus;
    // property status_if_new: String read FStatus_if_new write FStatus_if_new;
    // property timestamp_opt: TDateTime read FTimestamp_opt write FTimestamp_opt;
    // property timestamp_signup: TDateTime read FTimestamp_signup
    // write FTimestamp_signup;
    // property unique_email_id: String read FUnique_email_id
    // write FUnique_email_id;
    // property vip: Boolean read FVip write FVip;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMembersClass;
  end;

  TGetListMemberClass = class
  private
    FList_id: String;
    FMembers: TArray<TMembersClass>;
    FTotal_items: Extended;
  public
    property list_id: String read FList_id write FList_id;
    property members: TArray<TMembersClass> read FMembers write FMembers;
    property total_items: Extended read FTotal_items write FTotal_items;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TGetListMemberClass;
  end;

implementation

{ TListStatsClass }

function TListStatsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListStatsClass.FromJsonString(AJsonString: string)
  : TListStatsClass;
begin
  result := TJson.JsonToObject<TListStatsClass>(AJsonString)
end;

{ TListCampaign_defaultsClass }

function TListCampaign_defaultsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListCampaign_defaultsClass.FromJsonString(AJsonString: string)
  : TListCampaign_defaultsClass;
begin
  result := TJson.JsonToObject<TListCampaign_defaultsClass>(AJsonString)
end;

{ TListContactClass }

function TListContactClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListContactClass.FromJsonString(AJsonString: string)
  : TListContactClass;
begin
  result := TJson.JsonToObject<TListContactClass>(AJsonString)
end;

{ TErrorsClass }

function TListErrorsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListErrorsClass.FromJsonString(AJsonString: string)
  : TListErrorsClass;
begin
  result := TJson.JsonToObject<TListErrorsClass>(AJsonString)
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

{ TMerge_fieldsClass }

function TMerge_fieldsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMerge_fieldsClass.FromJsonString(AJsonString: string)
  : TMerge_fieldsClass;
begin
  result := TJson.JsonToObject<TMerge_fieldsClass>(AJsonString)
end;

{ TUpdated_membersClass }

constructor TUpdated_membersClass.Create;
begin
  inherited;
  FMerge_fields := TMerge_fieldsClass.Create();
end;

destructor TUpdated_membersClass.Destroy;
begin
  FMerge_fields.free;
  inherited;
end;

function TUpdated_membersClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TUpdated_membersClass.FromJsonString(AJsonString: string)
  : TUpdated_membersClass;
begin
  result := TJson.JsonToObject<TUpdated_membersClass>(AJsonString)
end;

{ TNew_membersClass }

constructor TNew_membersClass.Create;
begin
  inherited;
  FMerge_fields := TMerge_fieldsClass.Create();
end;

destructor TNew_membersClass.Destroy;
begin
  FMerge_fields.free;
  inherited;
end;

function TNew_membersClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TNew_membersClass.FromJsonString(AJsonString: string)
  : TNew_membersClass;
begin
  result := TJson.JsonToObject<TNew_membersClass>(AJsonString)
end;

{ TList }

constructor TList.Create;
begin
  inherited;
  FContact := TListContactClass.Create();
  FCampaign_defaults := TListCampaign_defaultsClass.Create();
  FStats := TListStatsClass.Create();
  FErrors := TListErrorsClass.Create();
end;

destructor TList.Destroy;
begin
  FContact.free;
  FCampaign_defaults.free;
  FStats.free;
  FErrors.free;
  inherited;
end;

function TList.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TList.FromJsonString(AJsonString: string): TList;
begin
  result := TJson.JsonToObject<TList>(AJsonString)
end;

{ TGetListClass }

destructor TGetListClass.Destroy;
var
  LlistsItem: TList;
begin
  for LlistsItem in FLists do
    LlistsItem.free;
  inherited;
end;

function TGetListClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TGetListClass.FromJsonString(AJsonString: string): TGetListClass;
begin
  result := TJson.JsonToObject<TGetListClass>(AJsonString)
end;

{ TDelListClass }

function TDelListClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDelListClass.FromJsonString(AJsonString: string): TDelListClass;
begin
  result := TJson.JsonToObject<TDelListClass>(AJsonString)
end;

{ TListMemberClass }

destructor TListMemberClass.Destroy;
var
  Lnew_membersItem: TNew_membersClass;
  Lupdated_membersItem: TUpdated_membersClass;
  LerrorsItem: TErrorsClass;
begin

  for Lnew_membersItem in FNew_members do
    Lnew_membersItem.free;
  for Lupdated_membersItem in FUpdated_members do
    Lupdated_membersItem.free;
  for LerrorsItem in FErrors do
    LerrorsItem.free;

  inherited;
end;

function TListMemberClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListMemberClass.FromJsonString(AJsonString: string)
  : TListMemberClass;
begin
  result := TJson.JsonToObject<TListMemberClass>(AJsonString)
end;


// Get List Member

{ TMerge_fieldsClass }

{ TMembersClass }

constructor TMembersClass.Create;
begin
  inherited;
  FMerge_fields := TMerge_fieldsClass.Create();
end;

destructor TMembersClass.Destroy;
begin
  FMerge_fields.free;
  inherited;
end;

function TMembersClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TMembersClass.FromJsonString(AJsonString: string): TMembersClass;
begin
  result := TJson.JsonToObject<TMembersClass>(AJsonString)
end;

{ TGetListMemberClass }

destructor TGetListMemberClass.Destroy;
var
  LmembersItem: TMembersClass;
begin

  for LmembersItem in FMembers do
    LmembersItem.free;
  inherited;
end;

function TGetListMemberClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TGetListMemberClass.FromJsonString(AJsonString: string)
  : TGetListMemberClass;
begin
  result := TJson.JsonToObject<TGetListMemberClass>(AJsonString)
end;

end.
