// SPDX-License-Identifier: MIT
// Copyright (c) 2017-2023 XVM Contributors

#define APP_WEBSITE    "https://modxvm.com/"
#define APP_DIR_UNINST "xvm_uninst"

#define OPENWGUTILS_DIR_SRC    "."
#define OPENWGUTILS_DIR_UNINST APP_DIR_UNINST

#include "..\temp\defines\xvm_defines.iss"
#include "..\temp\l10n_result\lang.iss"
#include "openwg.utils.iss"

[Setup]
AppCopyright    = "2023 (c) XVM Team"
AppId           = {{2865cd27-6b8b-4413-8272-cd968f316050}
AppName         = "XVM"
AppPublisher    = "XVM Team"
AppPublisherURL = {#APP_WEBSITE}
AppSupportURL   = {#APP_WEBSITE}
AppUpdatesURL   = {#APP_WEBSITE}
AppVersion      = {#VersionXVM}

WizardImageFile      = images\big_image.bmp
WizardSmallImageFile = images\small_image.bmp
WizardStyle          = modern
SetupIconFile        = images\setup_ico.ico

Compression=lzma2/ultra64
InternalCompressLevel=ultra64

DirExistsWarning=false
CreateAppDir=true
AppendDefaultDirName=false
ShowLanguageDialog=true
DisableProgramGroupPage=true
Uninstallable=true
DisableDirPage=false

OutputDir=..\output
OutputBaseFilename=setup_xvm

UninstallFilesDir={app}\{#APP_DIR_UNINST}
DefaultDirName=C:\
UsePreviousAppDir=yes

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked;

[Run]
Filename: https://modxvm.com/; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[CustomMessages]
en.version_not_match=This client is not supported.%n%nThis installer only supports WoT v{#VersionWOT}
ru.version_not_match=Выбранный клиент не поддерживается.%n%nЭтот установщик поддерживает только WoT v{#VersionWOT}
en.client_started=The selected client is running.%n%nDo you want to terminate the selected client?
ru.client_started=Выбранный клиент запущен.%n%nЖелаете ли вы закрыть выбранный клиент?

[Files]
;backup
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;
Source: "{app}\res_mods\mods\shared_resources\xvm\res\*"; DestDir: "{app}\xvm_backup\mods\shared_resources\xvm\res"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;

;xvm/WG
Source: "..\..\..\~output\wg\deploy\mods\*"    ; DestDir: "{app}\mods"    ; Check: not CHECK_IsLesta; Flags: createallsubdirs recursesubdirs;
Source: "..\..\..\~output\wg\deploy\res_mods\*"; DestDir: "{app}\res_mods"; Check: not CHECK_IsLesta; Flags: createallsubdirs recursesubdirs; 
Source: "..\..\..\~output\wg\deploy\readme*.*" ; DestDir: "{app}"         ; Check: not CHECK_IsLesta;                                     

;xvm/Lesta
Source: "..\..\..\~output\lesta\deploy\mods\*"    ; DestDir: "{app}\mods"    ; Check: CHECK_IsLesta; Flags: createallsubdirs recursesubdirs;
Source: "..\..\..\~output\lesta\deploy\res_mods\*"; DestDir: "{app}\res_mods"; Check: CHECK_IsLesta; Flags: createallsubdirs recursesubdirs; 
Source: "..\..\..\~output\lesta\deploy\readme*.*" ; DestDir: "{app}"         ; Check: CHECK_IsLesta;                                     

[InstallDelete]
;mods\ver\com.modxvm.xfw\*.wotmod
Type: filesandordirs; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\com.modxvm.*.wotmod"
Type: dirifempty; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\"

;mods\ver\temp
Type: filesandordirs; Name: "{app}\mods\temp\com.modxvm.*"
Type: dirifempty; Name: "{app}\mods\temp\"

;res_mods\mods\packages
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw_packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\xfw_packages\"
Type: dirifempty; Name: "{app}\res_mods\mods\"

;res_mods\ver\audioww
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\audioww\xvm.bnk"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\audioww\"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\configs\"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[UninstallDelete]
;mods\ver\com.modxvm.xfw\*.wotmod
Type: filesandordirs; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\com.modxvm.*.wotmod"
Type: dirifempty; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\"

;mods\ver\temp
Type: filesandordirs; Name: "{app}\mods\temp\com.modxvm.*"
Type: dirifempty; Name: "{app}\mods\temp\"

;res_mods\mods\shared_resources
Type: filesandordirs; Name: "{app}\res_mods\mods\shared_resources\xvm"
Type: dirifempty; Name: "{app}\res_mods\mods\shared_resources\"

;res_mods\mods\packages
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw_packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\xfw_packages\"
Type: dirifempty; Name: "{app}\res_mods\mods\"

;res_mods\ver\audioww
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\audioww\xvm.bnk"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\audioww\"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\xvm.xc"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\configs\"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[Code]

//
// Globals
//

var
  WotList: TNewComboBox;


//
// Checks
//

function CHECK_IsLesta(): Boolean;
var
  Flavour: Integer;
begin
  Flavour := WotList_Selected_Record(WotList).LauncherFlavour
  Result := Flavour = 4;
end;


//
// Placeholders
//

function PH_Folder_Mods(s: String): String;
begin
  Result := WotList_Selected_Record(WotList).PathMods;
end;

function PH_Folder_Resmods(s: String): String;
begin
  Result := WotList_Selected_Record(WotList).PathResmods;
end;


//
// Initialize
//

function InitializeSetup: Boolean;
begin
  Result := True;
end;


function InitializeUninstall: Boolean;
begin
  Result := True;
end;


procedure InitializeWizard();
begin
  WotList := WotList_Create(WizardForm.DirEdit.Parent,
      WizardForm.DirEdit.Left,
      WizardForm.DirEdit.Top,
      WizardForm.DirBrowseButton.Left + WizardForm.DirBrowseButton.Width,
      WizardForm.DirEdit.Height
  );
  WotList.ItemIndex := WOT_ClientFind(WizardForm.DirEdit.Text);

  if (WotList.ItemIndex = -1) and (WotList.Items.Count > 1) then
    WotList.ItemIndex := 0;
  WotList.OnChange(WotList);

  WizardForm.DirEdit.Visible := False;
  WizardForm.DirBrowseButton.Visible := False;
end;


//
// CurPageChanged
//

procedure CurPageChanged_wpSelectDir();
begin
end;


procedure CurPageChanged_wpSelectComponents();
var
  Index: Integer;
  IsLesta: Boolean;
  ItemCaption: String;
begin
  IsLesta := CHECK_IsLesta();

  for Index := 0 to WizardForm.ComponentsList.Items.Count - 1 do
  begin
    ItemCaption := WizardForm.ComponentsList.ItemCaption[Index];
    if ((pos('Lesta', ItemCaption) <> 0) and (not IsLesta)) or ((pos('WG', ItemCaption) <> 0) and IsLesta) then
    begin
        WizardForm.ComponentsList.Checked[Index] := false; 
        WizardForm.ComponentsList.ItemEnabled[Index] := false;   
    end;
  end;
end;


procedure CurPageChanged(CurPage: Integer);
begin
  case CurPage of
    wpSelectDir: CurPageChanged_wpSelectDir();
    wpSelectComponents: CurPageChanged_wpSelectComponents();
  end
end;



//
// CurUninstallStepChanged
//

procedure CurUninstallStepChanged_usUninstall();
begin
  OPENWG_DllUnload();
  OPENWG_DllDelete();
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  case CurUninstallStep of
    usUninstall: CurUninstallStepChanged_usUninstall();
  end
end;



//
// DeinitializeUninstall
//

procedure DeinitializeUninstall();
begin
end;



//
// NextButtonClick
//

function NextButtonClick_wpSelectDir(): Boolean;
begin
  Result := True;

  // check for version
  if not WotList_Selected_VersionMatch(WotList, '{#VersionWOT}') then
  begin
    MsgBox(ExpandConstant('{cm:version_not_match}'), mbError, MB_OK);
    Result := False;
    Exit;
  end;

  // check for running client
  if WotList_Selected_IsStarted(WotList) then
  begin
    if (MsgBox(ExpandConstant('{cm:client_started}'), mbConfirmation, MB_YESNO) = IDYES) then 
      WotList_Selected_Terminate(WotList)
    else
      Result := False;
  end;
end;


function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := True;

  case CurPage of
    wpSelectDir: Result := NextButtonClick_wpSelectDir();
  end;
end;
