/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;

class com.xvm.ConfigLoader
{
    // Private vars
    private static var s_loading:Boolean = false;
    private static var info_event:Object = null;

    // instance
    private static var instance:ConfigLoader = null;

    // Load XVM mod config; config data is shared between all marker instances, so
    // it should be loaded only once per session. s_loaded flag indicates that
    // we've already initialized config loading process.
    public static function LoadConfig()
    {
        //Logger.add("TRACE: LoadConfig()");
        if (Config.s_loaded)
        {
            if (info_event != null)
            {
                // Use set timeout to avoid overriding by default value
                _global.setTimeout(function() { GlobalEventDispatcher.dispatchEvent(ConfigLoader.info_event); }, 1);
            }
            GlobalEventDispatcher.dispatchEvent({type: Config.E_CONFIG_LOADED});
            return;
        }

        if (instance == null)
            instance = new ConfigLoader();
        instance.ReloadConfig();
    }

    private function ReloadConfig()
    {
        //Logger.add("TRACE: ReloadConfig()");
        if (ConfigLoader.s_loading)
            return;

        ConfigLoader.s_loading = true;
        Cmd.getConfig(this, GetConfigCallback);
    }

    // STAGE 1

    private function GetConfigCallback(data:String)
    {
        try
        {
            Config.s_config = JSONx.parse(data);
            //Logger.addObject(Config.s_config);
        }
        catch (e:Error)
        {
            Logger.add(e.message);
        }

        Cmd.getVehicleInfoData(instance, OnVehicleInfoData);
    }

    // STAGE 2

    private function OnVehicleInfoData(data:String)
    {
        VehicleInfo.onVehicleInfoData(data);
        Cmd.getGameRegion(this, OnGameRegionReceived);
    }

    // STAGE 3

    private function OnGameRegionReceived(region:String)
    {
        Config.s_game_region = region.toUpperCase();
        loadLanguage();  // run Stage 3
    }

    // STAGE 4

    private function loadLanguage()
    {
        //Logger.add("TRACE: STAGE 3: loadLanguage()");

        var autoDetection:Boolean = Config.s_config.language.toLowerCase() == Defines.LOCALE_AUTO_DETECTION;
        if (autoDetection)
            Cmd.getLanguage(this, loadLanguageCallback);
        else
            loadLanguageCallback(Config.s_config.language);
    }

    private function loadLanguageCallback(language:String)
    {
        Config.s_config.language = language.toLowerCase();
        GlobalEventDispatcher.addEventListener(Locale.EVENT_LOADED, this, SetConfigLoaded);
        Locale.loadLocaleFile();
    }

    // All done

    private function SetConfigLoaded()
    {
        Logger.add("Config: Loaded");
        GlobalEventDispatcher.removeEventListener(Locale.EVENT_LOADED);
        Config.s_loaded = true;
        ConfigLoader.s_loading = false;
        GlobalEventDispatcher.dispatchEvent( { type: Config.E_CONFIG_LOADED } );
    }
}
