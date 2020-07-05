#include "3rdparty_bass/bass.iss"
#include "3rdparty_unmergf/unmerg_f.iss"

#define XVMEXTENSION_DIR "3rdparty_xvmextensions/"
#include "3rdparty_xvmextensions/xvmextensions.iss"

#include "..\temp\defines\xvm_defines.iss"
#include "..\temp\l10n_result\lang.iss"
#include "xvm_defines_template.iss"
#include "form_select_component.iss"
#include "configuration_settings.iss"

[Setup]
AppCopyright    = "2020 (c) XVM Team"
AppId           = {{2865cd27-6b8b-4413-8272-cd968f316050}
AppName         = "XVM"
AppPublisher    = "XVM Team"
AppPublisherURL = "https://modxvm.com/"
AppSupportURL   = "https://modxvm.com/"
AppUpdatesURL   = "https://modxvm.com/"
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
DisableDirPage=false

OutputDir=..\output
OutputBaseFilename=setup_xvm

UninstallFilesDir={app}\xvm_uninst
DefaultDirName=C:\Games\World_of_Tanks

SetupLogging=yes
WizardStyle=modern

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked;

[Run]
Filename: https://modxvm.com/; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[Files]
;backup
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;
;xvm
;Source: "..\..\..\~output\mods\*"; DestDir: "{app}\mods"; Flags: createallsubdirs recursesubdirs; Components: XVM
;Source: "..\..\..\~output\res_mods\*"; DestDir: "{app}\res_mods"; Flags: createallsubdirs recursesubdirs; Components: XVM
;Source: "..\..\..\~output\readme*.*"; DestDir: "{app}"; Components: XVM

[InstallDelete]
;mods\ver\com.modxvm.xfw\*.wotmod
;Type: filesandordirs; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\com.modxvm.*.wotmod"
Type: dirifempty; Name: "{app}\mods\{#VersionWOT}\com.modxvm.xfw\"

;mods\ver\temp
;Type: filesandordirs; Name: "{app}\mods\temp\com.modxvm.*"
Type: dirifempty; Name: "{app}\mods\temp\"

;res_mods\mods\shared_resources
;Type: filesandordirs; Name: "{app}\res_mods\mods\shared_resources\xvm"
Type: dirifempty; Name: "{app}\res_mods\mods\shared_resources\"

;res_mods\mods\packages
;Type: filesandordirs; Name: "{app}\res_mods\mods\xfw_packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\xfw_packages\"
Type: dirifempty; Name: "{app}\res_mods\mods\"

;res_mods\ver\audioww
;Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\audioww\xvm.bnk"
Type: dirifempty; Name: "{app}\res_mods\{#VersionWOT}\audioww\"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\configs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\configs\"

Type: filesandordirs; Name: "{app}\xvm_uninst"
;Type: files; Name: "{app}\readme-*.txt"

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

var
  WotList: TNewComboBox;
  Buffer: String;

procedure WotList_Update();
var
  ClientsCount, Index, ListIndex: Integer;
  Str: String;
begin
  ListIndex := WotList.ItemIndex;
  ClientsCount := WOT_GetClientsCount();

  WotList.Items.Clear();

  if ClientsCount > 0 then
  begin
    for Index := 0 to ClientsCount - 1 do
    begin
      WOT_GetClientVersionW(Buffer, 1024, Index);
      Str:=Copy(Buffer, 0, Pos(#0, Buffer));

      case WOT_GetClientBranch(Index) of
        1: Insert(' Release: ', Str, Pos(#0, Str));
        2: Insert(' Common Test: ', Str, Pos(#0, Str));
        3: Insert(' Super Test: ', Str, Pos(#0, Str));
        4: Insert(' Sandbox: ', Str, Pos(#0, Str));
      end;

      WOT_GetClientPathW(Buffer, 1024, Index);
      Insert(Buffer, Str, Pos(#0, Str));

      WotList.Items.Add(Str);
    end;
  end;

  WotList.Items.Add(ExpandConstant('{cm:browse}'));
  WotList.ItemIndex := ListIndex;
end;

procedure WotList_AddClient(ClientPath: String);
var
  Index: Integer;
begin
  if Length(ClientPath) = 0 then
  begin
    WotList.ItemIndex := -1;
    Exit;
  end;

  Index := WOT_AddClientW(ClientPath);
  if Index >= 0 then
  begin
    WotList_Update();
    WotList.ItemIndex := Index;
  end else
  begin
    MsgBox( ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
    WotList.ItemIndex := -1;
  end;
end;

procedure WotList_OnChange(Sender: TObject);
begin
  if WoTList.Text = ExpandConstant('{cm:browse}') then
  begin
    WizardForm.DirBrowseButton.OnClick(nil);
    WotList_AddClient(WizardForm.DirEdit.Text);
  end;

  WOT_GetClientPathW(Buffer, 1024, WotList.ItemIndex);
  WizardForm.DirEdit.Text := Buffer;
end;

function InitializeSetup(): Boolean;
begin
  FNameSettings := 'default.xc';
  SelectPreset:= 'default';
  LinkSupport := 'https://koreanrandom.com/forum/forum/81-';
  Result := True;
end;

procedure InitializeWizard();
begin
  //MsgBox('{cm:Path}', mbInformation, MB_OK);
  WizardForm.TypesCombo.OnChange := @TypesComboOnChange;

  SetLength(Buffer, 1024);

  WizardForm.DirEdit.Visible := False;
  WizardForm.DirEdit.Text := '';
  WizardForm.DirBrowseButton.Visible := False;

  WotList := TNewComboBox.Create(WizardForm);
  WotList.Parent := WizardForm.DirEdit.Parent;
  WotList.Style := csDropDownList;
  WotList.OnChange := @WotList_OnChange;

  WotList_Update();
end;

procedure CurPageChanged(CurPage: Integer);
begin
  if (CurPage = wpSelectDir) then
  begin
    if WotList.ItemIndex = -1 then
    begin
      WotList.ItemIndex := 0;
    end;
      WotList.SetBounds(
        WizardForm.DirEdit.Left,
        WizardForm.DirEdit.Top,
        WizardForm.DirBrowseButton.Left + WizardForm.DirBrowseButton.Width - WizardForm.DirEdit.Left,
        WizardForm.DirEdit.Height
      );
    WotList.OnChange(nil);
  end;
  if (CurPage = wpSelectComponents) then
    AddButtonSelectComponent();
  if (CurPage = wpFinished) then
    ApplySettings();
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := True;

  if (CurPage = wpSelectDir) then
  begin
    if not FileExists(ExpandConstant('{app}\WorldOfTanks.exe')) then
    begin
      MsgBox(ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
      Result := False;
      Exit;
    end;
  end;
end;
