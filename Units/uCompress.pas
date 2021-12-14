unit uCompress;

{ copied from ver 9.6/Fix1 }
interface

uses System.ZLib, Classes, SysUtils;

type
  TCompress = class
  private

  public
    procedure CompressFile(Const inFile, OutFile: String);
    procedure DecompressFile(const inFile, OutFile: String);
    function CompressStream(const inFile: TMemoryStream): TMemoryStream;
    function DecompressStream(const inFile: TStringStream;
      utfdecode: boolean = true): TStringStream;
    function DecompressLicStringStream(const inFile: TStringStream)
      : TStringStream;
  end;

implementation

procedure TCompress.CompressFile(const inFile, OutFile: String);
var
  zStream: TZCompressionStream;
  inStream: TFileStream;
  outStream: TFileStream;
  size: Cardinal;
  f: textfile;
begin
  // open the in file and get the size
  try
    if fileexists(inFile) then
    begin
      assignfile(f, OutFile);
      if not fileexists(OutFile) then
        rewrite(f)
      else
        append(f);
      closefile(f);
      inStream := TFileStream.Create(inFile, fmOpenRead);
      size := inStream.size;

      // create the out file and save the original (decompressed)
      // file size to make decompression easier

      outStream := TFileStream.Create(OutFile, fmCreate);
      outStream.Write(size, SizeOf(Cardinal));

      // compress

      zStream := TZCompressionStream.Create(outStream);
      zStream.CopyFrom(inStream, 0);

    end;
  except
  end;
  // clean up
  FreeAndNil(zStream);
  FreeAndNil(outStream);
  FreeAndNil(inStream);
end;

function TCompress.CompressStream(const inFile: TMemoryStream): TMemoryStream;
var
  zStream: TZCompressionStream;
  size: Cardinal;
begin
  size := inFile.size;
  result := TMemoryStream.Create;
  result.Write(size, SizeOf(Cardinal));
  zStream := TZCompressionStream.Create(result);
  zStream.CopyFrom(inFile, 0);
  zStream.Free;
end;

function TCompress.DecompressStream(const inFile: TStringStream;
  utfdecode: boolean = true): TStringStream;
var
  zStream: TZDecompressionStream;
  size: Cardinal;
begin
  inFile.Read(size, SizeOf(Cardinal));
  if utfdecode then
    result := TStringStream.Create('', TEncoding.UTF8)
  else
    result := TStringStream.Create('');
  zStream := TZDecompressionStream.Create(inFile);
  result.CopyFrom(zStream, size);
  zStream.Free;
end;

function TCompress.DecompressLicStringStream(const inFile: TStringStream)
  : TStringStream;
var
  zStream: TZDecompressionStream;
  size: Cardinal;
begin
  inFile.Read(size, SizeOf(Cardinal));
  result := TStringStream.Create('', TEncoding.GetEncoding(1252));
  zStream := TZDecompressionStream.Create(inFile);
  result.CopyFrom(zStream, size);
  zStream.Free;
end;

procedure TCompress.DecompressFile(const inFile, OutFile: String);
var
  zStream: TZDecompressionStream;
  inStream: TFileStream;
  outStream: TFileStream;
  size: Cardinal;
  f: textfile;
begin
  // open the in file and get the original (decompressed)
  // file size
  try
    assignfile(f, OutFile);
    if not fileexists(OutFile) then
      rewrite(f)
    else
      append(f);
    closefile(f);
    inStream := TFileStream.Create(inFile, fmOpenRead);
    inStream.Read(size, SizeOf(Cardinal));

    // create the out file

    outStream := TFileStream.Create(OutFile, fmCreate);

    // decompress

    zStream := TZDecompressionStream.Create(inStream);
    outStream.CopyFrom(zStream, size);
  except
  end;
  // clean up
  FreeAndNil(zStream);
  FreeAndNil(outStream);
  FreeAndNil(inStream);
end;

end.
