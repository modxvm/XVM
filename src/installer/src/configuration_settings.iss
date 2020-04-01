#define DEFAULT "default"
#define DEFAULT_CB "default_cb"
#define Result Exec(SourcePath + "utils\merg_f.exe", "-mr default -e default\config", SourcePath + "SettingsInstall", 1, SW_HIDE)
#undef Result

[Files]
Source: "..\..\..\release\configs\{#DEFAULT}\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs
Source: "SettingsInstall\{#DEFAULT}\{#DEFAULT}.mrg"; Flags: dontcopy
;Source: "SettingsInstall\{#DEFAULT_CB}\config\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs
;Source: "SettingsInstall\{#DEFAULT_CB}\{#DEFAULT_CB}.mrg"; Flags: dontcopy

[Components]
Name: "default"; Description: "Config default XVM"; Types: default
;Name: "user"; Description: "User config"; Types: user

[Types]
Name: {#DEFAULT}; Description: "Default config"
;Name: {#DEFAULT_CB}; Description: "Default config (color_blindness)"

[Code]

procedure TypesComboOnChange(Sender: TObject);
begin
  if WizardForm.TypesCombo.Text = 'Default config' then
  begin
    SelectPreset := 'default';
    LinkSupport := 'https://koreanrandom.com/forum/forum/81-';
  end;
//  else if WizardForm.TypesCombo.Text = 'Default config (color_blindness)' then
//    SelectPreset := 'default_cb';
  FNameSettings := SelectPreset + '.xc';
end;

