unit uListMemberJSON;

interface

uses Generics.Collections, Rest.Json;

type

  TMerge_fieldsClass = class
  private
    FFNAME: String;
    FLNAME: String;
  public
    property FNAME: String read FFNAME write FFNAME;
    property LNAME: String read FLNAME write FLNAME;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMerge_fieldsClass;
  end;

  TJMembersClass = class
  private
    FEmail_address: String;
    FStatus: String;
    FMerge_fields: TMerge_fieldsClass;
  public
    constructor Create;
    destructor Destroy; override;
    property merge_fields: TMerge_fieldsClass read FMerge_fields
      write FMerge_fields;
    property email_address: String read FEmail_address write FEmail_address;
    property status: String read FStatus write FStatus;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TJMembersClass;
  end;

  TListMemberJSON = class
  private
    // FMembers: TArray<TMembersClass>;
    // FMembers: TMembersClass;
    FUpdate_existing: Boolean;
  public
    // property members: TArray<TMembersClass> read FMembers write FMembers;
    constructor Create;
    // property members: TMembersClass read FMembers write FMembers;
    property update_existing: Boolean read FUpdate_existing
      write FUpdate_existing;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TListMemberJSON;
  end;

implementation

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

{ TMembersClass }

constructor TJMembersClass.Create;
begin
  inherited;
  FMerge_fields := TMerge_fieldsClass.Create();
end;

destructor TJMembersClass.Destroy;
begin
  FMerge_fields.free;
  inherited;
end;

function TJMembersClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TJMembersClass.FromJsonString(AJsonString: string)
  : TJMembersClass;
begin
  result := TJson.JsonToObject<TJMembersClass>(AJsonString)
end;

{ TListMemberJSON }

constructor TListMemberJSON.Create;
begin
  // Fmembers :=  TArray<TMembersClass>.Create();
  // SetLength(Fmembers, Length(Fmembers)+100);
end;

destructor TListMemberJSON.Destroy;
begin
  // var
  // LmembersItem: TMembersClass;
  // begin
  // for LmembersItem in FMembers do
  // LmembersItem.free;
  // inherited;
end;

function TListMemberJSON.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TListMemberJSON.FromJsonString(AJsonString: string)
  : TListMemberJSON;
begin
  result := TJson.JsonToObject<TListMemberJSON>(AJsonString)
end;

end.
