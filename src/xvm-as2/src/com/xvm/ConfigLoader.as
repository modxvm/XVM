/**
 * ...
 * @author sirmax2
 */
import com.xvm.Cmd;
import com.xvm.Config;
import com.xvm.ConfigUtils;
import com.xvm.DefaultConfig;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONxLoader;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.VehicleInfo;

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

        VehicleInfo.populateData();

        ConfigLoader.s_loading = true;
        Config.s_config = DefaultConfig.config;
        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + Defines.CONFIG_FILE_NAME, this, ReloadConfigCallback);
    }

    private function ReloadConfigCallback(event)
    {
        //Logger.add("TRACE: ReloadConfigCallback(): start");
        if (event.error != null && event.error.type == "NO_FILE")
        {
            if (event.filename == Defines.CONFIG_FILE_NAME)
            {
                // xvm.xc not found, try to load legacy config XVM.xvmconf
                JSONxLoader.LoadAndParse(Defines.CONFIG_FILE_NAME_XVMCONF, this, ReloadConfigCallback);
                return;
            }
        }

        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice.
        try
        {
            ProcessConfig(event);
            ConfigUtils.TuneupConfig();
        }
        finally
        {
            //Logger.add("TRACE: ReloadConfigCallback(): finally:start");
            if (finallyBugWorkaround)
                return;
            finallyBugWorkaround = true;
            Cmd.getGameRegion(this, OnGameRegionReceived);

            //Logger.add("TRACE: ReloadConfigCallback(): finally::end");
        }
        //Logger.add("TRACE: ReloadConfigCallback(): end");
    }

    private function ProcessConfig(event)
    {
        if (event.error != null && event.error.type == "NO_FILE")
        {
            info_event = { type: Config.E_SET_INFO, warning: "" };
            GlobalEventDispatcher.dispatchEvent(info_event);
            return;
        }

        if (event.error != null)
        {
            var ex = event.error;

            var text:String = "Error loading config file '" + event.filename + "': ";
            text += ConfigUtils.parseErrorEvent(event);

            info_event = { type: Config.E_SET_INFO, error: text };
            GlobalEventDispatcher.dispatchEvent(info_event);
            Logger.add(String(text).substr(0, 200));
            return;
        }

        Config.s_config = ConfigUtils.MergeConfigs(ConfigUtils.FixConfig(event.data), Config.s_config);
        //Logger.addObject(Config.s_config, "config", 2);
        //Logger.addObject(Config.s_config.markers.enemy.alive.normal, "", 3);
        info_event = { type: Config.E_SET_INFO };
        GlobalEventDispatcher.dispatchEvent(info_event); // Just show version
    }

    private function OnGameRegionReceived(region:String)
    {
        Config.s_game_region = region.toUpperCase();
        loadLanguage();  // run Stage 3

    }

    // STAGE 3

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
        //Logger.add("Config: Loaded");
        GlobalEventDispatcher.removeEventListener(Locale.EVENT_LOADED);
        Config.s_loaded = true;
        ConfigLoader.s_loading = false;
        GlobalEventDispatcher.dispatchEvent( { type: Config.E_CONFIG_LOADED } );
    }
}
