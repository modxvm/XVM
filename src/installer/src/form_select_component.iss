[Code]

const
  BTN_WIDTH = 75;
  BTN_HEIGHT = 23;
  BORDER_WIDTH = 20;
  PATH_INSTALL_SETTINGS = '{userappdata}\Wargaming.net\WorldOfTanks\xvm\install';
  FILE_NAME_SETTINGS = 'settings.ini';
  SETUP_SETTINGS = 'SetupSettings';

  IMAGE_IF_SELECTED = 0;
  IMAGE_IF_NOT_SELECTED = 1;
  VALUE_IF_SELECTED = 2;
  VALUE_IF_NOT_SELECTED = 3;
  SOUND_IF_SELECTED = 4;
  SOUND_IF_NOT_SELECTED = 5;
  INTERNAL_NAME = 6;
  DESCRIPTION = 7;

type
  TItems = (iCheckBox, iRadioBtn, iGroup);
  TSettings = record
    NameFile: String;
    Value: String;
    AdditionalFiles: String;
    IsAdd: Boolean;
  end;

var
  arraySettings: array of TSettings;
  FNameSettings, SelectPreset, DirTemp, FNameL10n, LinkSupport: String;
  Image: TBitmapImage;
  SettingsCheckListBox: TNewCheckListBox;
  DescriptionLabel: TLabel;
  SizeBuf: Integer;
  ItemsType: array [0..4096] of TItems;
  SoundStream: DWORD;


procedure GetNamesAndValues(Path: String; ALevel: Byte; TypeItem : TItems); forward;

function GetIniStringEx(const Section, Key, Default, Filename: String): String;
begin
  Result := GetIniString(Section, Key, Default, Filename);
  StringChangeEx(Result, '\n', #13#10, True);
end;

procedure Init();
var
  ResultCode: Integer;
begin
  //MsgBox(ExpandConstant(PATH_INSTALL_SETTINGS), mbInformation, MB_OK);
  DirTemp := ExpandConstant('{tmp}\') + SelectPreset;
  ExtractTemporaryFile(SelectPreset + '.mrg');
  ResultCode := UNPACK_divide(DirTemp + '\', DirTemp + '.mrg');
  FNameL10n := DirTemp + '\l10n\' + ActiveLanguage + '.lng';
  BASS_Init(-1, 44100, 0, 0, 0);
  SoundStream := 0;
end;

procedure CopyingAdditionalFiles(AdditionalFiles: String);
var
  FileNames : TStringList;
  i: Integer;
  tmp, app, FileName, Buffer: String;
begin
  SetLength(Buffer, SizeBuf);
  JSON_GetArrayValueW_S(AdditionalFiles, Buffer, SizeBuf);
  FileNames := TStringList.Create;
  try
    FileNames.Text := Copy(Buffer, 0, Pos(#0, Buffer));
    for i := 0 to FileNames.Count - 1 do
      if FileNames[i] <> '' then
        begin
          FileName := FileNames[i];
          StringChangeEx(FileName, '/', '\', True);
          if FileName[1] = #92 then
          begin
            tmp := DirTemp + '\files' + FileName;
            app := ExpandConstant('{app}') + FileName;
          end else
          begin
            tmp := DirTemp + '\files\' + FileName;
            app := ExpandConstant('{app}\') + FileName;
          end;
          if not FileCopy(tmp, app, False) then
            SaveStringToFile(ExpandConstant('{src}\log.txt'), FileName + ' - file not copied' + #13, True);
        end;
  finally
    FileNames.Free;
  end;
end;

procedure ApplySettings;
var
  Count, i: Integer;
begin
  Count := Length(arraySettings);
  for i := 0 to Count - 1 do
  begin
    if (arraySettings[i].NameFile <> '') and (arraySettings[i].Value <> '') then
    begin
      JSON_SetValueObjW(ExpandConstant('{app}\res_mods\configs\xvm\') + SelectPreset + '\' + arraySettings[i].NameFile, arraySettings[i].Value, arraySettings[i].IsAdd);
      //SaveStringToFile(ExpandConstant('{src}\log.txt'), inttostr(i) + ' = ' + arraySettings[i].Value + #13, True);
    end;
    if arraySettings[i].AdditionalFiles <> '' then
      CopyingAdditionalFiles(arraySettings[i].AdditionalFiles);
  end;
end;

procedure AddItem(Path: String; NamesList, ValuesList: TStringList; ALevel: Byte; TypeItem: TItems);
var
  Setting: TStringList;
  Index: Integer;
  Name, InternalName: String;
  Checked: Boolean;
begin
  //MsgBox(Path, mbInformation, MB_OK);

  //MsgBox(IntToStr(NamesList.Count) + NamesList.Text, mbInformation, MB_OK);
  //MsgBox(IntToStr(ValuesList.Count) + ValuesList.Text, mbInformation, MB_OK);
  Setting := TStringList.Create;
  if NamesList.Find('name', Index) then
    Name := GetIniString('CheckListBox', ValuesList[Index], ValuesList[Index], FNameL10n)   //name
  else
    Exit;
  Checked := not (NamesList.Find('checked', Index) and (AnsiLowercase(Trim(ValuesList[Index])) = 'false'));
  TypeItem := iCheckBox;
  if NamesList.Find('itemtype', Index) then
    if (AnsiLowercase(Trim(ValuesList[Index])) = 'group') then
      TypeItem := iGroup
    else if (AnsiLowercase(Trim(ValuesList[Index])) = 'radiobutton') then
      TypeItem := iRadioBtn;
  if NamesList.Find('imageifselected', Index) and (Trim(ValuesList[Index]) <> '') then
    Setting.Append(ValuesList[Index])   //0 - imageIfSelected
  else
    Setting.Append('empty.png');
  if NamesList.Find('imageifnotselected', Index) and (Trim(ValuesList[Index]) <> '') then
    Setting.Append(ValuesList[Index])   //1 - imageIfNotSelected
  else
    Setting.Append('empty.png');
  if NamesList.Find('valueifselected', Index) then
    Setting.Append(ValuesList[Index])   //2 - valueIfSelected
  else
    Setting.Append('');
  if NamesList.Find('valueifnotselected', Index) then
    Setting.Append(ValuesList[Index])   //3 - valueIfNotSelected
  else
    Setting.Append('');
  if NamesList.Find('soundifselected', Index) then
    Setting.Append(ValuesList[Index])   //4 - soundIfSelected
  else
    Setting.Append('');
  if NamesList.Find('soundifnotselected', Index) then
    Setting.Append(ValuesList[Index])   //5 - soundIfNotSelected
  else
    Setting.Append('');
  if NamesList.Find('name', Index) then
  begin
    InternalName := ValuesList[Index];
    Setting.Append(InternalName);       //6 - internal name
    Checked := GetIniBool(SETUP_SETTINGS, InternalName, Checked, ExpandConstant(PATH_INSTALL_SETTINGS) + '\' + FILE_NAME_SETTINGS)
  end;
  if NamesList.Find('description', Index) then
    Setting.Append(GetIniStringEx('DescriptionLabel', ValuesList[Index], '', FNameL10n))   //7 - description
  else
    Setting.Append('');
  //MsgBox(Name + #13 + Setting.Text, mbInformation, MB_OK);
  case TypeItem of
    iCheckBox:
      Index := SettingsCheckListBox.AddCheckBox(Name, '', ALevel, Checked, True, True, False, Setting);
    iRadioBtn:
      Index := SettingsCheckListBox.AddRadioButton(Name, '', ALevel, Checked, True, Setting);
    iGroup:
      Index := SettingsCheckListBox.AddGroup(Name, '', ALevel, nil);
  end;
  ItemsType[Index] := TypeItem;
  if NamesList.Find('children', Index) then
    GetNamesAndValues(Path + '/children', ALevel + 1, TypeItem);

end;

procedure GetNamesAndValues(Path: String; ALevel: Byte; TypeItem: TItems);
var
  RootList, NamesList, ValuesList: TStringList;
  FileName, BufNames, BufValues: String;
  i: Integer;
begin
  try
    FileName := DirTemp + '\' + FNameSettings;
    //MsgBox('FileName = ' + FileName, mbInformation, MB_OK);
    SetLength(BufNames, SizeBuf);
    SetLength(BufValues, SizeBuf);
    JSON_GetNamesAndValuesW(FileName, Path, BufNames, BufValues, SizeBuf);
    RootList := TStringList.Create;
    try
      RootList.Text := Copy(BufNames, 0, Pos(#0, BufNames));
      //MsgBox(IntToStr(RootList.Count) + RootList.Text, mbInformation, MB_OK);
      if Trim(Path) <> '' then Path := Path + '/';
      for i := 0 to RootList.Count - 1 do
      begin
        NamesList := TStringList.Create;
        ValuesList := TStringList.Create;
        try
          JSON_GetNamesAndValuesW(FileName, Path + RootList[i], BufNames, BufValues, SizeBuf);
          NamesList.Text := AnsiLowercase(Copy(BufNames, 0, Pos(#0, BufNames)));
          ValuesList.Text := Copy(BufValues, 0, Pos(#0, BufValues));
          AddItem(Path + RootList[i], NamesList, ValuesList, ALevel, TypeItem);
        finally
          NamesList.Free;
          ValuesList.Free;
        end;
      end;
    finally
      RootList.Free;
    end;
  except
    //ShowExceptionMessage;
  end;
end;

procedure AddToArrayS(Value: string; var j: Integer);
var
  RootList, NamesList, ValuesList: TStringList;
  i, Index: Integer;
  BufNames, BufValues: String;
begin
  SetLength(BufNames, SizeBuf);
  SetLength(BufValues, SizeBuf);
  JSON_GetNamesAndValuesW_S(Value, BufNames, BufValues, SizeBuf);
  RootList := TStringList.Create;
  try
    RootList.Text := Copy(BufValues, 0, Pos(#0, BufValues));
    //MsgBox(IntToStr(RootList.Count) + RootList.Text, mbInformation, MB_OK);
    for i := 0 to RootList.Count - 1 do
    begin
      NamesList := TStringList.Create;
      ValuesList := TStringList.Create;
      try
        JSON_GetNamesAndValuesW_S(RootList[i], BufNames, BufValues, SizeBuf);
        NamesList.Text := AnsiLowercase(Copy(BufNames, 0, Pos(#0, BufNames)));
        ValuesList.Text := Copy(BufValues, 0, Pos(#0, BufValues));
        if NamesList.Find('configfilename', Index) then
        begin
          arraySettings[j].NameFile := ValuesList[Index];
          if NamesList.Find('value', Index) then
            arraySettings[j].Value := ValuesList[Index];
        end else
        begin
          arraySettings[j].NameFile := '';
          arraySettings[j].Value := '';
        end;
        if NamesList.Find('@files', Index) then
          arraySettings[j].AdditionalFiles := ValuesList[Index]
        else
          arraySettings[j].AdditionalFiles := '';
        if (NamesList.Find('isadd', Index)) and (AnsiLowercase(Trim(ValuesList[Index])) = 'false') then
          arraySettings[j].IsAdd := False
        else
          arraySettings[j].IsAdd := True;

        //MsgBox('AdditionalFiles = ' + AdditionalFiles, mbInformation, MB_OK);
        j := j + 1;
        if j >= Length(arraySettings) then
          SetLength(arraySettings, j + 20);
      finally
        NamesList.Free;
        ValuesList.Free;
      end;
    end;
  finally
    RootList.Free;
  end;
end;

procedure SetSettings();
var
  i, j: Integer;
  Value, Path, FilePath: String;
begin
  with SettingsCheckListBox do
  begin
    path := ExpandConstant(PATH_INSTALL_SETTINGS);
    if not DirExists(Path) then ForceDirectories(Path);
    FilePath := Path + '\' + FILE_NAME_SETTINGS;
    DeleteFile(FilePath);
    SetLength(arraySettings, Items.Count);
    j:= 0;
    for i := 0 to Items.Count - 1 do
      case ItemsType[i] of
      iCheckBox, iRadioBtn:
        begin
          if Checked[i] then
          begin
            Value := TStringList(ItemObject[i]).Strings[VALUE_IF_SELECTED];
            SetIniBool(SETUP_SETTINGS, TStringList(ItemObject[i]).Strings[INTERNAL_NAME], True, FilePath);
          end else
          begin
            Value := TStringList(ItemObject[i]).Strings[VALUE_IF_NOT_SELECTED];
            SetIniBool(SETUP_SETTINGS, TStringList(ItemObject[i]).Strings[INTERNAL_NAME], False, FilePath);
          end;
          if Trim(Value) <> '' then
            AddToArrayS(Value, j);
        end;
      end;
    SetLength(arraySettings, j);
  end;
end;

procedure ShowPreview(FileName: String);
var
  ImageNameBMP: String;
begin
  try
    ImageNameBMP := DirTemp + '\images\' + ChangeFileExt(FileName, '.bmp');
    if (AnsiLowercase(ExtractFileExt(FileName)) = '.png') and not FileExists(ImageNameBMP)then
      IMAGEDRAW_PngToBmp(DirTemp + '\images\' + FileName);
    if FileExists(ImageNameBMP) then
      Image.Bitmap.LoadFromFile(ImageNameBMP);
  except
    //ShowExceptionMessage;
  end;
end;

procedure PlaySound(FileName: String);
begin
  if SoundStream > 0 then
  begin
    if BASS_ChannelIsActive(SoundStream) > 0 then
      begin
        BASS_ChannelStop(SoundStream);
      end;
    BASS_StreamFree(SoundStream);
  end;
  if Trim(FileName) <> '' then
  begin
    SoundStream := BASS_StreamCreateFile(FALSE, PAnsiChar(DirTemp + '\sounds\' + FileName), 0, 0, 0);
    BASS_ChannelPlay(SoundStream, True);
  end;
end;

procedure SettingsCheckListBoxOnClickCheck(Sender: TObject);
begin
  with TNewCheckListBox(Sender) do
  begin
    case State[ItemIndex] of
      cbUnchecked:
      begin
        ShowPreview(TStringList(ItemObject[ItemIndex]).Strings[1]);
        PlaySound(TStringList(ItemObject[ItemIndex]).Strings[5]);
      end;
      cbChecked, cbGrayed:
      begin
        ShowPreview(TStringList(ItemObject[ItemIndex]).Strings[0]);
        PlaySound(TStringList(ItemObject[ItemIndex]).Strings[4]);
      end;
    end;
    DescriptionLabel.Caption := TStringList(ItemObject[ItemIndex]).Strings[7];
  end;
end;

procedure LinkSupportLabelOnClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('', LinkSupport, '', '', SW_SHOW, ewNoWait, ErrorCode);
end;

procedure SelectComponentButtonOnClick(Sender: TObject);
var
  SelectComponentForm: TSetupForm;
  OKButton, CancelButton: TNewButton;
  Bevel: TBevel;
  LinkSupportLabel: TLabel;
begin
  Init();
  SelectComponentForm := CreateCustomForm();
  try
    SelectComponentForm.ClientWidth := ScaleX(610);
    SelectComponentForm.ClientHeight := ScaleY(420);
    SelectComponentForm.Caption := ExpandConstant('{cm:SettingConfigurationForm}');
    //SelectComponentForm.CenterInsideControl(WizardForm, False);
    SelectComponentForm.FlipSizeAndCenterIfNeeded(False, WizardForm, False);

    Bevel := TBevel.Create(SelectComponentForm);
    Bevel.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10 + 14);                 // 453
    Bevel.Left := ScaleX(0);                                                                      // 0
    Bevel.Width := SelectComponentForm.ClientWidth;                                               // 730
    Bevel.Height := ScaleY(2);                                                                    // 2
    Bevel.Parent := SelectComponentForm;

    OKButton := TNewButton.Create(SelectComponentForm);
    OKButton.Parent := SelectComponentForm;
    OKButton.Width := ScaleX(BTN_WIDTH);                                                          // 75
    OKButton.Height := ScaleY(BTN_HEIGHT);                                                        // 23
    OKButton.Left := SelectComponentForm.ClientWidth - ScaleX(BTN_WIDTH + 6 + BTN_WIDTH + 10);    // 564
    OKButton.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10);                   // 467
    OKButton.Caption := SetupMessage(msgButtonOK);
    OKButton.ModalResult := mrOk;
    OKButton.Default := True;

    CancelButton := TNewButton.Create(SelectComponentForm);
    CancelButton.Parent := SelectComponentForm;
    CancelButton.Width := ScaleX(BTN_WIDTH);                                                      // 75
    CancelButton.Height := ScaleY(BTN_HEIGHT);                                                    // 23
    CancelButton.Left := SelectComponentForm.ClientWidth - ScaleX(BTN_WIDTH + 10);                // 645
    CancelButton.Top := SelectComponentForm.ClientHeight - ScaleY(BTN_HEIGHT + 10);               // 467
    CancelButton.Caption := SetupMessage(msgButtonCancel);
    CancelButton.ModalResult := mrCancel;
    CancelButton.Cancel := True;

    SettingsCheckListBox := TNewCheckListBox.Create(SelectComponentForm);
    SettingsCheckListBox.Top := ScaleY(BORDER_WIDTH);                                             // 20
    SettingsCheckListBox.Left := ScaleX(BORDER_WIDTH);                                            // 20
    SettingsCheckListBox.Width := ScaleX(300);                                                    // 300
    SettingsCheckListBox.Height := Bevel.Top - ScaleY(BORDER_WIDTH + BORDER_WIDTH);               // 413
    SettingsCheckListBox.Parent := SelectComponentForm;
    SettingsCheckListBox.WantTabs := True;
    SettingsCheckListBox.OnClickCheck := @SettingsCheckListBoxOnClickCheck;

    DescriptionLabel := TLabel.Create(SelectComponentForm);
    DescriptionLabel.Parent := SelectComponentForm;
    DescriptionLabel.Height := ScaleY(40);                                                                      // 40
    DescriptionLabel.Top := Bevel.Top - ScaleX(BORDER_WIDTH) - DescriptionLabel.Height;                         // 393
    DescriptionLabel.Left := SettingsCheckListBox.Left + SettingsCheckListBox.Width + ScaleX(BORDER_WIDTH);     // 340
    DescriptionLabel.Width := SelectComponentForm.ClientWidth - DescriptionLabel.Left - ScaleX(BORDER_WIDTH);   // 370
    DescriptionLabel.AutoSize := False;
    DescriptionLabel.Alignment := taCenter;
    DescriptionLabel.WordWrap := True;

    LinkSupportLabel := TLabel.Create(SelectComponentForm);
    LinkSupportLabel.Parent := SelectComponentForm;
    LinkSupportLabel.Top := CancelButton.Top + 3;              // 470
    LinkSupportLabel.Left := ScaleX(BORDER_WIDTH);             // 20
    LinkSupportLabel.AutoSize := True;
    LinkSupportLabel.Alignment := taLeftJustify;
    LinkSupportLabel.Font.Color := $FF6300;
    LinkSupportLabel.Font.Style := [fsUnderline];
    LinkSupportLabel.Caption := ExpandConstant('{cm:LinkSupportConfigs}');
    LinkSupportLabel.Cursor := crHand;
    LinkSupportLabel.OnClick := @LinkSupportLabelOnClick;

    FileSize(DirTemp + '\' + FNameSettings, SizeBuf);
    GetNamesAndValues(' ', 0, iCheckBox);

    Image := TBitmapImage.Create(SelectComponentForm);
    Image.Top := SettingsCheckListBox.Top;                                     // 20
    Image.Left := DescriptionLabel.Left;                                       // 340
    Image.Width := DescriptionLabel.Width;                                     // 370
    Image.Height := DescriptionLabel.Top - Image.Top - ScaleY(BORDER_WIDTH);   // 353
    Image.Parent := SelectComponentForm;
    Image.Center := True;

    //ExtractTemporaryFile('big_image.bmp');
    //Image.Bitmap.LoadFromFile(ExpandConstant('{tmp}\big_image.bmp'));

    SelectComponentForm.ActiveControl := SettingsCheckListBox;

    if SelectComponentForm.ShowModal() = mrOk then
    begin
      BASS_Free();
      SetSettings();
    end;
  finally
    SelectComponentForm.Free();
  end;
end;

procedure AddButtonSelectComponent();
var
  SelectComponentButton: TNewButton;
begin
  with WizardForm do
  begin
    SelectComponentButton := TNewButton.Create(WizardForm);
    SelectComponentButton.Width := ScaleX(145);
    SelectComponentButton.Left := TypesCombo.Left + TypesCombo.Width - SelectComponentButton.Width + ScaleX(1);
    SelectComponentButton.Top := TypesCombo.Top + TypesCombo.Height + ScaleX(15);
    SelectComponentButton.Height := CancelButton.Height;
    SelectComponentButton.Anchors :=[akRight, akTop];
    SelectComponentButton.Caption := ExpandConstant('{cm:SettingConfigurationBtn}');
    SelectComponentButton.OnClick := @SelectComponentButtonOnClick;
    SelectComponentButton.Parent := SelectComponentsLabel.Parent;
  end;
end;
