package net.wg.gui.lobby.settings 
{
    import net.wg.gui.lobby.settings.vo.*;
    
    public class SettingsConfig extends Object
    {
        public function SettingsConfig()
        {
            super();
            return;
        }

        
        {
            GAME_SETTINGS = "GameSettings";
            GRAPHIC_SETTINGS = "GraphicSettings";
            SOUND_SETTINGS = "SoundSettings";
            CONTROLS_SETTINGS = "ControlsSettings";
            CURSOR_SETTINGS = "AimSettings";
            MARKER_SETTINGS = "MarkerSettings";
            tabsDataProvider = [{"label":SETTINGS.GAMETITLE, "linkage":GAME_SETTINGS}, {"label":SETTINGS.GRAFICTITLE, "linkage":GRAPHIC_SETTINGS}, {"label":SETTINGS.SOUNDTITLE, "linkage":SOUND_SETTINGS}, {"label":SETTINGS.KEYBOARDTITLE, "linkage":CONTROLS_SETTINGS}, {"label":SETTINGS.CURSORTITLE, "linkage":CURSOR_SETTINGS}, {"label":SETTINGS.MARKERTITLE, "linkage":MARKER_SETTINGS}];
            markerTabsDataProvider = [{"label":"#settings:marker/EnemyTitle", "linkage":null, "id":"enemy", "formID":"enemyForm", "markerID":"markerEnemy", "markerFlag":1}, {"label":"#settings:marker/AllyTitle", "linkage":null, "id":"ally", "formID":"allyForm", "markerID":"markerAlly", "markerFlag":2}, {"label":"#settings:marker/DeadTitle", "linkage":null, "id":"dead", "formID":"deadForm", "markerID":"markerDead", "markerFlag":2}];
            cursorTabsDataProvider = [{"label":"#settings:cursor/ArcadeTitle", "linkage":null, "id":"arcade", "formID":"arcadeForm", "crosshairID":"arcadeCursor"}, {"label":"#settings:cursor/SnipperTitle", "linkage":null, "id":"sniper", "formID":"sniperForm", "crosshairID":"snipperCursor"}];
            TYPE_CHECKBOX = "Checkbox";
            TYPE_SLIDER = "Slider";
            TYPE_DROPDOWN = "DropDown";
            TYPE_LABEL = "Label";
            TYPE_VALUE = "Value";
            TYPE_KEYINPUT = "KeyInput";
            LOCALIZATION = "#settings:";
            KEYS_LAYOUT = "keysLayout";
            KEYBOARD = "keyboard";
            PUSH_TO_TALK = "pushToTalk";
            KEYS_LAYOUT_ORDER = "keysLayoutOrder";
            PTT = "PTT";
            ENABLE_VO_IP = "enableVoIP";
            VOICE_CHAT_SUPORTED = "voiceChatSupported";
            MIC_VIVOX_VOLUME = "micVivoxVolume";
            ALTERNATIVE_VOICES = "alternativeVoices";
            DEF_ALTERNATIVE_VOICE = "default";
            QUALITY_ORDER = "qualityOrder";
            PRESETS = "presets";
            SIZE = "sizes";
            ASPECTRATIO = "aspectRatio";
            GAMMA = "gamma";
            FULL_SCREEN = "fullScreen";
            RESOLUTION = "resolution";
            WINDOW_SIZE = "windowSize";
            MONITOR = "monitor";
            SMOOTHING = "smoothing";
            CUSTOM_AA = "customAA";
            MULTISAMPLING = "multisampling";
            reservedImaginaryControls = [QUALITY_ORDER, WINDOW_SIZE, RESOLUTION, MULTISAMPLING, CUSTOM_AA];
            RENDER_PIPELINE = "RENDER_PIPELINE";
            CUSTOM = "CUSTOM";
            GRAPHIC_QUALITY = "graphicsQuality";
            VIBRO_IS_CONNECTED = "vibroIsConnected";
            ENABLE_OL_FILTER = "enableOlFilter";
            KEY_RANGE = {"defaultRange":["APOSTROPHE", "SEMICOLON", "LBRACKET", "STOP", "COMMA", "SLASH", "BACKSLASH", "RBRACKET", "SPACE", "LSHIFT", "LALT", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "W", "V", "X", "Y", "Z", "UPARROW", "DOWNARROW", "LEFTARROW", "RIGHTARROW", "LEFTMOUSE", "MOUSE1", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12", "INSERT", "DELETE", "HOME", "END", "NUMPAD0", "NUMPAD1", "NUMPAD2", "NUMPAD3", "NUMPAD4", "NUMPAD5", "NUMPAD6", "NUMPAD7", "NUMPAD8", "NUMPAD9", "NAMPADSLASH", "NAMPADSTAR", "NUMPADMINUS", "ADD", "NUMPADPERIOD"], "pushToTalk":["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe"], "sizeUp":["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"], "sizeDown":["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"], "visible":["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE4", "MOUSE5"], "showRadialMenu":["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "lbracket", "rbracket", "a", "s", "d", "f", "g", "h", "j", "k", "l", "semicolon", "backslash", "z", "x", "c", "v", "b", "n", "m", "comma", "stop", "slash", "insert", "delete", "home", "end", "apostrophe", "MINUS", "EQUALS", "space", "numpadslash", "numpadstar", "numpadminus", "add", "numpadperiod", "numpad0", "numpad1", "numpad2", "numpad3", "numpad4", "numpad5", "numpad6", "numpad7", "numpad8", "numpad9", "MOUSE2", "MOUSE3", "MOUSE4", "MOUSE5", "MOUSE6", "MOUSE7"]};
            settingsData = {"GameSettings":{"enableOlFilter":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "enableSpamFilter":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "showDateMessage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "showTimeMessage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "invitesFromFriendsOnly":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "enableStoreCws":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "enableStoreMws":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "storeReceiverInBattle":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "dynamicCamera":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "ppShowLevels":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "gameplay_ctf":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, true), "gameplay_domination":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "gameplay_assault":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "minimapAlpha":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER), "enablePostMortemEffect":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "replayEnabled":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "useServerAim":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "showVehiclesCounter":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "vibroIsConnected":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, true), "vibroGain":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroEngine":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroAcceleration":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroShots":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroHits":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroCollisions":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected"), "vibroGUI":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true, "vibroIsConnected")}, "GraphicSettings":{"monitor":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "sizes":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "aspectRatio":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "smoothing":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "customAA":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "multisampling":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "gamma":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER), "windowSize":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, false, false, null, true), "resolution":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, false, false, null, true), "fullScreen":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "vertSync":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "tripleBuffered":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "isColorBlind":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "graphicsQuality":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "RENDER_PIPELINE":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "TEXTURE_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "DECALS_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "SHADOWS_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "TERRAIN_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "WATER_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "LIGHTING_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "SPEEDTREE_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "FLORA_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "EFFECTS_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "POST_PROCESSING_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "FAR_PLANE":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "OBJECT_LOD":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "SNIPER_MODE_EFFECTS_QUALITY":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, true), "fpsPerfomancer":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "SNIPER_MODE_GRASS_ENABLED":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, false, true), "VEHICLE_DUST_ENABLED":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "VEHICLE_TRACES_ENABLED":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, false, true), "qualityOrder":null, "presets":{}}, "SoundSettings":{"PTT":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_KEYINPUT, false, false, "pushToTalk", true), "masterVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "musicVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "voiceVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "vehiclesVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "effectsVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "guiVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "ambientVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "nationalVoices":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "alternativeVoices":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN, false, false, null, false, false, null, true), "enableVoIP":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "captureDevice":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "masterVivoxVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "micVivoxVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "masterFadeVivoxVolume":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, true), "voiceChatSupported":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, true)}, "ControlsSettings":{"keysLayoutOrder":null, "keyboard":null, "mouseHorzInvert":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, true), "mouseArcadeSens":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, false, null, true), "mouseVertInvert":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX, false, false, null, true), "mouseSniperSens":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, false, null, true), "mouseStrategicSens":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, false, false, null, true), "backDraftInvert":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX)}, "AimSettings":{"arcade":{"netType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "net":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "centralTagType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "centralTag":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "reloader":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "condition":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "mixingType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "mixing":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "cassette":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "gunTagType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "gunTag":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true)}, "sniper":{"netType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "net":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "centralTagType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "centralTag":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "reloader":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "condition":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "mixingType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "mixing":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "cassette":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true), "gunTagType":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "gunTag":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_SLIDER, true, true)}}, "MarkerSettings":{"enemy":{"markerBaseIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltPlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBasePlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBaseLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX)}, "ally":{"markerBaseIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltPlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBasePlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBaseLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX)}, "dead":{"markerBaseIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltIcon":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltDamage":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltPlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerBaseHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBasePlayerName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHpIndicator":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltHp":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_DROPDOWN), "markerBaseLevel":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX), "markerAltVehicleName":new net.wg.gui.lobby.settings.vo.SettingsControlProp(null, null, TYPE_CHECKBOX)}}};
            liveUpdateVideoSettingsOrderData = [MONITOR, FULL_SCREEN, WINDOW_SIZE, RESOLUTION, SIZE];
            liveUpdateVideoSettingsData = {"monitor":null, "fullScreen":null, "windowSize":null, "resolution":null};
        }

        public static function getControlId(arg1:String, arg2:String):String
        {
            return arg1.replace(arg2, "");
        }

        public static var SOUND_SETTINGS:String="SoundSettings";

        public static var CONTROLS_SETTINGS:String="ControlsSettings";

        public static var CURSOR_SETTINGS:String="AimSettings";

        public static var MARKER_SETTINGS:String="MarkerSettings";

        public static var tabsDataProvider:Array;

        public static var markerTabsDataProvider:Array;

        public static var cursorTabsDataProvider:Array;

        public static var TYPE_CHECKBOX:String="Checkbox";

        public static var TYPE_SLIDER:String="Slider";

        public static var TYPE_DROPDOWN:String="DropDown";

        public static var TYPE_LABEL:String="Label";

        public static var TYPE_VALUE:String="Value";

        public static var TYPE_KEYINPUT:String="KeyInput";

        public static var LOCALIZATION:String="#settings:";

        public static var KEYS_LAYOUT:String="keysLayout";

        public static var KEYBOARD:String="keyboard";

        public static var PUSH_TO_TALK:String="pushToTalk";

        public static var KEYS_LAYOUT_ORDER:String="keysLayoutOrder";

        public static var PTT:String="PTT";

        public static var ENABLE_VO_IP:String="enableVoIP";

        public static var VOICE_CHAT_SUPORTED:String="voiceChatSupported";

        public static var MIC_VIVOX_VOLUME:String="micVivoxVolume";

        public static var ALTERNATIVE_VOICES:String="alternativeVoices";

        public static var DEF_ALTERNATIVE_VOICE:String="default";

        public static var QUALITY_ORDER:String="qualityOrder";

        public static var PRESETS:String="presets";

        public static var SIZE:String="sizes";

        public static var ASPECTRATIO:String="aspectRatio";

        public static var GAMMA:String="gamma";

        public static var FULL_SCREEN:String="fullScreen";

        public static var RESOLUTION:String="resolution";

        public static var WINDOW_SIZE:String="windowSize";

        public static var MONITOR:String="monitor";

        public static var SMOOTHING:String="smoothing";

        public static var CUSTOM_AA:String="customAA";

        public static var GAME_SETTINGS:String="GameSettings";

        public static var reservedImaginaryControls:Array;

        public static var RENDER_PIPELINE:String="RENDER_PIPELINE";

        public static var CUSTOM:String="CUSTOM";

        public static var GRAPHIC_QUALITY:String="graphicsQuality";

        public static var VIBRO_IS_CONNECTED:String="vibroIsConnected";

        public static var MULTISAMPLING:String="multisampling";

        public static var KEY_RANGE:Object;

        public static var settingsData:Object;

        public static var liveUpdateVideoSettingsOrderData:Array;

        public static var liveUpdateVideoSettingsData:Object;

        public static var GRAPHIC_SETTINGS:String="GraphicSettings";

        public static var ENABLE_OL_FILTER:String="enableOlFilter";
    }
}
