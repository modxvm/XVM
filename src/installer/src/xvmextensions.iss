#ifndef XVMEXTENSION_DIR
#define XVMEXTENSION_DIR SourcePath
#endif

[Files]
Source: "{#XVMEXTENSION_DIR}\xvmextensions.x86_32.dll"; DestName: xvmextensions.dll; Flags: dontcopy;


[Code]

//BWXML
//zero on success, negative value on error
function BWXML_UnpackW(PathPacked: String; PathUnpacked: String): Integer;
external 'BWXML_UnpackW@files:xvmextensions.dll cdecl';


//JSON
function JSON_ContainsKeyW(JSON: String; Path: String): Boolean;
external 'JSON_ContainsKeyW@files:xvmextensions.dll cdecl';

procedure JSON_GetValueW(JSON: String; Path: String; Buffer: String; BufferSize: Integer);
external 'JSON_GetValueW@files:xvmextensions.dll cdecl';

procedure JSON_SetValueBoolW(FileFullName: String; ValuePath: String; Value: Boolean);
external 'JSON_SetValueBoolW@files:xvmextensions.dll cdecl';

//value isAdd - True add value to the array, False replace the whole array
procedure JSON_SetValueObjW(FileFullName: String; Value: String; isAdd: Boolean);
external 'JSON_SetValueObjW@files:xvmextensions.dll cdecl';

procedure JSON_GetNamesAndValuesW(FileFullName: String; Path: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW@files:xvmextensions.dll cdecl';

procedure JSON_GetNamesAndValuesW_S(StrJSON: String; BufNames: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetNamesAndValuesW_S@files:xvmextensions.dll cdecl';

procedure JSON_GetArrayValueW_S(StrJSON: String; BufValues: String; BufferSize: Integer);
external 'JSON_GetArrayValueW_S@files:xvmextensions.dll cdecl';

procedure IMAGEDRAW_PngToBmp(FileName: String);
external 'IMAGEDRAW_PngToBmp@files:xvmextensions.dll cdecl';


//PROCESS
function PROCESS_GetRunningInDirectoryW(DirectoryPth: String; Buffer: String; BufferSize: Integer): Boolean;
external 'PROCESS_GetRunningInDirectoryW@files:xvmextensions.dll cdecl';

function PROCESS_TerminateProcess(ProcessName: String): Boolean;
external 'PROCESS_TerminateProcess@files:xvmextensions.dll cdecl';


//SPLASHSCREEN
function SPLASHSCREEN_ShowSplashScreenW(FileName: String; SecondsToShow: Integer): Boolean;
external 'SPLASHSCREEN_ShowSplashScreenW@files:xvmextensions.dll cdecl';

//Wine
function WINE_IsRunningUnder(): Boolean;
external 'WINE_IsRunningUnder@files:xvmextensions.dll cdecl';


//WoT
function WOT_AddClientW(ClientPath: String): Integer;
external 'WOT_AddClientW@files:xvmextensions.dll cdecl';

procedure WOT_GetPreferredClientPathW(Buffer: String; BufferSize: Integer);
external 'WOT_GetPreferredClientPathW@files:xvmextensions.dll cdecl';

function WOT_GetClientsCount(): Integer;
external 'WOT_GetClientsCount@files:xvmextensions.dll cdecl';

function WOT_GetClientBranch(ClientIndex: Integer): Integer;
external 'WOT_GetClientBranch@files:xvmextensions.dll cdecl';

function WOT_GetClientType(ClientIndex: Integer): Integer;
external 'WOT_GetClientType@files:xvmextensions.dll cdecl';

function WOT_GetClientWgcFlavour(ClientIndex: Integer): Integer;
external 'WOT_GetClientWgcFlavour@files:xvmextensions.dll cdecl';

procedure WOT_GetClientLocaleW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientLocaleW@files:xvmextensions.dll cdecl';

procedure WOT_GetClientPathW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientPathW@files:xvmextensions.dll cdecl';

procedure WOT_GetClientVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientVersionW@files:xvmextensions.dll cdecl';

procedure WOT_GetClientExeVersionW(Buffer: String; BufferSize: Integer; ClientIndex: Integer);
external 'WOT_GetClientExeVersionW@files:xvmextensions.dll cdecl';
