#include "xvm_defines.iss"
#include "l10n_result\lang.iss"

[Setup]
AppCopyright    = "2016 (c) XVM team"
AppId           = {{2865cd27-6b8b-4413-8272-cd968f316050}
AppName         = "XVM"
AppPublisher    = "XVM team"
AppPublisherURL = "http://modxvm.com/"
AppSupportURL   = "http://modxvm.com/"
AppUpdatesURL   = "http://modxvm.com/"
AppVersion      = {#VersionXVM}

WizardImageFile      = images\big_image.bmp
WizardSmallImageFile = images\small_image.bmp
SetupIconFile        = images\setup_ico.ico

Compression=lzma2/ultra64
InternalCompressLevel=ultra64

DirExistsWarning=false
CreateAppDir=true
AppendDefaultDirName=false
ShowLanguageDialog=true
DisableProgramGroupPage=true
Uninstallable=true

OutputDir=..\output
OutputBaseFilename=setup_xvm

UninstallFilesDir={app}\xvm_uninst

DefaultDirName={reg:HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%7b%7b1EAC1D02-C6AC-4FA6-9A44-96258C37C812RU%7d_is1,InstallLocation|{reg:HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%7b%7b1EAC1D02-C6AC-4FA6-9A44-96258C37C812RU%7d_is1,Path|C:\Games\World_of_Tanks}}

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked

[Run]
Filename: http://modxvm.com/; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[Files]
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall
Source: "..\..\..\~output\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs

[InstallDelete]
;ver\gui\flash
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battleVehicleMarkers.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\Lobby.swf"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui\flash"

;ver\gui\scaleform
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\Minimap.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\PlayersPanel.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\StatisticForm.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\TeamBasesPanel.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\VehicleMarkersManager.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\xvm.swf"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform"

;ver\gui
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui"

;ver\scripts\client\gui\scaleform
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\scaleform\locale"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\clients\gui\scaleform"

;ver\scripts\client\gui\mods
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\mods\mod_.pyc"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\mods"

;ver\scripts\client\gui
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts"

Type: filesandordirs; Name: "{app}\res_mods\mods\packages\xvm_*"
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[UninstallDelete]
;ver\gui\flash
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battleVehicleMarkers.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\Lobby.swf"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui\flash"

;ver\gui\scaleform
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\Minimap.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\PlayersPanel.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\StatisticForm.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\TeamBasesPanel.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\VehicleMarkersManager.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform\xvm.swf"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui\scaleform"

;ver\gui
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\gui"

;ver\scripts\client\gui\scaleform
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\scaleform\locale"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\clients\gui\scaleform"

;ver\scripts\client\gui\mods
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\mods\mod_.pyc"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui\mods"

;ver\scripts\client\gui
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client\gui"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts\client"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\scripts"

Type: filesandordirs; Name: "{app}\res_mods\mods\packages\xvm-*"
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[Code]
function NextButtonClick(CurPage: Integer): Boolean;
begin                      
  Result := True;
  
  if (CurPage = wpSelectDir) and not FileExists(ExpandConstant('{app}\WorldOfTanks.exe')) then 
  begin
    MsgBox( ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
    Result := False;
    exit;
  end;
end;
