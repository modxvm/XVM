/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy(at)gmail.com>
 */
import com.xvm.*;

class com.xvm.Config
{
    // Public vars
    public static var config:Object = null;
    public static var networkServicesSettings:Object = null;

    // INTERNAL

    // instance
    private static var _instance:Config = null;
    public static function get instance():Config
    {
        if (_instance == null)
            _instance = new Config();
        return _instance;
    }

    public function GetConfigCallback(config_data:String, lang_str:String, battleLevel:Number, battleType:Number, vehInfoData:String, networkServicesSettings:String)
    {
        //Logger.add("Config::GetConfigCallback()");
        try
        {
            Config.config = JSONx.parse(config_data);
            //Logger.addObject(Config.config);
            Config.networkServicesSettings = JSONx.parse(networkServicesSettings);
            Macros.RegisterGlobalMacrosData(battleLevel, battleType);
            ApplyGlobalMacros();
            Locale.initializeLanguageFile(lang_str);
            VehicleInfo.onVehicleInfoData(vehInfoData);

            Cmd.getComments(this, onGetCommentsCallback);

            Logger.add("Config: Loaded");
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_CONFIG_LOADED } );
        }
        catch (ex)
        {
            Logger.add("CONFIG LOAD ERROR: " + Utils.parseError(ex));
        }
    }

    private function onGetCommentsCallback(json_str:String)
    {
        try
        {
            var comments:Object = JSONx.parse(json_str).players;
            //Logger.addObject(comments, 2);
            Macros.RegisterCommentsData(comments);
        }
        catch (ex)
        {
            Logger.add("onGetCommentsCallback: ERROR: " + Utils.parseError(ex));
        }
    }

    private function ApplyGlobalMacros()
    {
        // playersPanel
        var cfg = Config.config.playersPanel;
        cfg.startMode = Macros.FormatGlobalStringValue(cfg.startMode);
        cfg.altMode = Macros.FormatGlobalStringValue(cfg.altMode);
        cfg.short.enabled = Macros.FormatGlobalBooleanValue(cfg.short.enabled);
        cfg.medium.enabled = Macros.FormatGlobalBooleanValue(cfg.medium.enabled);
        cfg.medium2.enabled = Macros.FormatGlobalBooleanValue(cfg.medium2.enabled);
        cfg.large.enabled = Macros.FormatGlobalBooleanValue(cfg.large.enabled);
        cfg.none.enabled = Macros.FormatGlobalBooleanValue(cfg.none.enabled);
        cfg.none.leftPanel.x = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.x);
        cfg.none.leftPanel.y = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.y);
        cfg.none.leftPanel.width = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.width);
        cfg.none.leftPanel.height = Macros.FormatGlobalNumberValue(cfg.none.leftPanel.height);
        cfg.none.rightPanel.x = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.x);
        cfg.none.rightPanel.y = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.y);
        cfg.none.rightPanel.width = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.width);
        cfg.none.rightPanel.height = Macros.FormatGlobalNumberValue(cfg.none.rightPanel.height);
    }
}
