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

    public function GetConfigCallback(config_data:String, lang_str:String, vehInfoData:String, networkServicesSettings:String, comments:String)
    {
        //Logger.add("Config::GetConfigCallback()");
        try
        {
            Config.config = JSONx.parse(config_data);
            //Logger.addObject(Config.config);
            Locale.languageFileCallback(lang_str);
            VehicleInfo.onVehicleInfoData(vehInfoData);
            Config.networkServicesSettings = JSONx.parse(networkServicesSettings);
            Macros.RegisterCommentsData(comments);

            Logger.add("Config: Loaded");
            GlobalEventDispatcher.dispatchEvent( { type: Defines.E_CONFIG_LOADED } );
        }
        catch (e:Error)
        {
            Logger.add("CONFIG LOAD ERROR: " + e.message);
        }
    }
}
