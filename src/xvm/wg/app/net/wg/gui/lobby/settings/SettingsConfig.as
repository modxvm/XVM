package net.wg.gui.lobby.settings
{
    import net.wg.gui.lobby.settings.vo.SettingsControlProp;
    
    public class SettingsConfig extends Object
    {
        
        public function SettingsConfig() {
            super();
        }
        
        public static var GAME_SETTINGS:String = "GameSettings";
        
        public static var GRAPHIC_SETTINGS:String = "GraphicSettings";
        
        public static var SOUND_SETTINGS:String = "SoundSettings";
        
        public static var CONTROLS_SETTINGS:String = "ControlsSettings";
        
        public static var CURSOR_SETTINGS:String = "AimSettings";
        
        public static var MARKER_SETTINGS:String = "MarkerSettings";
        
        public static var OTHER_SETTINGS:String = "OtherSettings";
        
        public static var tabsDataProvider:Array;
        
        public static var markerTabsDataProvider:Array;
        
        public static var cursorTabsDataProvider:Array;
        
        public static var TYPE_CHECKBOX:String = "Checkbox";
        
        public static var TYPE_SLIDER:String = "Slider";
        
        public static var TYPE_STEP_SLIDER:String = "StepSlider";
        
        public static var TYPE_RANGE_SLIDER:String = "RangeSlider";
        
        public static var TYPE_DROPDOWN:String = "DropDown";
        
        public static var TYPE_BUTTON_BAR:String = "ButtonBar";
        
        public static var TYPE_LABEL:String = "Label";
        
        public static var TYPE_VALUE:String = "Value";
        
        public static var TYPE_KEYINPUT:String = "KeyInput";
        
        public static var LOCALIZATION:String = "#settings:";
        
        public static var NO_COLOR_FILTER_DATA:int = 0;
        
        public static var ADVANCED_GRAPHICS_DATA:int = 0;
        
        public static var KEYS_LAYOUT:String = "keysLayout";
        
        public static var KEYBOARD:String = "keyboard";
        
        public static var PUSH_TO_TALK:String = "pushToTalk";
        
        public static var KEYS_LAYOUT_ORDER:String = "keysLayoutOrder";
        
        public static var PTT:String = "PTT";
        
        public static var ENABLE_VO_IP:String = "enableVoIP";
        
        public static var VOICE_CHAT_SUPORTED:String = "voiceChatSupported";
        
        public static var MIC_VIVOX_VOLUME:String = "micVivoxVolume";
        
        public static var ALTERNATIVE_VOICES:String = "alternativeVoices";
        
        public static var DEF_ALTERNATIVE_VOICE:String = "default";
        
        public static var AUTODETECT_BUTTON:String = "autodetectButton";
        
        public static var QUALITY_ORDER:String = "qualityOrder";
        
        public static var PRESETS:String = "presets";
        
        public static var SIZE:String = "sizes";
        
        public static var REFRESH_RATE:String = "refreshRate";
        
        public static var DYNAMIC_RENDERER:String = "dynamicRenderer";
        
        public static var ASPECTRATIO:String = "aspectRatio";
        
        public static var GAMMA:String = "gamma";
        
        public static var VERTICAL_SYNC:String = "vertSync";
        
        public static var FOV:String = "fov";
        
        public static var DYNAMIC_FOV:String = "dynamicFov";
        
        public static var FULL_SCREEN:String = "fullScreen";
        
        public static var RESOLUTION:String = "resolution";
        
        public static var WINDOW_SIZE:String = "windowSize";
        
        public static var MONITOR:String = "monitor";
        
        public static var SMOOTHING:String = "smoothing";
        
        public static var CUSTOM_AA:String = "customAA";
        
        public static var MULTISAMPLING:String = "multisampling";
        
        public static var reservedImaginaryControls:Array;
        
        public static var COLOR_GRADING_TECHNIQUE:String = "COLOR_GRADING_TECHNIQUE";
        
        public static var COLOR_FILTER_INTENSITY:String = "colorFilterIntensity";
        
        public static var COLOR_FILTER_IMAGES:String = "colorFilterImages";
        
        public static var IS_COLOR_BLIND:String = "isColorBlind";
        
        public static var TEXTURE_QUALITY:String = "TEXTURE_QUALITY";
        
        public static var DECALS_QUALITY:String = "DECALS_QUALITY";
        
        public static var SHADOWS_QUALITY:String = "SHADOWS_QUALITY";
        
        public static var TERRAIN_QUALITY:String = "TERRAIN_QUALITY";
        
        public static var WATER_QUALITY:String = "WATER_QUALITY";
        
        public static var LIGHTING_QUALITY:String = "LIGHTING_QUALITY";
        
        public static var SPEEDTREE_QUALITY:String = "SPEEDTREE_QUALITY";
        
        public static var FLORA_QUALITY:String = "FLORA_QUALITY";
        
        public static var EFFECTS_QUALITY:String = "EFFECTS_QUALITY";
        
        public static var POST_PROCESSING_QUALITY:String = "POST_PROCESSING_QUALITY";
        
        public static var MOTION_BLUR_QUALITY:String = "MOTION_BLUR_QUALITY";
        
        public static var FAR_PLANE:String = "FAR_PLANE";
        
        public static var OBJECT_LOD:String = "OBJECT_LOD";
        
        public static var SNIPER_MODE_EFFECTS_QUALITY:String = "SNIPER_MODE_EFFECTS_QUALITY";
        
        public static var SNIPER_MODE_GRASS_ENABLED:String = "SNIPER_MODE_GRASS_ENABLED";
        
        public static var VEHICLE_TRACES_ENABLED:String = "VEHICLE_TRACES_ENABLED";
        
        public static var SEMITRANSPARENT_LEAVES_ENABLED:String = "SEMITRANSPARENT_LEAVES_ENABLED";
        
        public static var VEHICLE_DUST_ENABLED:String = "VEHICLE_DUST_ENABLED";
        
        public static var FPS_PERFORMANCER:String = "fpsPerfomancer";
        
        public static var RENDER_PIPELINE:String = "RENDER_PIPELINE";
        
        public static var CUSTOM:String = "CUSTOM";
        
        public static var GRAPHIC_QUALITY:String = "graphicsQuality";
        
        public static var VIBRO_IS_CONNECTED:String = "vibroIsConnected";
        
        public static var ENABLE_OL_FILTER:String = "enableOlFilter";
        
        public static var DYNAMIC_CAMERA:String = "dynamicCamera";
        
        public static var HOR_STABILIZATION_SNP:String = "horStabilizationSnp";
        
        public static var KEY_RANGE:Object;
        
        public static var settingsData:Object;
        
        public static var liveUpdateVideoSettingsOrderData:Array;
        
        public static var liveUpdateVideoSettingsData:Object;
        
        public static function getControlId(param1:String, param2:String) : String {
            return param1.replace(param2,"");
        }
        
        public static function get tabsDataProviderWithOther() : Array {
            var _loc1_:Array = tabsDataProvider.concat();
            _loc1_.push({
                "label":SETTINGS.OTHERTITLE,
                "linkage":OTHER_SETTINGS
            });
        return _loc1_;
    }
}
}
