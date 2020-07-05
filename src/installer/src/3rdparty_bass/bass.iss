[Files]
Source: "3rdparty_bass\bass.dll"; Flags: dontcopy;

[Code]

function BASS_Init(device: Integer; freq, flags: DWORD; win: hwnd; CLSID: DWORD): BOOL;
external 'BASS_Init@files:BASS.dll stdcall delayload';

function BASS_StreamCreateFile(mem: BOOL; FileName: PAnsiChar; offset: Int64; length: Int64; flags: DWORD): DWORD;
external 'BASS_StreamCreateFile@files:BASS.dll stdcall delayload';

function BASS_ChannelPlay(Handle: DWORD; restart: BOOL): BOOL;
external 'BASS_ChannelPlay@files:BASS.dll stdcall delayload';

function BASS_Free(): BOOL;
external 'BASS_Free@files:BASS.dll stdcall delayload';

function BASS_ChannelIsActive(Handle: DWORD): DWORD;
external 'BASS_ChannelIsActive@files:bass.dll stdcall delayload';

function BASS_ChannelStop(Handle: DWORD): BOOL;
external 'BASS_ChannelStop@files:bass.dll stdcall delayload';

function BASS_StreamFree(Handle: DWORD): BOOL;
external 'BASS_StreamFree@files:bass.dll stdcall delayload';
