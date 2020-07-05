#define DEFAULT "default"
#define Result Exec(SourcePath + "utils\merg_f.exe", "-mr default -e default\config", SourcePath + "SettingsInstall", 1, SW_HIDE)
#undef Result

[Files]
Source: "..\..\..\release\configs\{#DEFAULT}\*"; DestDir: "{app}"; Flags: createallsubdirs recursesubdirs
Source: "SettingsInstall\{#DEFAULT}\{#DEFAULT}.mrg"; Flags: dontcopy

[Components]
Name: "default"; Description: "Config default XVM"; Types: default

[Types]
Name: {#DEFAULT}; Description: "Default config"

[Code]

procedure TypesComboOnChange(Sender: TObject);
begin
  if WizardForm.TypesCombo.Text = 'Default config' then
  begin
    SelectPreset := 'default';
    LinkSupport := 'https://koreanrandom.com/forum/forum/81-';
  end;
  FNameSettings := SelectPreset + '.xc';
end;
