class net.wargaming.SettingsDialog extends net.wargaming.Dialog
{
    var config, mustReopen, view, enableEscapeHandle, __get__currentView, dispatchEvent, applyBtn, btnVivoxTestLabel, tabs, submitBtn, cancelBtn;
    static var pendingSettings;
    function SettingsDialog()
    {
        super();
        config = new net.wargaming.SettingsDialogConfig();
        mustReopen = true;
    } // End of the function
    static function show()
    {
        var _loc2 = net.wargaming.Dialog.show(_root, net.wargaming.SettingsDialog.settingsDialogSource, {}, true);
        return (_loc2);
    } // End of the function
    function get currentView()
    {
        return (view.currentView);
    } // End of the function
    function getReopenCallerObject()
    {
        return ({scope: net.wargaming.SettingsDialog, method: "show"});
    } // End of the function
    function handleInput(details, pathToFocus)
    {
        switch (details.navEquivalent)
        {
            case gfx.ui.NavigationCode.ESCAPE:
            {
                if (enableEscapeHandle && details.value == "keyDown")
                {
                    if ((this.__get__currentView().keys == null || !this.__get__currentView().keys.isSelected()) && (this.__get__currentView().KeyInputPTT == null || !this.__get__currentView().KeyInputPTT.selected))
                    {
                        this.cancelSettings();
                        this.dispatchEvent({type: "close"});
                    } // end if
                } // end if
                return (true);
            } 
        } // End of switch
        return (super.handleInput(details, pathToFocus));
    } // End of the function
    function buildGraphicsData(graficsData)
    {
        for (var _loc4 = 0; _loc4 < config.VIDEO_OPTIONS_CONFIG.length; ++_loc4)
        {
            var _loc2 = config.VIDEO_OPTIONS_CONFIG[_loc4];
            var _loc3 = graficsData[_loc2.key];
            if (_loc2.type == "DropDown")
            {
                net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = _loc2.isValueLabel ? (String(_loc3.current)) : (Number(_loc3.current));
                net.wargaming.SettingsDialog.defaultData[_loc2.key] = _loc3.real ? (_loc3.real) : (net.wargaming.SettingsDialog.viewData.settings[_loc2.key]);
                net.wargaming.SettingsDialog.viewData.options[_loc2.key] = _loc3.options;
                continue;
            } // end if
            if (_loc2.type == "Checkbox")
            {
                if (_loc2.combine)
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = Number(_loc3);
                }
                else if (_loc2.isInverse)
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = !Boolean(_loc3);
                }
                else
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = Boolean(_loc3);
                } // end else if
                net.wargaming.SettingsDialog.defaultData[_loc2.key] = _loc3.real ? (_loc3.real) : (net.wargaming.SettingsDialog.viewData.settings[_loc2.key]);
            } // end if
        } // end of for
        this.updateView();
    } // End of the function
    function buildData(qualitySettings, configData, keyboard, mouse)
    {
        isInited = false;
        net.wargaming.SettingsDialog.viewData.settings = new Object();
        net.wargaming.SettingsDialog.viewData.options = new Object();
        net.wargaming.SettingsDialog.viewData.presets = new Object();
        net.wargaming.SettingsDialog.viewData.settings.quality = new Object();
        for (var _loc10 in qualitySettings.quality)
        {
            net.wargaming.SettingsDialog.viewData.settings.quality[_loc10] = qualitySettings.quality[_loc10].value;
            net.wargaming.SettingsDialog.viewData.options[_loc10] = qualitySettings.quality[_loc10].options;
        } // end of for...in
        net.wargaming.SettingsDialog.viewData.settings.graphicsQuality = qualitySettings.presets.current;
        net.wargaming.SettingsDialog.viewData.options.graphicsQuality = new Array();
        var _loc9 = qualitySettings.presets.values.length;
        for (var _loc6 = 0; _loc6 < _loc9; ++_loc6)
        {
            var _loc5 = qualitySettings.presets.values[_loc6];
            net.wargaming.SettingsDialog.viewData.options.graphicsQuality.push("#settings:graphicsQuality/" + _loc5.key);
            net.wargaming.SettingsDialog.viewData.presets[_loc5.index] = _loc5.settings;
        } // end of for
        for (var _loc6 = 0; _loc6 < config.DATA_OPTIONS_CONFIG.length; ++_loc6)
        {
            var _loc2 = config.DATA_OPTIONS_CONFIG[_loc6];
            var _loc3 = configData[_loc2.key];
            if (_loc2.type == "DropDown")
            {
                net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = _loc2.isValueLabel ? (String(_loc3.current)) : (Number(_loc3.current));
                net.wargaming.SettingsDialog.viewData.options[_loc2.key] = _loc3.options;
                continue;
            } // end if
            if (_loc2.type == "Checkbox")
            {
                if (_loc2.combine)
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = Number(_loc3);
                }
                else if (_loc2.isInverse)
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = !Boolean(_loc3);
                }
                else
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = Boolean(_loc3);
                } // end else if
                continue;
            } // end if
            if (_loc2.type == "Slider")
            {
                net.wargaming.SettingsDialog.viewData.settings[_loc2.key] = Number(_loc3);
                continue;
            } // end if
            if (_loc2.type == "Cursor")
            {
                net.wargaming.SettingsDialog.viewData.settings.cursor = _loc3.values;
                for (var _loc8 in _loc3.options)
                {
                    net.wargaming.SettingsDialog.viewData.options[_loc8] = new Array();
                    for (var _loc4 = 0; _loc4 < _loc3.options[_loc8]; ++_loc4)
                    {
                        net.wargaming.SettingsDialog.viewData.options[_loc8].push("#settings:cursor/" + _loc8 + "/type" + _loc4);
                    } // end of for
                } // end of for...in
            } // end if
        } // end of for
        net.wargaming.SettingsDialog.viewData.settings.controls = {keyboard: [], mouse: {}};
        net.wargaming.SettingsDialog.viewData.settings.controls.keyboard = keyboard;
        net.wargaming.SettingsDialog.viewData.settings.controls.mouse = mouse;
        net.wargaming.SettingsDialog.setDefault();
        this.populatePendingSettings();
        this.populateView();
    } // End of the function
    static function setDefault()
    {
        defaultData = net.wargaming.utils.ObjectUtils.cloneObj(net.wargaming.SettingsDialog.viewData.settings);
    } // End of the function
    function applyCloseSettings(event)
    {
        if (!this.__checkControlsSettings())
        {
            isChanged = true;
            this.collectPendingSettings();
            var _loc2 = net.wargaming.notification.MessageDialog.show("controlsWrongNotification", true, true);
            _loc2.addEventListener("submit", net.wargaming.SettingsDialog, "onControlsWrongNotificationSubmit");
            _loc2.addEventListener("close", net.wargaming.SettingsDialog, "onControlsWrongNotificationClose");
        }
        else
        {
            this.onApplyClose(event);
        } // end else if
    } // End of the function
    static function onControlsWrongNotificationClose(args)
    {
        __currentPage = 3;
    } // End of the function
    function onApplyClose(args)
    {
        if (!this.applySettings(args))
        {
            return;
        } // end if
        this.cancelSettings();
        this.dispatchEvent({type: "close"});
    } // End of the function
    static function onControlsWrongNotificationSubmit(event)
    {
        __is_need_to_apply_settings = true;
    } // End of the function
    function cancelSettings(event)
    {
        net.wargaming.SettingsDialog.viewData.settings = new Object();
        net.wargaming.SettingsDialog.viewData.options = new Object();
        pendingSettings = null;
        defaultData = new Object();
        this.__checkVoiceTest();
        gfx.io.GameDelegate.call("SettingsDialog.useRedifineKeysMode", [false]);
    } // End of the function
    function collectPendingSettings()
    {
        if (isChanged)
        {
            pendingSettings = net.wargaming.utils.ObjectUtils.cloneObj(net.wargaming.SettingsDialog.viewData.settings);
        } // end if
    } // End of the function
    function populatePendingSettings()
    {
        if (net.wargaming.SettingsDialog.pendingSettings != null)
        {
            net.wargaming.SettingsDialog.viewData.settings = net.wargaming.utils.ObjectUtils.cloneObj(net.wargaming.SettingsDialog.pendingSettings);
            pendingSettings = null;
        } // end if
    } // End of the function
    function __checkControlsSettings()
    {
        for (var _loc2 = 0; _loc2 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard.length; ++_loc2)
        {
            for (var _loc1 = 0; _loc1 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc2].commands.length; ++_loc1)
            {
                if (net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc2].commands[_loc1].key == 0)
                {
                    return (false);
                } // end if
            } // end of for
        } // end of for
        return (true);
    } // End of the function
    function applySettings(event)
    {
        if (isChanged && net.wargaming.SettingsDialog.viewData.settings.graphicsQuality != undefined)
        {
            net.wargaming.SettingsDialog.setDefault();
            applyBtn.__set__disabled(true);
            var _loc2 = [net.wargaming.SettingsDialog.viewData.settings.monitor, net.wargaming.SettingsDialog.viewData.settings.graphicsQuality, net.wargaming.SettingsDialog.viewData.settings.quality];
            this.collectPendingSettings();
            net.wargaming.io.GameDelegateNice.call("SettingsDialog.ApplySettings", [_loc2]);
        } // end if
        return (true);
    } // End of the function
    static function confirmApplySettings()
    {
        var _loc2 = String(arguments.shift());
        if (_loc2 == "restartNeeded")
        {
            var _loc3 = net.wargaming.notification.DelayedMessageDialog.show("graphicsPresetRestartConfirmation", true);
            _loc3.addEventListener("submit", net.wargaming.SettingsDialog, "commitSettings");
            _loc3.addEventListener("delay", net.wargaming.SettingsDialog, "delaySettings");
            _loc3.addEventListener("close", net.wargaming.SettingsDialog, "clearPendingSettings");
        }
        else if (_loc2 == "hasPendingSettings")
        {
            _loc3 = net.wargaming.notification.MessageDialog.show("graphicsPresetDelayedConfirmation", true);
            _loc3.addEventListener("submit", net.wargaming.SettingsDialog, "commitSettings");
            _loc3.addEventListener("close", net.wargaming.SettingsDialog, "clearPendingSettings");
        }
        else
        {
            net.wargaming.SettingsDialog.commitSettings({});
        } // end else if
    } // End of the function
    static function clearPendingSettings(event)
    {
        pendingSettings = null;
    } // End of the function
    static function commitSettings(event)
    {
        if (net.wargaming.SettingsDialog.pendingSettings != null)
        {
            net.wargaming.io.GameDelegateNice.call("SettingsDialog.CommitSettings", [net.wargaming.SettingsDialog.pendingSettings]);
            net.wargaming.SettingsDialog.setDefault();
            net.wargaming.SettingsDialog.clearPendingSettings(event);
        } // end if
    } // End of the function
    static function delaySettings(event)
    {
        if (net.wargaming.SettingsDialog.pendingSettings != null)
        {
            net.wargaming.io.GameDelegateNice.call("SettingsDialog.DelaySettings", [net.wargaming.SettingsDialog.pendingSettings]);
            net.wargaming.SettingsDialog.setDefault();
            net.wargaming.SettingsDialog.clearPendingSettings(event);
        } // end if
    } // End of the function
    function autodetectQuality(event)
    {
        this.__get__currentView().autodetectQuality.disabled = true;
        setTimeout(function ()
        {
            gfx.io.GameDelegate.call("SettingsDialog.AutodetectQuality", []);
        }, 10);
    } // End of the function
    function onVoiceChatEnabledSelect(args)
    {
        if (args)
        {
            this.handleChange(args);
        } // end if
        this.__checkVoiceTest();
        var _loc2 = !this.__get__currentView().enableVoIPCheckbox.selected || net.wargaming.SettingsDialog.viewData.settings.voiceChatNotSupported;
        if (this.__get__currentView().captureDeviceDropDown != null)
        {
            this.__get__currentView().captureDeviceDropDown.disabled = _loc2;
        } // end if
        if (this.__get__currentView().micVivoxVolume != null)
        {
            this.__get__currentView().micVivoxVolume.disabled = _loc2;
        } // end if
        if (this.__get__currentView().btnVivoxTest != null)
        {
            this.__get__currentView().btnVivoxTest.disabled = _loc2;
        } // end if
        if (this.__get__currentView().btnCaptureDevicesUpdate != null)
        {
            this.__get__currentView().btnCaptureDevicesUpdate.disabled = _loc2;
        } // end if
        if (this.__get__currentView().masterVivoxVolume != null)
        {
            this.__get__currentView().masterVivoxVolume.disabled = _loc2;
        } // end if
        if (this.__get__currentView().masterFadeVivoxVolume != null)
        {
            this.__get__currentView().masterFadeVivoxVolume.disabled = _loc2;
        } // end if
        if (this.__get__currentView().captureDeviceDropDown.dataProvider.length == 0)
        {
            this.__get__currentView().captureDeviceDropDown.disabled = this.__get__currentView().micVivoxVolume.disabled = this.__get__currentView().btnVivoxTest.disabled = true;
        } // end if
        gfx.io.GameDelegate.call("SettingsDialog.voiceChatEnable", [this.__get__currentView().enableVoIPCheckbox.selected]);
    } // End of the function
    function showPTTTooltip(args)
    {
        net.wargaming.managers.ToolTipManager.showComplex("#tooltips:settings_dialog/sound/PTTKey");
    } // End of the function
    function hideTooltip(args)
    {
        net.wargaming.managers.ToolTipManager.hide();
    } // End of the function
    function updateView()
    {
        if (net.wargaming.SettingsDialog.viewData.settings == null || this.__get__currentView() == null)
        {
            return;
        } // end if
        var _loc10 = this.__get__currentView();
        for (var _loc5 = 0; _loc5 < config.VIDEO_OPTIONS_CONFIG.length; ++_loc5)
        {
            var _loc2 = config.__get__OPTIONS_CONFIG()[_loc5];
            if (!config.isOptionValid(_loc2, net.wargaming.SettingsDialog.viewData.settings))
            {
                continue;
            } // end if
            var _loc8 = config.getOptionGUIKey(_loc2);
            var _loc9 = config.getOptionGUILabelKey(_loc2);
            var _loc3 = _loc10[_loc8];
            var _loc6 = _loc10[_loc9];
            if (_loc6)
            {
                _loc6.text = "#settings:" + _loc2.key;
            } // end if
            if (_loc3)
            {
                var _loc4 = _loc2.eventListener ? (_loc2.eventListener) : ("handleChange");
                if (_loc2.type == "DropDown")
                {
                    _loc3.removeEventListener(gfx.events.EventTypes.CHANGE, this, _loc4);
                    var _loc7 = net.wargaming.SettingsDialog.viewData.options[_loc2.key];
                    if (_loc2.optionsDepends != null)
                    {
                        _loc7 = net.wargaming.SettingsDialog.viewData.options[_loc2.key][net.wargaming.SettingsDialog.viewData.settings[_loc2.optionsDepends]];
                    } // end if
                    _loc3.dataProvider = _loc7;
                    _loc3.selectedIndex = Math.min(net.wargaming.SettingsDialog.viewData.settings[_loc2.key], _loc3.dataProvider.length - 1);
                    _loc3.addEventListener(gfx.events.EventTypes.CHANGE, this, _loc4);
                    if (_loc2.isDisabled)
                    {
                        _loc3.disabled = _loc2.isDisabled(net.wargaming.SettingsDialog.viewData.settings);
                    } // end if
                    continue;
                } // end if
                if (_loc2.type == "Checkbox")
                {
                    _loc3.selected = net.wargaming.SettingsDialog.viewData.settings[_loc2.key];
                    _loc3.removeEventListener(gfx.events.EventTypes.SELECT, this, _loc4);
                    _loc3.addEventListener(gfx.events.EventTypes.SELECT, this, _loc4);
                } // end if
            } // end if
        } // end of for
        this.handleChange();
    } // End of the function
    function populateView()
    {
        if (net.wargaming.SettingsDialog.viewData.settings == null || this.__get__currentView() == null)
        {
            return;
        } // end if
        var _loc2 = this.__get__currentView();
        if (_loc2.graphicsQualityDropDown != null)
        {
            _loc2.graphicsQualityDropDown.removeEventListener(gfx.events.EventTypes.CHANGE, this, "handleChangeQualityPreset");
            if (net.wargaming.SettingsDialog.viewData.settings.graphicsQuality != net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1)
            {
                _loc2.graphicsQualityDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.slice(0, net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1);
            }
            else
            {
                _loc2.graphicsQualityDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.graphicsQuality;
            } // end else if
            _loc2.graphicsQualityDropDown.rowCount = _loc2.graphicsQualityDropDown.dataProvider.length;
            _loc2.graphicsQualityDropDown.selectedIndex = net.wargaming.SettingsDialog.viewData.settings.graphicsQuality;
            _loc2.graphicsQualityDropDown.addEventListener(gfx.events.EventTypes.CHANGE, this, "handleChangeQualityPreset");
        } // end if
        if (_loc2.autodetectQuality != null)
        {
            _loc2.autodetectQuality.addEventListener(gfx.events.EventTypes.PRESS, this, "autodetectQuality");
        } // end if
        for (var _loc13 in net.wargaming.SettingsDialog.viewData.settings.quality)
        {
            if (_loc2[_loc13 + "DropDown"] != null)
            {
                _loc2[_loc13 + "DropDown"].removeEventListener(gfx.events.EventTypes.CHANGE, this, "handleChangeQuality");
                _loc2[_loc13 + "Label"].text = "#settings:" + _loc13;
                _loc2[_loc13 + "DropDown"].dataProvider = net.wargaming.SettingsDialog.viewData.options[_loc13];
                _loc2[_loc13 + "DropDown"].selectedIndex = net.wargaming.SettingsDialog.viewData.settings.quality[_loc13];
                _loc2[_loc13 + "DropDown"].addEventListener(gfx.events.EventTypes.CHANGE, this, "handleChangeQuality");
            } // end if
            if (_loc2[_loc13 + "CheckBox"] != null)
            {
                _loc2[_loc13 + "CheckBox"].removeEventListener(gfx.events.EventTypes.SELECT, this, "handleChangeQuality");
                _loc2[_loc13 + "CheckBox"].label = "#settings:" + _loc13;
                _loc2[_loc13 + "CheckBox"].selected = net.wargaming.SettingsDialog.viewData.settings.quality[_loc13];
                _loc2[_loc13 + "CheckBox"].addEventListener(gfx.events.EventTypes.SELECT, this, "handleChangeQuality");
            } // end if
        } // end of for...in
        if (!net.wargaming.SettingsDialog.viewData.settings.isMRTSupported && this.__get__currentView().MRT_DEPTHDropDown != null)
        {
            this.__get__currentView().MRT_DEPTHDropDown.disabled = true;
        } // end if
        for (var _loc6 = 0; _loc6 < config.__get__OPTIONS_CONFIG().length; ++_loc6)
        {
            var _loc3 = config.__get__OPTIONS_CONFIG()[_loc6];
            if (!config.isOptionValid(_loc3, net.wargaming.SettingsDialog.viewData.settings))
            {
                continue;
            } // end if
            var _loc9 = config.getOptionGUIKey(_loc3);
            var _loc22 = config.getOptionGUILabelKey(_loc3);
            var _loc5 = _loc2[_loc9];
            var _loc15 = _loc2[_loc22];
            if (_loc15)
            {
                _loc15.text = "#settings:" + _loc3.key;
            } // end if
            if (_loc5)
            {
                var _loc8 = _loc3.eventListener ? (_loc3.eventListener) : ("handleChange");
                if (_loc3.type == "DropDown")
                {
                    _loc5.removeEventListener(gfx.events.EventTypes.CHANGE, this, _loc8);
                    _loc5.dataProvider = net.wargaming.SettingsDialog.viewData.options[_loc3.key];
                    if (_loc3.isValueLabel)
                    {
                        for (var _loc4 = 0; _loc4 < net.wargaming.SettingsDialog.viewData.options[_loc3.key].length; ++_loc4)
                        {
                            if (net.wargaming.SettingsDialog.viewData.options[_loc3.key][_loc4] == net.wargaming.SettingsDialog.viewData.settings[_loc3.key])
                            {
                                _loc5.selectedIndex = _loc4;
                                break;
                            } // end if
                        } // end of for
                    }
                    else
                    {
                        _loc5.selectedIndex = net.wargaming.SettingsDialog.viewData.settings[_loc3.key];
                    } // end else if
                    _loc5.addEventListener(gfx.events.EventTypes.CHANGE, this, _loc8);
                }
                else if (_loc3.type == "Checkbox")
                {
                    _loc5.removeEventListener(gfx.events.EventTypes.SELECT, this, _loc8);
                    _loc5.selected = net.wargaming.SettingsDialog.viewData.settings[_loc3.key];
                    _loc5.addEventListener(gfx.events.EventTypes.SELECT, this, _loc8);
                }
                else if (_loc3.type == "Slider")
                {
                    _loc5.removeEventListener(gfx.events.EventTypes.CHANGE, this, _loc8);
                    _loc5.value = net.wargaming.SettingsDialog.viewData.settings[_loc3.key];
                    var _loc17 = _loc2[_loc9 + "Value"];
                    if (_loc17)
                    {
                        _loc17.text = Math.round(net.wargaming.SettingsDialog.viewData.settings[_loc3.key]);
                    } // end if
                    _loc5.addEventListener(gfx.events.EventTypes.CHANGE, this, _loc8);
                } // end else if
                if (_loc3.isDisabled)
                {
                    if (_loc3.type == "Slider")
                    {
                        _loc5.undefinedDisabled = _loc3.isDisabled(net.wargaming.SettingsDialog.viewData.settings);
                        continue;
                    } // end if
                    _loc5.disabled = _loc3.isDisabled(net.wargaming.SettingsDialog.viewData.settings);
                } // end if
            } // end if
        } // end of for
        if (_loc2.btnVivoxTest != null)
        {
            _loc2.btnVivoxTest.addEventListener(gfx.events.EventTypes.CLICK, this, "onVoiceTestProcess");
        } // end if
        if (_loc2.btnCaptureDevicesUpdate != null)
        {
            _loc2.btnCaptureDevicesUpdate.addEventListener(gfx.events.EventTypes.CLICK, this, "onCaptureDevicesBtnClick");
        } // end if
        if (_loc2.KeyInputPTT != null)
        {
            _loc2.KeyInputPTT.addEventListener("rollOverDisabled", this, "showPTTTooltip");
            _loc2.KeyInputPTT.addEventListener("rollOutDisabled", this, "hideTooltip");
            this.__checkVoiceButton();
        } // end if
        if (_loc2.showDateMessageCheckbox != null)
        {
            _loc2.showDateMessageCheckbox.selected = (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 1) != 0;
            _loc2.showDateMessageCheckbox.addEventListener(gfx.events.EventTypes.CLICK, this, "handleChange");
        } // end if
        if (_loc2.showTimeMessageCheckbox != null)
        {
            _loc2.showTimeMessageCheckbox.selected = (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 2) != 0;
            _loc2.showTimeMessageCheckbox.addEventListener(gfx.events.EventTypes.CLICK, this, "handleChange");
        } // end if
        var _loc24 = net.wargaming.SettingsDialog.viewData.settings.vibroIsConnected;
        if (_loc2.vibroDeviceConnectionStateField != null)
        {
            _loc2.vibroDeviceConnectionStateField.text = _loc24 ? ("#settings:vibro/device/state/connected") : ("#settings:vibro/device/state/notConnected");
        } // end if
        for (var _loc11 in net.wargaming.SettingsDialog.viewData.settings.cursor)
        {
            if (_loc2[_loc11] != null)
            {
                _loc2[_loc11 + "Label"].text = "#settings:cursor/" + _loc11;
                _loc2[_loc11].value = net.wargaming.SettingsDialog.viewData.settings.cursor[_loc11].alpha;
                _loc2[_loc11 + "Value"].text = Math.round(net.wargaming.SettingsDialog.viewData.settings.cursor[_loc11].alpha);
                _loc2[_loc11].addEventListener(gfx.events.EventTypes.CHANGE, this, "handleChange");
                if (_loc2[_loc11 + "Type"] != null)
                {
                    _loc2[_loc11 + "Type"].dataProvider = net.wargaming.SettingsDialog.viewData.options[_loc11];
                    _loc2[_loc11 + "Type"].rowCount = net.wargaming.SettingsDialog.viewData.options[_loc11].length;
                    _loc2[_loc11 + "Type"].selectedIndex = net.wargaming.SettingsDialog.viewData.settings.cursor[_loc11].type;
                    _loc2[_loc11 + "Type"].addEventListener(gfx.events.EventTypes.CHANGE, this, "handleChange");
                } // end if
                _loc2.setCursor(net.wargaming.SettingsDialog.viewData.settings.cursor);
            } // end if
        } // end of for...in
        if (_loc2.keys != null)
        {
            var _loc20 = new Array();
            _loc2.keys.addEventListener("itemTextChange", this, "handleChange");
            for (var _loc6 = 0; _loc6 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard.length; ++_loc6)
            {
                var _loc21 = net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].id;
                _loc20.push({header: true, label: "#settings:keyboard/keysBlocks/group/" + _loc21});
                for (var _loc4 = 0; _loc4 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].commands.length; ++_loc4)
                {
                    var _loc7 = net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].commands[_loc4].id;
                    _loc20.push({id: {group_idx: _loc6, command_idx: _loc4}, label: "#settings:keyboard/keysBlocks/command/" + _loc7, command: net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].commands[_loc4].command, key: net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].commands[_loc4].key, keyDefault: net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc6].commands[_loc4].keyDefault, keys: config.KEY_RANGE[_loc7]});
                } // end of for
            } // end of for
            _loc2.keys.dataProvider = _loc20;
        } // end if
        if (_loc2.defaultBtn)
        {
            _loc2.defaultBtn.addEventListener("click", this, "setControlsDefaults");
        } // end if
        if (_loc2.sens_arcade != null)
        {
            _loc2.sens_arcade.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.arcadeSens.value;
            _loc2.sens_arcade.addEventListener("change", this, "handleChange");
        } // end if
        if (_loc2.sens_sniper != null)
        {
            _loc2.sens_sniper.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.sniperSens.value;
            _loc2.sens_sniper.addEventListener("change", this, "handleChange");
        } // end if
        if (_loc2.sens_art != null)
        {
            _loc2.sens_art.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.artSens.value;
            _loc2.sens_art.addEventListener("change", this, "handleChange");
        } // end if
        if (_loc2.mouse_hor_invert != null)
        {
            _loc2.mouse_hor_invert.selected = Boolean(net.wargaming.SettingsDialog.viewData.settings.controls.mouse.horInvert.value);
            _loc2.mouse_hor_invert.addEventListener("select", this, "handleChange");
        } // end if
        if (_loc2.mouse_vert_invert != null)
        {
            _loc2.mouse_vert_invert.selected = Boolean(net.wargaming.SettingsDialog.viewData.settings.controls.mouse.vertInvert.value);
            _loc2.mouse_vert_invert.addEventListener("select", this, "handleChange");
        } // end if
        this.proccessMRT_DEPTH();
        this.proccessFLORA_DENSITY();
        this.onVoiceChatEnabledSelect();
        isInited = true;
        this.handleChange();
        if (net.wargaming.SettingsDialog.__is_need_to_apply_settings)
        {
            __is_need_to_apply_settings = false;
            this.onApplyClose({});
        } // end if
    } // End of the function
    function setVivoxMicVolume(args)
    {
        this.handleChange(args);
        if (isVoiceTestStarted)
        {
            gfx.io.GameDelegate.call("SettingsDialog.setVivoxMicVolume", [this.__get__currentView().micVivoxVolumeSlider.value]);
        } // end if
    } // End of the function
    function onVoiceTestProcess(args)
    {
        this.__setVoiceTestState(!isVoiceTestStarted);
        this.__get__currentView().voiceAnimation.speak(isVoiceTestStarted);
        gfx.io.GameDelegate.call("SettingsDialog.processVivoxTest", [isVoiceTestStarted], this, "onVoiceTestResponse");
    } // End of the function
    function __setVoiceTestState(isStarted)
    {
        isVoiceTestStarted = isStarted;
        this.__get__currentView().btnVivoxTest.disabled = this.__get__currentView().btnCaptureDevicesUpdate.disabled = isStarted;
        if (isStarted)
        {
            voiceTestTimoutID = setTimeout(function (target)
            {
                target.onVoiceTestProcess();
            }, net.wargaming.SettingsDialog.UNCHECK_VOICE_TEST_BTN_TIMEOUT, this);
            voiceTestTimerID = setInterval(function (target)
            {
                if (target.btnVivoxTestLabel == null)
                {
                    target.btnVivoxTestLabel = net.wargaming.SettingsDialog.UNCHECK_VOICE_TEST_BTN_TIMEOUT;
                } // end if
                target.btnVivoxTestLabel = target.btnVivoxTestLabel - 100;
                if (target.currentView.btnVivoxTest != null)
                {
                    var _loc2 = String(target.btnVivoxTestLabel / 1000);
                    if (_loc2.length == 1)
                    {
                        _loc2 = _loc2 + ".0";
                    } // end if
                    target.currentView.voiceAnimationText.text = _loc2;
                } // end if
            }, 100, this);
        }
        else
        {
            this.__get__currentView().voiceAnimationText.text = "";
            btnVivoxTestLabel = null;
            clearTimeout(voiceTestTimoutID);
            clearInterval(voiceTestTimerID);
        } // end else if
    } // End of the function
    function onVoiceTestResponse()
    {
        if (Boolean(arguments.shift()))
        {
            this.__setVoiceTestState(false);
        } // end if
    } // End of the function
    function __checkVoiceTest()
    {
        if (isVoiceTestStarted)
        {
            this.onVoiceTestProcess();
        } // end if
    } // End of the function
    function setControlsDefaults(args)
    {
        for (var _loc2 = 0; _loc2 < this.__get__currentView().keys.dataProvider.length; ++_loc2)
        {
            this.__get__currentView().keys.dataProvider[_loc2].key = this.__get__currentView().keys.dataProvider[_loc2].keyDefault;
        } // end of for
        for (var _loc2 = 0; _loc2 < this.__get__currentView().keys.renderers.length; ++_loc2)
        {
            if (!this.__get__currentView().keys.renderers[_loc2].header)
            {
                this.__get__currentView().keys.renderers[_loc2].keyInput.restoreDefault();
            } // end if
        } // end of for
        this.__get__currentView().sens_arcade.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.arcadeSens.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.arcadeSens.defaultValue;
        this.__get__currentView().sens_sniper.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.sniperSens.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.sniperSens.defaultValue;
        this.__get__currentView().sens_art.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.artSens.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.artSens.defaultValue;
        this.__get__currentView().mouse_hor_invert.selected = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.horInvert.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.horInvert.defaultValue;
        this.__get__currentView().mouse_vert_invert.selected = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.vertInvert.value = net.wargaming.SettingsDialog.viewData.settings.controls.mouse.vertInvert.defaultValue;
        this.handleChange();
    } // End of the function
    function __checkVoiceButton(args)
    {
        for (var _loc3 = 0; _loc3 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard.length; ++_loc3)
        {
            var _loc5 = net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].id;
            for (var _loc2 = 0; _loc2 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].commands.length; ++_loc2)
            {
                var _loc4 = net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].commands[_loc2].id;
                if (_loc4 == "pushToTalk" && this.__get__currentView().KeyInputPTT != null)
                {
                    this.__get__currentView().KeyInputPTT.key = net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].commands[_loc2].key;
                    break;
                } // end if
            } // end of for
        } // end of for
    } // End of the function
    function onTabsChanged(args)
    {
        __currentPage = tabs.selectedIndex;
    } // End of the function
    function viewLoaded()
    {
        isInited = false;
        this.populateView();
        this.updateView();
    } // End of the function
    function populateUI()
    {
        if (tabs != null)
        {
            tabs.__set__dataProvider([{label: "#settings:gameTitle", data: "GameSettings"}, {label: "#settings:graficTitle", data: "GraficSettings"}, {label: "#settings:soundTitle", data: "SoundSettings"}, {label: "#settings:keyboardTitle", data: "ControlsSettings"}, {label: "#settings:cursorTitle", data: "CursorSettings"}]);
            tabs.__set__selectedIndex(net.wargaming.SettingsDialog.__currentPage);
            tabs.addEventListener(gfx.events.EventTypes.CHANGE, this, "__checkVoiceTest");
            tabs.addEventListener(gfx.events.EventTypes.CHANGE, this, "onTabsChanged");
        } // end if
        if (submitBtn != null)
        {
            submitBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "applyCloseSettings");
            submitBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "__checkVoiceTest");
        } // end if
        if (cancelBtn != null)
        {
            cancelBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "cancelSettings");
            cancelBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "__checkVoiceTest");
        } // end if
        if (applyBtn != null)
        {
            applyBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "applySettings");
            applyBtn.addEventListener(gfx.events.EventTypes.PRESS, this, "__checkVoiceTest");
        } // end if
        net.wargaming.io.GameDelegateNice.addCallBack("SettingsDialog.PopulateVideo", this, "buildGraphicsData");
        net.wargaming.io.GameDelegateNice.addCallBack("SettingsDialog.PopulateUI", this, "buildData");
        gfx.io.GameDelegate.addCallBack("SettingsDialog.updateCaptureDevices", this, "onUpdateCaptureDevices");
        gfx.io.GameDelegate.addCallBack("SettingsDialog.setPreset", this, "setPreset");
        gfx.io.GameDelegate.addCallBack("SettingsDialog.ApplySettings", net.wargaming.SettingsDialog, "confirmApplySettings");
        gfx.io.GameDelegate.addCallBack("SettingsDialog.VibroManager.Connect", this, "onVibroManagerConnect");
        gfx.io.GameDelegate.addCallBack("SettingsDialog.VibroManager.Disconnect", this, "onVibroManagerDisconnect");
        gfx.io.GameDelegate.call("SettingsDialog.PopulateUI", []);
        gfx.io.GameDelegate.call("SettingsDialog.useRedifineKeysMode", [true]);
        if (config.isDebug)
        {
            buildData.call(this, config.debugData);
            buildGraphicsData.call(this, config.debugVideo);
        } // end if
    } // End of the function
    function onUpdateCaptureDevices()
    {
        var _loc4 = String(arguments.shift());
        this.__get__currentView().captureDeviceDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.captureDevice = arguments;
        net.wargaming.SettingsDialog.viewData.settings.captureDevice = _loc4;
        this.__get__currentView().captureDeviceDropDown.selectedIndex = -1;
        for (var _loc3 = 0; _loc3 < this.__get__currentView().captureDeviceDropDown.dataProvider.length; ++_loc3)
        {
            if (net.wargaming.SettingsDialog.viewData.settings.captureDevice == this.__get__currentView().captureDeviceDropDown.dataProvider[_loc3])
            {
                this.__get__currentView().captureDeviceDropDown.selectedIndex = _loc3;
                break;
            } // end if
        } // end of for
        this.onVoiceChatEnabledSelect();
    } // End of the function
    function setPreset(presetIndex)
    {
        if (this.__get__currentView().graphicsQualityDropDown)
        {
            this.__get__currentView().graphicsQualityDropDown.selectedIndex = presetIndex;
        } // end if
        this.__get__currentView().autodetectQuality.disabled = false;
    } // End of the function
    function onCaptureDevicesBtnClick(args)
    {
        gfx.io.GameDelegate.call("SettingsDialog.updateCaptureDevices", []);
    } // End of the function
    function onVibroManagerConnect()
    {
        this.doVibroManagerConnect(true);
    } // End of the function
    function onVibroManagerDisconnect()
    {
        this.doVibroManagerConnect(false);
    } // End of the function
    function doVibroManagerConnect(isOn)
    {
        net.wargaming.SettingsDialog.viewData.settings.vibroIsConnected = isOn;
        var _loc2 = this.__get__currentView();
        if (_loc2.vibroDeviceConnectionStateField != null)
        {
            if (isOn)
            {
                _loc2.vibroDeviceConnectionStateField.text = "#settings:vibro/device/state/connected";
            }
            else
            {
                _loc2.vibroDeviceConnectionStateField.text = "#settings:vibro/device/state/notConnected";
            } // end if
        } // end else if
        if (_loc2.vibroGainSlider != null)
        {
            _loc2.vibroGainSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroEngineSlider != null)
        {
            _loc2.vibroEngineSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroAccelerationSlider != null)
        {
            _loc2.vibroAccelerationSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroShotsSlider != null)
        {
            _loc2.vibroShotsSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroHitsSlider != null)
        {
            _loc2.vibroHitsSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroCollisionsSlider != null)
        {
            _loc2.vibroCollisionsSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroDamageSlider != null)
        {
            _loc2.vibroDamageSlider.undefinedDisabled = !isOn;
        } // end if
        if (_loc2.vibroGUISlider != null)
        {
            _loc2.vibroGUISlider.undefinedDisabled = !isOn;
        } // end if
    } // End of the function
    function handleClickFullScreenCheckbox(event)
    {
        if (this.__get__currentView().fullScreenCheckbox != null && isInited)
        {
            if (this.__get__currentView().sizesLabel != null)
            {
                this.__get__currentView().sizesLabel.text = event.selected ? ("#settings:resolution") : ("#settings:windowSize");
            } // end if
            if (event.selected)
            {
                net.wargaming.SettingsDialog.viewData.settings.windowSize = this.__get__currentView().sizesDropDown.selectedIndex;
            }
            else
            {
                net.wargaming.SettingsDialog.viewData.settings.resolution = this.__get__currentView().sizesDropDown.selectedIndex;
            } // end else if
            this.handleMonitorChange(event);
            if (this.__get__currentView().aspectRatioDropDown != null)
            {
                this.__get__currentView().aspectRatioDropDown.disabled = !event.selected;
            } // end if
            if (this.__get__currentView().gammaSlider != null)
            {
                this.__get__currentView().gammaSlider.undefinedDisabled = !event.selected;
            } // end if
        } // end if
    } // End of the function
    function handleMonitorChange(event)
    {
        this.handleChange(event);
        this.updateView();
    } // End of the function
    function proccessMRT_DEPTH(event)
    {
        var _loc2 = this.__get__currentView().MRT_DEPTHDropDown.selectedIndex == 0 && net.wargaming.SettingsDialog.viewData.settings.isMRTSupported;
        this.__get__currentView().multisamplingDropDown.visible = !_loc2;
        this.__get__currentView().customAADropDown.visible = _loc2;
        if (!_loc2)
        {
            if (this.__get__currentView().WATER_QUALITYDropDown.selectedIndex == 0)
            {
                setTimeout(this.showHightWaterDialog, 30);
            } // end if
        } // end if
        this.proccessShadows();
    } // End of the function
    function proccessShadows()
    {
        var _loc2 = this.__get__currentView().WG_SHADOWS_QUALITYDropDown.selectedIndex == 2 || this.__get__currentView().WG_SHADOWS_QUALITYDropDown.disabled;
        this.__get__currentView().SHADOWS_QUALITYDropDown.disabled = !_loc2;
    } // End of the function
    function proccessFLORA_DENSITY()
    {
        var _loc2 = this.__get__currentView().FLORA_DENSITYDropDown.selectedIndex == 4 || this.__get__currentView().FLORA_DENSITYDropDown.disabled;
        this.__get__currentView().SNIPER_MODE_GRASS_ENABLEDCheckBox.disabled = _loc2;
    } // End of the function
    function showHightTextureDialog()
    {
        this.__get__currentView().TEXTURE_QUALITYDropDown.selectedIndex = 1;
        net.wargaming.SettingsDialog.viewData.settings.quality.TEXTURE_QUALITY = 1;
        this.collectPendingSettings();
        var _loc2 = net.wargaming.notification.MessageDialog.show("graphicsPresetNotPossible", false, false);
    } // End of the function
    function showHightWaterDialog()
    {
        if (this.__get__currentView().WATER_QUALITYDropDown.selectedIndex != 0 || this.__get__currentView().MRT_DEPTHDropDown.selectedIndex == 0 && net.wargaming.SettingsDialog.viewData.settings.isMRTSupported)
        {
            return;
        } // end if
        this.__get__currentView().WATER_QUALITYDropDown.selectedIndex = 1;
        net.wargaming.SettingsDialog.viewData.settings.quality.WATER_QUALITY = 1;
        this.collectPendingSettings();
        var _loc2 = net.wargaming.notification.MessageDialog.show("waterQualityNotPossible", false, false);
    } // End of the function
    function handleChangeQuality(event)
    {
        if (event.target == this.__get__currentView().TEXTURE_QUALITYDropDown && isInited && !net.wargaming.SettingsDialog.viewData.settings.isApplyHighQualityPossible && event.target.selectedIndex == 0)
        {
            setTimeout(this.showHightTextureDialog, 10);
        } // end if
        if (event.target == this.__get__currentView().WATER_QUALITYDropDown && isInited && event.target.selectedIndex == 0)
        {
            this.proccessMRT_DEPTH();
        } // end if
        if (event.target == this.__get__currentView().MRT_DEPTHDropDown)
        {
            this.proccessMRT_DEPTH();
        } // end if
        if (event.target == this.__get__currentView().WG_SHADOWS_QUALITYDropDown)
        {
            this.proccessShadows();
        } // end if
        if (event.target == this.__get__currentView().FLORA_DENSITYDropDown)
        {
            this.proccessFLORA_DENSITY();
        } // end if
        this.handleChange(event);
        if (event.target.disabled)
        {
            return;
        } // end if
        var _loc5 = true;
        this.__get__currentView().graphicsQualityDropDown.disabled = true;
        this.__get__currentView().graphicsQualityDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.graphicsQuality;
        this.__get__currentView().graphicsQualityDropDown.rowCount = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length;
        for (var _loc6 in net.wargaming.SettingsDialog.viewData.presets)
        {
            var _loc2 = _loc6 != net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1;
            for (var _loc3 in net.wargaming.SettingsDialog.viewData.presets[_loc6])
            {
                if (!this.__get__currentView()[_loc3].disabled && net.wargaming.SettingsDialog.viewData.presets[_loc6][_loc3] != net.wargaming.SettingsDialog.viewData.settings.quality[_loc3])
                {
                    _loc2 = false;
                    break;
                } // end if
            } // end of for...in
            if (_loc2)
            {
                _loc5 = false;
                this.__get__currentView().graphicsQualityDropDown.selectedIndex = _loc6;
                break;
            } // end if
        } // end of for...in
        if (_loc5)
        {
            this.__get__currentView().graphicsQualityDropDown.selectedIndex = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1;
        }
        else
        {
            var _loc7 = this.__get__currentView().graphicsQualityDropDown.selectedIndex;
            this.__get__currentView().graphicsQualityDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.slice(0, net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1);
            this.__get__currentView().graphicsQualityDropDown.rowCount = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1;
            this.__get__currentView().graphicsQualityDropDown.selectedIndex = _loc7;
        } // end else if
        this.__get__currentView().graphicsQualityDropDown.disabled = false;
    } // End of the function
    function handleChangeQualityPreset(event)
    {
        this.handleChange(event);
        if (event.target.disabled)
        {
            return;
        } // end if
        this.__get__currentView().graphicsQualityDropDown.disabled = true;
        if (this.__get__currentView().graphicsQualityDropDown.selectedIndex != net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1)
        {
            var _loc5 = this.__get__currentView().graphicsQualityDropDown.selectedIndex;
            this.__get__currentView().graphicsQualityDropDown.dataProvider = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.slice(0, net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1);
            this.__get__currentView().graphicsQualityDropDown.rowCount = net.wargaming.SettingsDialog.viewData.options.graphicsQuality.length - 1;
            this.__get__currentView().graphicsQualityDropDown.selectedIndex = _loc5;
        } // end if
        this.__get__currentView().graphicsQualityDropDown.disabled = false;
        var _loc2 = net.wargaming.SettingsDialog.viewData.presets[this.__get__currentView().graphicsQualityDropDown.selectedIndex];
        for (var _loc4 in _loc2)
        {
            if (this.__get__currentView()[_loc4 + "DropDown"] && !this.__get__currentView()[_loc4 + "DropDown"].disabled)
            {
                var _loc3 = this.__get__currentView()[_loc4 + "DropDown"].disabled;
                this.__get__currentView()[_loc4 + "DropDown"].disabled = true;
                this.__get__currentView()[_loc4 + "DropDown"].selectedIndex = _loc2[_loc4];
                this.__get__currentView()[_loc4 + "DropDown"].disabled = _loc3;
                continue;
            } // end if
            if (this.__get__currentView()[_loc4 + "CheckBox"])
            {
                _loc3 = this.__get__currentView()[_loc4 + "CheckBox"].disabled;
                this.__get__currentView()[_loc4 + "CheckBox"].disabled = true;
                this.__get__currentView()[_loc4 + "CheckBox"].selected = _loc2[_loc4];
                this.__get__currentView()[_loc4 + "CheckBox"].disabled = _loc3;
                continue;
            } // end if
            if (net.wargaming.SettingsDialog.viewData.settings.quality.hasOwnProperty(_loc4))
            {
            } // end if
        } // end of for...in
        this.proccessFLORA_DENSITY();
    } // End of the function
    function handleChange(event)
    {
        isChanged = this.updateViewData(event);
        if (applyBtn != null)
        {
            applyBtn.__set__disabled(!isChanged);
        } // end if
    } // End of the function
    function updateViewData(event)
    {
        if (!isInited)
        {
            return (false);
        } // end if
        var _loc4 = this.__get__currentView();
        for (var _loc3 = 0; _loc3 < config.__get__OPTIONS_CONFIG().length; ++_loc3)
        {
            var _loc5 = config.__get__OPTIONS_CONFIG()[_loc3];
            if (!config.isOptionValid(_loc5, net.wargaming.SettingsDialog.viewData.settings))
            {
                continue;
            } // end if
            var _loc8 = config.getOptionGUIKey(_loc5);
            var _loc6 = _loc4[_loc8];
            if (_loc6 != null)
            {
                if (_loc5.type == "DropDown")
                {
                    if (_loc5.isValueLabel)
                    {
                        if (_loc6.selectedIndex != -1 && _loc6.selectedItem)
                        {
                            net.wargaming.SettingsDialog.viewData.settings[_loc5.key] = _loc6.selectedItem;
                        } // end if
                    }
                    else
                    {
                        net.wargaming.SettingsDialog.viewData.settings[_loc5.key] = _loc6.selectedIndex;
                    } // end else if
                    continue;
                } // end if
                if (_loc5.type == "Checkbox")
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc5.key] = _loc6.selected;
                    continue;
                } // end if
                if (_loc5.type == "Slider")
                {
                    net.wargaming.SettingsDialog.viewData.settings[_loc5.key] = _loc6.value;
                    var _loc9 = _loc4[_loc8 + "Value"];
                    if (_loc9)
                    {
                        _loc9.text = Math.round(_loc6.value);
                    } // end if
                } // end if
            } // end if
        } // end of for
        if (this.__get__currentView().graphicsQualityDropDown != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.graphicsQuality = this.__get__currentView().graphicsQualityDropDown.selectedIndex;
        } // end if
        if (_loc4.showDateMessageCheckbox != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.datetimeIdx = _loc4.showDateMessageCheckbox.selected ? ((net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 1) == 0 ? (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx + 1) : (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx)) : ((net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 1) != 0 ? (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx - 1) : (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx));
        } // end if
        if (_loc4.showTimeMessageCheckbox != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.datetimeIdx = _loc4.showTimeMessageCheckbox.selected ? ((net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 2) == 0 ? (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx + 2) : (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx)) : ((net.wargaming.SettingsDialog.viewData.settings.datetimeIdx & 2) != 0 ? (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx - 2) : (net.wargaming.SettingsDialog.viewData.settings.datetimeIdx));
        } // end if
        if (_loc4.keys != null)
        {
            for (var _loc3 = 0; _loc3 < _loc4.keys.dataProvider.length; ++_loc3)
            {
                var _loc7 = _loc4.keys.dataProvider[_loc3];
                net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc7.id.group_idx].commands[_loc7.id.command_idx].key = _loc7.key;
            } // end of for
        } // end if
        if (_loc4.sens_arcade != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.controls.mouse.arcadeSens.value = _loc4.sens_arcade.value;
        } // end if
        if (_loc4.sens_sniper != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.controls.mouse.sniperSens.value = _loc4.sens_sniper.value;
        } // end if
        if (_loc4.sens_art != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.controls.mouse.artSens.value = _loc4.sens_art.value;
        } // end if
        if (_loc4.mouse_hor_invert != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.controls.mouse.horInvert.value = Number(_loc4.mouse_hor_invert.selected);
        } // end if
        if (_loc4.mouse_vert_invert != null)
        {
            net.wargaming.SettingsDialog.viewData.settings.controls.mouse.vertInvert.value = Number(_loc4.mouse_vert_invert.selected);
        } // end if
        for (var _loc10 in net.wargaming.SettingsDialog.viewData.settings.cursor)
        {
            if (_loc4[_loc10] != null)
            {
                net.wargaming.SettingsDialog.viewData.settings.cursor[_loc10].alpha = _loc4[_loc10].value;
                _loc4[_loc10 + "Value"].text = Math.round(net.wargaming.SettingsDialog.viewData.settings.cursor[_loc10].alpha);
                if (_loc4[_loc10 + "Type"] != null)
                {
                    net.wargaming.SettingsDialog.viewData.settings.cursor[_loc10].type = _loc4[_loc10 + "Type"].selectedIndex;
                } // end if
                _loc4.setCursor(net.wargaming.SettingsDialog.viewData.settings.cursor);
            } // end if
        } // end of for...in
        for (var _loc12 in net.wargaming.SettingsDialog.viewData.settings.quality)
        {
            if (_loc4[_loc12 + "DropDown"] != null)
            {
                net.wargaming.SettingsDialog.viewData.settings.quality[_loc12] = _loc4[_loc12 + "DropDown"].selectedIndex;
            } // end if
            if (_loc4[_loc12 + "CheckBox"] != null)
            {
                net.wargaming.SettingsDialog.viewData.settings.quality[_loc12] = Number(_loc4[_loc12 + "CheckBox"].selected);
            } // end if
        } // end of for...in
        for (var _loc11 in net.wargaming.SettingsDialog.viewData.settings)
        {
            if (net.wargaming.SettingsDialog.viewData.settings[_loc11] != net.wargaming.SettingsDialog.defaultData[_loc11])
            {
                switch (_loc11)
                {
                    case "cursor":
                    {
                        for (var _loc10 in net.wargaming.SettingsDialog.viewData.settings[_loc11])
                        {
                            if (net.wargaming.SettingsDialog.viewData.settings[_loc11][_loc10].alpha != net.wargaming.SettingsDialog.defaultData[_loc11][_loc10].alpha || net.wargaming.SettingsDialog.viewData.settings[_loc11][_loc10].type != net.wargaming.SettingsDialog.defaultData[_loc11][_loc10].type)
                            {
                                return (true);
                            } // end if
                        } // end of for...in
                        break;
                    } 
                    case "quality":
                    {
                        for (var _loc10 in net.wargaming.SettingsDialog.viewData.settings[_loc11])
                        {
                            if (net.wargaming.SettingsDialog.viewData.settings[_loc11][_loc10] != net.wargaming.SettingsDialog.defaultData[_loc11][_loc10])
                            {
                                return (true);
                            } // end if
                        } // end of for...in
                        break;
                    } 
                    case "controls":
                    {
                        for (var _loc3 = 0; _loc3 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard.length; ++_loc3)
                        {
                            for (var _loc2 = 0; _loc2 < net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].commands.length; ++_loc2)
                            {
                                if (net.wargaming.SettingsDialog.viewData.settings.controls.keyboard[_loc3].commands[_loc2].key != net.wargaming.SettingsDialog.defaultData[_loc11].keyboard[_loc3].commands[_loc2].key)
                                {
                                    return (true);
                                } // end if
                            } // end of for
                        } // end of for
                        for (var _loc10 in net.wargaming.SettingsDialog.defaultData[_loc11].mouse)
                        {
                            if (net.wargaming.SettingsDialog.viewData.settings.controls.mouse[_loc10].value != net.wargaming.SettingsDialog.defaultData[_loc11].mouse[_loc10].value)
                            {
                                return (true);
                            } // end if
                        } // end of for...in
                        break;
                    } 
                    default:
                    {
                        return (true);
                    } 
                } // End of switch
            } // end if
        } // end of for...in
        return (false);
    } // End of the function
    static var __is_need_to_apply_settings = false;
    static var viewData = {};
    static var defaultData = {};
    var isChanged = false;
    var isInited = false;
    static var __currentPage = 0;
    var isVoiceTestStarted = false;
    var voiceTestTimoutID = -1;
    var voiceTestTimerID = -1;
    static var UNCHECK_VOICE_TEST_BTN_TIMEOUT = 10000;
    static var settingsDialogSource = "SettingsDialog";
} // End of Class
