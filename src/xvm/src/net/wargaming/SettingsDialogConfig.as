class net.wargaming.SettingsDialogConfig
{
    var __get__OPTIONS_CONFIG;
    function SettingsDialogConfig()
    {
    } // End of the function
    function get OPTIONS_CONFIG()
    {
        return (VIDEO_OPTIONS_CONFIG.concat(DATA_OPTIONS_CONFIG));
    } // End of the function
    function getOptionGUIKey(option)
    {
        return (option.guiKey ? (option.guiKey) : (option.key + option.type));
    } // End of the function
    function getOptionGUILabelKey(option)
    {
        return (option.guiLabel ? (option.guiLabel) : (option.key + "Label"));
    } // End of the function
    function isOptionValid(opt, settings)
    {
        var _loc1 = true;
        if (opt.condition)
        {
            _loc1 = !Boolean(opt.condition.readonly);
            if (opt.condition.key)
            {
                _loc1 = Boolean(settings[opt.condition.key]);
            } // end if
            if (opt.condition.isInverse)
            {
                _loc1 = !_loc1;
            } // end if
        } // end if
        return (_loc1);
    } // End of the function
    var KEY_RANGE = {pushToTalk: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe"], sizeUp: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"], sizeDown: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"], visible: ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"]};
    var DATA_OPTIONS_CONFIG = [{key: "isApplyHighQualityPossible", type: "Checkbox", condition: {readonly: true}}, {key: "isMRTSupported", type: "Checkbox", condition: {readonly: true}}, {key: "aspectRatio", type: "DropDown", isDisabled: function (settings)
    {
        return (!settings.fullScreen);
    }}, {key: "vertSync", type: "Checkbox"}, {key: "tripleBuffered", type: "Checkbox"}, {key: "multisampling", type: "DropDown"}, {key: "customAA", type: "DropDown"}, {key: "gamma", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.fullScreen);
    }}, {key: "masterVolume", type: "Slider"}, {key: "musicVolume", type: "Slider"}, {key: "voiceVolume", type: "Slider"}, {key: "vehiclesVolume", type: "Slider"}, {key: "effectsVolume", type: "Slider"}, {key: "guiVolume", type: "Slider"}, {key: "ambientVolume", type: "Slider"}, {key: "masterVivoxVolume", type: "Slider"}, {key: "micVivoxVolume", type: "Slider", eventListener: "setVivoxMicVolume"}, {key: "masterFadeVivoxVolume", type: "Slider"}, {key: "captureDevice", type: "DropDown", isValueLabel: true}, {key: "voiceChatNotSupported", type: "Checkbox", condition: {readonly: true}}, {key: "datetimeIdx", type: "Checkbox", combine: true}, {key: "showJoinLeaveMessages", type: "Checkbox"}, {key: "enableOlFilter", type: "Checkbox"}, {key: "enableSpamFilter", type: "Checkbox"}, {key: "enableStoreChatMws", type: "Checkbox"}, {key: "enableStoreChatCws", type: "Checkbox"}, {key: "invitesFromFriendsOnly", type: "Checkbox"}, {key: "showLangBar", type: "Checkbox"}, {key: "enableVoIP", type: "Checkbox", isDisabled: function (settings)
    {
        return (settings.voiceChatNotSupported);
    }, eventListener: "onVoiceChatEnabledSelect"}, {key: "enablePostMortemEffect", type: "Checkbox"}, {key: "nationalVoices", type: "Checkbox"}, {key: "showVehicleIcon", type: "Checkbox"}, {key: "showVehicleLevel", type: "Checkbox"}, {key: "showExInf4Destroyed", type: "Checkbox"}, {key: "isColorBlind", type: "Checkbox"}, {key: "minimapAlpha", type: "Slider"}, {key: "replayEnabled", type: "Checkbox"}, {key: "ppShowLevels", type: "Checkbox"}, {key: "ppShowTypes", type: "Checkbox"}, {key: "vibroIsConnected", type: "Checkbox", condition: {readonly: true}}, {key: "vibroGain", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroEngine", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroAcceleration", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroShots", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroHits", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroCollisions", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroDamage", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "vibroGUI", type: "Slider", isDisabled: function (settings)
    {
        return (!settings.vibroIsConnected);
    }}, {key: "cursors", type: "Cursor", condition: {readonly: true}}];
    var VIDEO_OPTIONS_CONFIG = [{key: "monitor", type: "DropDown", eventListener: "handleMonitorChange"}, {key: "windowSize", type: "DropDown", optionsDepends: "monitor", guiKey: "sizesDropDown", guiLabelKey: "sizesLabel", condition: {key: "fullScreen", isInverse: true}}, {key: "resolution", type: "DropDown", optionsDepends: "monitor", guiKey: "sizesDropDown", guiLabelKey: "sizesLabel", condition: {key: "fullScreen"}}, {key: "fullScreen", type: "Checkbox", eventListener: "handleClickFullScreenCheckbox"}];
    var isDebug = false;
    var debugData = [17, "MRT_DEPTH", 2, 0, "ON", "OFF", "TEXTURE_QUALITY", 4, 0, "HIGH", "MEDIUM", "LOW", "LOWEST", "TEXTURE_COMPRESSION", 2, 0, "ON", "OFF", "TEXTURE_FILTERING", 7, 0, "ANISOTROPIC_16X", "ANISOTROPIC_8X", "ANISOTROPIC_4X", "ANISOTROPIC_2X", "TRILINEAR", "BILINEAR", "POINT", "WG_SHADOWS_ENABLED", 2, 0, "ON", "OFF", "SHADOWS_QUALITY", 4, 2, "HIGH", "MEDIUM", "LOW", "OFF", "SPEEDTREE_QUALITY", 4, 0, "VERY_HIGH", "HIGH", "MEDIUM", "LOW", "WATER_QUALITY", 4, 0, "HIGH", "MEDIUM", "LOW", "LOWEST", "WATER_SIMULATION", 3, 0, "HIGH", "LOW", "OFF", "FAR_PLANE", 3, 0, "HIGH", "MEDIUM", "LOW", "FLORA_DENSITY", 5, 0, "VERY_HIGH", "HIGH", "MEDIUM", "LOW", "OFF", "OBJECT_LOD", 3, 0, "HIGH", "MEDIUM", "LOW", "VEHICLE_DUST_ENABLED", 2, 1, "OFF", "ON", "VEHICLE_TRACES_ENABLED", 2, 1, "OFF", "ON", "SMOKE_ENABLED", 2, 1, "OFF", "ON", "SNIPER_MODE_SWINGING_ENABLED", 2, 1, "OFF", "ON", "POST_PROCESSING", 4, 0, "HIGH", "MEDIUM", "LOW", "OFF", 5, 4, 0, "VERY_HIGH", 16, "VEHICLE_DUST_ENABLED", 1, "WG_SHADOWS_ENABLED", 0, "FAR_PLANE", 0, "TEXTURE_COMPRESSION", 0, "SPEEDTREE_QUALITY", 0, "TEXTURE_QUALITY", 0, "OBJECT_LOD", 0, "WATER_SIMULATION", 0, "WATER_QUALITY", 0, "POST_PROCESSING", 0, "FLORA_DENSITY", 0, "VEHICLE_TRACES_ENABLED", 1, "TEXTURE_FILTERING", 0, "SMOKE_ENABLED", 1, "SHADOWS_QUALITY", 0, "MRT_DEPTH", 0, 1, "HIGH", 16, "VEHICLE_DUST_ENABLED", 1, "WG_SHADOWS_ENABLED", 1, "FAR_PLANE", 0, "TEXTURE_COMPRESSION", 0, "SPEEDTREE_QUALITY", 1, "TEXTURE_QUALITY", 0, "OBJECT_LOD", 0, "WATER_SIMULATION", 0, "WATER_QUALITY", 1, "POST_PROCESSING", 1, "FLORA_DENSITY", 2, "VEHICLE_TRACES_ENABLED", 1, "TEXTURE_FILTERING", 1, "SMOKE_ENABLED", 1, "SHADOWS_QUALITY", 1, "MRT_DEPTH", 0, 2, "MEDIUM", 16, "VEHICLE_DUST_ENABLED", 1, "WG_SHADOWS_ENABLED", 1, "FAR_PLANE", 1, "TEXTURE_COMPRESSION", 0, "SPEEDTREE_QUALITY", 2, "TEXTURE_QUALITY", 1, "OBJECT_LOD", 0, "WATER_SIMULATION", 0, "WATER_QUALITY", 2, "POST_PROCESSING", 2, "FLORA_DENSITY", 3, "VEHICLE_TRACES_ENABLED", 1, "TEXTURE_FILTERING", 3, "SMOKE_ENABLED", 1, "SHADOWS_QUALITY", 2, "MRT_DEPTH", 1, 3, "LOW", 16, "VEHICLE_DUST_ENABLED", 0, "WG_SHADOWS_ENABLED", 1, "FAR_PLANE", 2, "TEXTURE_COMPRESSION", 0, "SPEEDTREE_QUALITY", 3, "TEXTURE_QUALITY", 2, "OBJECT_LOD", 1, "WATER_SIMULATION", 2, "WATER_QUALITY", 3, "POST_PROCESSING", 3, "FLORA_DENSITY", 4, "VEHICLE_TRACES_ENABLED", 0, "TEXTURE_FILTERING", 4, "SMOKE_ENABLED", 0, "SHADOWS_QUALITY", 3, "MRT_DEPTH", 1, 4, "CUSTOM", 0, true, true, true, 4, 1, "4:3", "16:9", "16:10", "19:10", false, true, 7, 0, "type0", "type2", "type4", "type1032", "type2056", "type1040", "type2064", 5, 0, "mode0", "mode1", "mode2", "mode3", "mode4", 1, 39, 50, 100, 48, 100, 50, 29, 62, 20, 46, 0, "", true, 2, false, true, true, true, true, false, false, true, false, true, false, false, false, false, 42, false, 100, 100, 100, 100, 100, 100, 100, 100, true, true, true, 6, "centralTag", 90, 0, 9, "gunTag", 90, 0, 7, "mixing", 90, 0, 4, "net", 90, 0, 4, "reloader", 90, 0, 0, "condition", 90, 0, 0, 9, "movement", 5, "forward", 1, "W", "W", "backward", 3, "S", "S", "left", 4, "A", "A", "right", 5, "D", "D", "auto_rotation", 36, "X", "X", "cruis_control", 3, "forward", 6, "R", "R", "backward", 7, "F", "F", "stop_fire", 8, "SPACE", "SPACE", "firing", 4, "fire", 27, "LEFTMOUSE", "LEFTMOUSE", "lock_target", 30, "MOUSE1", "MOUSE1", "lock_target_off", 31, "E", "E", "alternate_mode", 39, "LSHIFT", "LSHIFT", "equipment", 8, "item01", 10, "1", "1", "item02", 11, "2", "2", "item03", 12, "3", "3", "item04", 13, "4", "4", "item05", 14, "5", "5", "item06", 15, "6", "6", "item07", 16, "7", "7", "item08", 17, "8", "8", "shortcuts", 7, "my_target", 20, "T", "T", "attack", 21, "F2", "F2", "to_base", 22, "F3", "F3", "follow_me", 23, "F4", "F4", "positive", 24, "F5", "F5", "negative", 25, "F6", "F6", "help_me", 26, "F7", "F7", "camera", 4, "camera_up", 34, "UPARROW", "UPARROW", "camera_down", 35, "DOWNARROW", "DOWNARROW", "camera_left", 32, "LEFTARROW", "LEFTARROW", "camera_right", 33, "RIGHTARROW", "RIGHTARROW", "voicechat", 1, "pushToTalk", 50, "Q", "Q", "minimap", 3, "sizeUp", 47, "EQUALS", "EQUALS", "sizeDown", 48, "MINUS", "MINUS", "visible", 49, "M", "M", "logitech_keyboard", 1, "switch_view", 52, "INSERT", "INSERT", 1, 1, 1, false, false, 1, 1, 1, false, false];
    var debugVideo = [2, 1, "1 - monitor PnP (primary)", "2 - BenQ G2222HDL D-SUB", 12, 11, "1001024x768", "1001152x864", "1001280x768", "1001280x800", "1001280x960", "1001280x1024", "1001360x768", "1001440x900", "1001600x900", "1001680x1050", "1001920x1080", "1024x768*", 11, 10, "1001024x768", "1001152x864", "1001280x768", "1001280x800", "1001280x960", "1001280x1024", "1001360x768", "1001440x900", "1001600x900", "1001680x1050", "1001920x1080"];
} // End of Class
