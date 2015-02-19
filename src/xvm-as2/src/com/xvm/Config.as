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
}
