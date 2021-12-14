unit uCreateListJSON;

interface

uses Generics.Collections, Rest.Json;

type

  TContactClass = class
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
    class function FromJsonString(AJsonString: string): TContactClass;
  end;

  TCampaign_defaultsClass = class
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
    class function FromJsonString(AJsonString: string): TCampaign_defaultsClass;
  end;

  TCreateListJSON = class
  private
    FCampaign_defaults: TCampaign_defaultsClass;
    FContact: TContactClass;
    FEmail_type_option: Boolean;
    FName: String;
    FNotify_on_subscribe: String;
    FNotify_on_unsubscribe: String;
    FPermission_reminder: String;
  public
    property campaign_defaults: TCampaign_defaultsClass read FCampaign_defaults
      write FCampaign_defaults;
    property contact: TContactClass read FContact write FContact;
    property email_type_option: Boolean read FEmail_type_option
      write FEmail_type_option;
    property name: String read FName write FName;
    property notify_on_subscribe: String read FNotify_on_subscribe
      write FNotify_on_subscribe;
    property notify_on_unsubscribe: String read FNotify_on_unsubscribe
      write FNotify_on_unsubscribe;
    property permission_reminder: String read FPermission_reminder
      write FPermission_reminder;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TCreateListJSON;
  end;

implementation

{ TContactClass }

function TContactClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TContactClass.FromJsonString(AJsonString: string): TContactClass;
begin
  result := TJson.JsonToObject<TContactClass>(AJsonString)
end;

{ TCampaign_defaultsClass }

function TCampaign_defaultsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TCampaign_defaultsClass.FromJsonString(AJsonString: string)
  : TCampaign_defaultsClass;
begin
  result := TJson.JsonToObject<TCampaign_defaultsClass>(AJsonString)
end;

{ TCreateListJSON }

constructor TCreateListJSON.Create;
begin
  inherited;
  FCampaign_defaults := TCampaign_defaultsClass.Create();
  FContact := TContactClass.Create();
end;

destructor TCreateListJSON.Destroy;
begin
  FCampaign_defaults.free;
  FContact.free;
  inherited;
end;

function TCreateListJSON.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TCreateListJSON.FromJsonString(AJsonString: string)
  : TCreateListJSON;
begin
  result := TJson.JsonToObject<TCreateListJSON>(AJsonString)
end;

end.
