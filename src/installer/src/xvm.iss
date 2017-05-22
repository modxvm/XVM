#include "..\temp\defines\xvm_defines.iss"
#include "..\temp\l10n_result\lang.iss"

[Setup]
AppCopyright    = "2017 (c) XVM team"
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
DisableDirPage=false

OutputDir=..\output
OutputBaseFilename=setup_xvm

UninstallFilesDir={app}\xvm_uninst

DefaultDirName=C:\

[Tasks]
Name: "xvmbackup"; Description: "{cm:backupXVM}"; Flags: unchecked

[Run]
Filename: http://modxvm.com/; Description: "{cm:websiteXVM}"; Flags: postinstall nowait shellexec;

[Files]
Source: "{app}\res_mods\configs\*"; DestDir: "{app}\xvm_backup\configs"; Tasks: xvmbackup; Flags: external skipifsourcedoesntexist createallsubdirs recursesubdirs uninsneveruninstall
Source: "..\..\..\~output\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs
Source: "dll\findwot\bin\findwot.dll"; Flags: dontcopy                                             

[InstallDelete]
;ver\gui\flash
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battleVehicleMarkersApp.swf"
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

;mods\packages
Type: filesandordirs; Name: "{app}\res_mods\mods\packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\packages\"

;mods\xfw
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[UninstallDelete]
;ver\gui\flash
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battle.swf"
Type: filesandordirs; Name: "{app}\res_mods\{#VersionWOT}\gui\flash\battleVehicleMarkersApp.swf"
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

;mods\packages
Type: filesandordirs; Name: "{app}\res_mods\mods\packages\xvm_*"
Type: dirifempty; Name: "{app}\res_mods\mods\packages\"

;mods\xfw
Type: filesandordirs; Name: "{app}\res_mods\mods\xfw"

;configs\xvm\py_macro
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\xvm\*.pyc"
Type: filesandordirs; Name: "{app}\res_mods\configs\xvm\py_macro\*.pyc"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\xvm\py_macro\"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\xvm\"
Type: dirifempty; Name: "{app}\res_mods\сonfigs\"

Type: filesandordirs; Name: "{app}\xvm_uninst"
Type: files; Name: "{app}\readme-*.txt"

[Code]
procedure GetWotPreferredW(Buffer: String; Max: Integer);
external 'GetWotPreferredW@files:findwot.dll cdecl';

function GetWotPathsCount(): Integer;
external 'GetWotPathsCount@files:findwot.dll cdecl';

procedure GetWotPathsItemW(Buffer: String; Max: Integer; Index: Integer);
external 'GetWotPathsItemW@files:findwot.dll cdecl';

var
  DirCombo: TNewComboBox;

procedure DirComboChange(Sender: TObject);
var
  index: Integer;
begin
  if DirCombo.Text = ExpandConstant('{cm:browse}')  then
  begin
    WizardForm.DirBrowseButton.OnClick(nil);

    for index:=0 to DirCombo.Items.Count do 
    begin
      if WizardForm.DirEdit.Text=DirCombo.Items.Strings[index] then
      begin
        DirCombo.ItemIndex:=index;
        exit;
      end;
    end;
    
    if not FileExists(WizardForm.DirEdit.Text+'\WorldOfTanks.exe') then 
    begin
      MsgBox( ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
      DirCombo.ItemIndex:=-1;
      WizardForm.DirEdit.Text:='';
      exit;
    end;

    DirCombo.Items.Insert(DirCombo.Items.Count-1,WizardForm.DirEdit.Text)
    DirCombo.ItemIndex := DirCombo.Items.Count-2;

  end
  else
  begin
    WizardForm.DirEdit.Text:=DirCombo.Text;
  end;
end;


procedure InitializeWizard();
var
  WotPathsCount, Index: Integer;
  Buffer: String;
begin
  WizardForm.DirEdit.Visible := False;
  WizardForm.DirEdit.Text := '';
  WizardForm.DirBrowseButton.Visible := False;

  DirCombo := TNewComboBox.Create(WizardForm);
  DirCombo.Parent := WizardForm.DirEdit.Parent;
  DirCombo.Style := csDropDownList;
  DirCombo.OnChange := @DirComboChange;
  DirCombo.SetBounds(
    WizardForm.DirEdit.Left, 
    WizardForm.DirEdit.Top,
    WizardForm.DirBrowseButton.Left + WizardForm.DirBrowseButton.Width - WizardForm.DirEdit.Left, 
    WizardForm.DirEdit.Height
  );
          
  WotPathsCount := GetWotPathsCount();
  if WotPathsCount > 0 then
  begin
    SetLength(Buffer, 512);
    for Index:=0 to wotPathsCount-1 do
    begin
      GetWotPathsItemW(Buffer,512,index);
      DirCombo.Items.Add(Buffer);
     end;
  end;

  DirCombo.Items.Add(ExpandConstant('{cm:browse}'));
end;

procedure CurPageChanged(CurPage: Integer);
begin
	if (CurPage = wpSelectDir) then
	begin
		if DirCombo.ItemIndex = -1 then
			DirCombo.ItemIndex := 0;
 
		DirCombo.OnChange(nil);
	end;
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin                      
  Result := True;
  
  if CurPage = wpSelectDir then
  begin
   if not FileExists(ExpandConstant('{app}\WorldOfTanks.exe')) then 
   begin
      MsgBox( ExpandConstant('{cm:wotNotFound}'), mbError, MB_OK);
      Result := False;
      exit;
    end;
  end;
end;
