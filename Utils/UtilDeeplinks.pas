﻿unit UtilDeeplinks;

interface

procedure RegisterDeeplink(const ProtocolName, AppName, ExecutablePath: string);
function ExtractAfterProtocol(const URI, Protocol: string): string;

implementation

uses Windows, Registry, SysUtils, StrUtils;

procedure RegisterDeeplink(const ProtocolName, AppName, ExecutablePath: string);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;

    // Create main protocol key
    if Reg.OpenKey('\Software\Classes\' + ProtocolName, True) then
    begin
      Reg.WriteString('', 'URL:' + ProtocolName);
      Reg.WriteString('URL Protocol', '');
      Reg.CloseKey;
    end;

    // Create shell key
    if Reg.OpenKey('\Software\Classes\' + ProtocolName + '\shell', True) then
    begin
      Reg.CloseKey;
    end;

    // Create shell\open key
    if Reg.OpenKey('\Software\Classes\' + ProtocolName + '\shell\open', True) then
    begin
      Reg.CloseKey;
    end;

    // Create shell\open\command key with executable path
    if Reg.OpenKey('\Software\Classes\' + ProtocolName + '\shell\open\command', True) then
    begin
      // '%1' represents anything after the uri
      // E.G. 'myapp://open-me' where '%1' is 'open-me'
      Reg.WriteString('', '"' + ExecutablePath + '" "%1"');
      Reg.CloseKey;
    end;

  finally
    Reg.Free;
  end;
end;

function ExtractAfterProtocol(const URI, Protocol: string): string;
var
  Delim: string;
  p: Integer;
begin
  // build the delimiter, e.g. 'myapp://'
  Delim := Protocol + '://';
  // look for it (case‐sensitive by default)
  p := Pos(Delim, URI);
  if p > 0 then
    // copy from the character just after the delimiter
    Result := Copy(URI, p + Length(Delim), MaxInt)
  else
    Result := ''; // not found or malformed
end;


end.
