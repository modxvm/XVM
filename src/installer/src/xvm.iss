#include "..\temp\defines\xvm_defines.iss"
#include "..\temp\l10n_result\lang.iss"
#include "xvmextensions.iss"

[Setup]
AppCopyright    = "2021 (c) XVM Team"
AppId           = {{2865cd27-6b8b-4413-8272-cd968f316050}
AppName         = "XVM"
AppPublisher    = "XVM Team"
AppPublisherURL = "https://modxvm.com/"
AppSupportURL   = "https://modxvm.com/"
AppUpdatesURL   = "https://modxvm.com/"
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

UninstallFilesDir={app}\xvm_uninst

DefaultDirName=C:\

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked;

[Run]
Filename: https://modxvm.com/; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[Components]
;Name: "XVM"; Description: "{cm:component_XVM}"; Types: full compact custom; Flags: fixed;

[Files]
;backup
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;
Source: "{app}\res_mods\mods\shared_resources\xvm\res\*"; DestDir: "{app}\xvm_backup\mods\shared_resources\xvm\res"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall;

;xvm
Source: "..\..\..\~output\deploy\mods\*"; DestDir: "{app}\mods"; Flags: createallsubdirs recursesubdirs
Source: "..\..\..\~output\deploy\res_mods\*"; DestDir: "{app}\res_mods"; Flags: createallsubdirs recursesubdirs
Source: "..\..\..\~output\deploy\readme*.*"; DestDir: "{app}"

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
      Str := Copy(Buffer, 0, Pos(#0, Buffer));

      Insert(' [', Str, Pos(#0, Str));

      case WOT_GetClientWgcFlavour(Index) of
         1: Insert('WG/', Str, Pos(#0, Str));
         2: Insert('360/', Str, Pos(#0, Str));
         3: Insert('Steam/', Str, Pos(#0, Str));
      end;

      case WOT_GetClientBranch(Index) of
         1: Insert('Release', Str, Pos(#0, Str));
         2: Insert('CT', Str, Pos(#0, Str));
         3: Insert('ST', Str, Pos(#0, Str));
         4: Insert('SB', Str, Pos(#0, Str));
      end;

      Insert('] - ', Str, Pos(#0, Str));

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
     MsgBox(ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
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

procedure InitializeWizard();
begin
  SetLength(Buffer, 1024);

  WizardForm.DirEdit.Visible := False;
  WizardForm.DirEdit.Text := '';
  WizardForm.DirBrowseButton.Visible := False;

  WotList := TNewComboBox.Create(WizardForm);
  WotList.Parent := WizardForm.DirEdit.Parent;
  WotList.Style := csDropDownList;
  WotList.OnChange := @WotList_OnChange;
  WotList.SetBounds(
    WizardForm.DirEdit.Left,
    WizardForm.DirEdit.Top,
    WizardForm.DirBrowseButton.Left + WizardForm.DirBrowseButton.Width,
    WizardForm.DirEdit.Height
  );

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

    WotList.OnChange(nil);
  end;
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
