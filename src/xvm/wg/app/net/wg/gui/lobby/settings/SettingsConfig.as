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

      public static var tabsDataProvider:Array = [
                                                    {
                                                       "label":SETTINGS.GAMETITLE,
                                                       "linkage":GAME_SETTINGS
                                                    }
                                                 ,
                                                    {
                                                       "label":SETTINGS.GRAFICTITLE,
                                                       "linkage":GRAPHIC_SETTINGS
                                                    }
                                                 ,
                                                    {
                                                       "label":SETTINGS.SOUNDTITLE,
                                                       "linkage":SOUND_SETTINGS
                                                    }
                                                 ,
                                                    {
                                                       "label":SETTINGS.KEYBOARDTITLE,
                                                       "linkage":CONTROLS_SETTINGS
                                                    }
                                                 ,
                                                    {
                                                       "label":SETTINGS.CURSORTITLE,
                                                       "linkage":CURSOR_SETTINGS
                                                    }
                                                 ,
                                                    {
                                                       "label":SETTINGS.MARKERTITLE,
                                                       "linkage":MARKER_SETTINGS
                                                    }
                                                 ];

      public static var markerTabsDataProvider:Array = [
                                                          {
                                                             "label":"#settings:marker/EnemyTitle",
                                                             "linkage":null,
                                                             "id":"enemy",
                                                             "formID":"enemyForm",
                                                             "markerID":"markerEnemy",
                                                             "markerFlag":1
                                                          }
                                                       ,
                                                          {
                                                             "label":"#settings:marker/AllyTitle",
                                                             "linkage":null,
                                                             "id":"ally",
                                                             "formID":"allyForm",
                                                             "markerID":"markerAlly",
                                                             "markerFlag":2
                                                          }
                                                       ,
                                                          {
                                                             "label":"#settings:marker/DeadTitle",
                                                             "linkage":null,
                                                             "id":"dead",
                                                             "formID":"deadForm",
                                                             "markerID":"markerDead",
                                                             "markerFlag":2
                                                          }
                                                       ];

      public static var cursorTabsDataProvider:Array = [
                                                          {
                                                             "label":"#settings:cursor/ArcadeTitle",
                                                             "linkage":null,
                                                             "id":"arcade",
                                                             "formID":"arcadeForm",
                                                             "crosshairID":"arcadeCursor"
                                                          }
                                                       ,
                                                          {
                                                             "label":"#settings:cursor/SnipperTitle",
                                                             "linkage":null,
                                                             "id":"sniper",
                                                             "formID":"sniperForm",
                                                             "crosshairID":"snipperCursor"
                                                          }
                                                       ];

      public static var TYPE_CHECKBOX:String = "Checkbox";

      public static var TYPE_SLIDER:String = "Slider";

      public static var TYPE_DROPDOWN:String = "DropDown";

      public static var TYPE_STEP_SLIDER:String = "StepSlider";

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

      public static var FULL_SCREEN:String = "fullScreen";

      public static var RESOLUTION:String = "resolution";

      public static var WINDOW_SIZE:String = "windowSize";

      public static var MONITOR:String = "monitor";

      public static var SMOOTHING:String = "smoothing";

      public static var CUSTOM_AA:String = "customAA";

      public static var MULTISAMPLING:String = "multisampling";

      public static var reservedImaginaryControls:Array = [QUALITY_ORDER,WINDOW_SIZE,RESOLUTION,MULTISAMPLING,CUSTOM_AA];

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

      public static var VEHICLE_DUST_ENABLED:String = "VEHICLE_DUST_ENABLED";

      public static var FPS_PERFORMANCER:String = "fpsPerfomancer";

      public static var RENDER_PIPELINE:String = "RENDER_PIPELINE";

      public static var CUSTOM:String = "CUSTOM";

      public static var GRAPHIC_QUALITY:String = "graphicsQuality";

      public static var VIBRO_IS_CONNECTED:String = "vibroIsConnected";

      public static var ENABLE_OL_FILTER:String = "enableOlFilter";

      public static var DYNAMIC_CAMERA:String = "dynamicCamera";

      public static var HOR_STABILIZATION_SNP:String = "horStabilizationSnp";

      public static var KEY_RANGE:Object = {
                                              "defaultRange":["APOSTROPHE","SEMICOLON","LBRACKET","STOP","COMMA","SLASH","BACKSLASH","RBRACKET","SPACE","LSHIFT","LALT","1","2","3","4","5","6","7","8","9","0","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","W","V","X","Y","Z","UPARROW","DOWNARROW","LEFTARROW","RIGHTARROW","MOUSE0","MOUSE1","MOUSE2","MOUSE3","MOUSE4","MOUSE5","MOUSE6","MOUSE7","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","INSERT","DELETE","HOME","END","NUMPAD0","NUMPAD1","NUMPAD2","NUMPAD3","NUMPAD4","NUMPAD5","NUMPAD6","NUMPAD7","NUMPAD8","NUMPAD9","NAMPADSLASH","NAMPADSTAR","NUMPADMINUS","ADD","NUMPADPERIOD"],
                                              "pushToTalk":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe"],
                                              "sizeUp":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
                                              "sizeDown":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
                                              "visible":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE4","MOUSE5"],
                                              "showRadialMenu":["q","w","e","r","t","y","u","i","o","p","lbracket","rbracket","a","s","d","f","g","h","j","k","l","semicolon","backslash","z","x","c","v","b","n","m","comma","stop","slash","insert","delete","home","end","apostrophe","MINUS","EQUALS","space","numpadslash","numpadstar","numpadminus","add","numpadperiod","numpad0","numpad1","numpad2","numpad3","numpad4","numpad5","numpad6","numpad7","numpad8","numpad9","MOUSE2","MOUSE3","MOUSE4","MOUSE5","MOUSE6","MOUSE7"]
                                           };

      public static var settingsData:Object = {
                                                 "GameSettings":
                                                    {
                                                       "enableOlFilter":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "enableSpamFilter":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "showDateMessage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "showTimeMessage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "invitesFromFriendsOnly":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "enableStoreCws":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "enableStoreMws":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "storeReceiverInBattle":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "dynamicCamera":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "horStabilizationSnp":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "disableBattleChat":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "ppShowLevels":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "gameplay_ctf":new SettingsControlProp(null,null,TYPE_CHECKBOX,false,false,null,true),
                                                       "gameplay_domination":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "gameplay_assault":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "minimapAlpha":new SettingsControlProp(null,null,TYPE_SLIDER),
                                                       "enablePostMortemEffect":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "enablePostMortemDelay":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "enableOpticalSnpEffect":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "replayEnabled":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "useServerAim":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "showVehiclesCounter":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "vibroIsConnected":new SettingsControlProp(null,null,TYPE_CHECKBOX,false,false,null,true),
                                                       "vibroGain":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroEngine":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroAcceleration":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroShots":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroHits":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroCollisions":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroDamage":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected"),
                                                       "vibroGUI":new SettingsControlProp(null,null,TYPE_SLIDER,true,true,"vibroIsConnected")
                                                    }
                                                 ,
                                                 "GraphicSettings":
                                                    {
                                                       "monitor":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "aspectRatio":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "smoothing":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "customAA":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "multisampling":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "gamma":new SettingsControlProp(null,null,TYPE_SLIDER),
                                                       "sizes":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "windowSize":new SettingsControlProp(null,null,TYPE_DROPDOWN,false,false,null,true),
                                                       "resolution":new SettingsControlProp(null,null,TYPE_DROPDOWN,false,false,null,true),
                                                       "refreshRate":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "dynamicRenderer":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "fov":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "colorFilterIntensity":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "colorFilterImages":null,
                                                       "fullScreen":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "vertSync":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "isColorBlind":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "graphicsQuality":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "RENDER_PIPELINE":new SettingsControlProp(null,null,TYPE_BUTTON_BAR,false),
                                                       "TEXTURE_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "DECALS_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "SHADOWS_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "TERRAIN_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "WATER_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "LIGHTING_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "SPEEDTREE_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "FLORA_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "EFFECTS_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "POST_PROCESSING_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "MOTION_BLUR_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "FAR_PLANE":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "OBJECT_LOD":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "SNIPER_MODE_EFFECTS_QUALITY":new SettingsControlProp(null,null,TYPE_STEP_SLIDER,true),
                                                       "COLOR_GRADING_TECHNIQUE":new SettingsControlProp(null,null,TYPE_DROPDOWN,true),
                                                       "fpsPerfomancer":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "SNIPER_MODE_GRASS_ENABLED":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "VEHICLE_DUST_ENABLED":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "VEHICLE_TRACES_ENABLED":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "qualityOrder":null,
                                                       "presets":{}
                                                    }
                                                 ,
                                                 "SoundSettings":
                                                    {
                                                       "PTT":new SettingsControlProp(null,null,TYPE_KEYINPUT,false,false,"pushToTalk",true),
                                                       "masterVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "musicVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "voiceVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "vehiclesVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "effectsVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "guiVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "ambientVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "nationalVoices":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "alternativeVoices":new SettingsControlProp(null,null,TYPE_DROPDOWN,false,false,null,false,false,null,true),
                                                       "enableVoIP":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                       "captureDevice":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                       "masterVivoxVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "micVivoxVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "masterFadeVivoxVolume":new SettingsControlProp(null,null,TYPE_SLIDER,false,true),
                                                       "voiceChatSupported":new SettingsControlProp(null,null,TYPE_CHECKBOX,false,false,null,true)
                                                    }
                                                 ,
                                                 "ControlsSettings":
                                                    {
                                                       "keysLayoutOrder":null,
                                                       "keyboard":null,
                                                       "mouseHorzInvert":new SettingsControlProp(null,null,TYPE_CHECKBOX,false,false,null,true),
                                                       "mouseArcadeSens":new SettingsControlProp(null,null,TYPE_SLIDER,false,false,null,true),
                                                       "mouseVertInvert":new SettingsControlProp(null,null,TYPE_CHECKBOX,false,false,null,true),
                                                       "mouseSniperSens":new SettingsControlProp(null,null,TYPE_SLIDER,false,false,null,true),
                                                       "mouseStrategicSens":new SettingsControlProp(null,null,TYPE_SLIDER,false,false,null,true),
                                                       "backDraftInvert":new SettingsControlProp(null,null,TYPE_CHECKBOX)
                                                    }
                                                 ,
                                                 "AimSettings":
                                                    {
                                                       "arcade":
                                                          {
                                                             "netType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "net":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "centralTagType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "centralTag":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "reloader":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "condition":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "mixingType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "mixing":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "cassette":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "gunTagType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "gunTag":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "reloaderTimer":new SettingsControlProp(null,null,TYPE_SLIDER,true,true)
                                                          }
                                                       ,
                                                       "sniper":
                                                          {
                                                             "netType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "net":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "centralTagType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "centralTag":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "reloader":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "condition":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "mixingType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "mixing":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "cassette":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "gunTagType":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "gunTag":new SettingsControlProp(null,null,TYPE_SLIDER,true,true),
                                                             "reloaderTimer":new SettingsControlProp(null,null,TYPE_SLIDER,true,true)
                                                          }
                                                    }
                                                 ,
                                                 "MarkerSettings":
                                                    {
                                                       "enemy":
                                                          {
                                                             "markerBaseIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltPlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBasePlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBaseLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX)
                                                          }
                                                       ,
                                                       "ally":
                                                          {
                                                             "markerBaseIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltPlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBasePlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBaseLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX)
                                                          }
                                                       ,
                                                       "dead":
                                                          {
                                                             "markerBaseIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltIcon":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltDamage":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltPlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerBaseHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBasePlayerName":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHpIndicator":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltHp":new SettingsControlProp(null,null,TYPE_DROPDOWN),
                                                             "markerBaseLevel":new SettingsControlProp(null,null,TYPE_CHECKBOX),
                                                             "markerAltVehicleName":new SettingsControlProp(null,null,TYPE_CHECKBOX)
                                                          }
                                                    }
                                              };

      public static var liveUpdateVideoSettingsOrderData:Array = [MONITOR,FULL_SCREEN,WINDOW_SIZE,RESOLUTION,SIZE,REFRESH_RATE];

      public static var liveUpdateVideoSettingsData:Object = {
                                                                "monitor":null,
                                                                "fullScreen":null,
                                                                "windowSize":null,
                                                                "resolution":null,
                                                                "refreshRate":null
                                                             };

      public static function getControlId(param1:String, param2:String) : String {
         return param1.replace(param2,"");
      }

      public static function get tabsDataProviderWithOther() : Array {
         var _loc1_:Array = tabsDataProvider.concat();
         return _loc1_;
      }
   }

}