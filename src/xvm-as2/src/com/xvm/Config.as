/**
 * ...
 * @author sirmax2
 */
import com.xvm.ConfigLoader;

class com.xvm.Config
{
    // Constants
    public static var E_CONFIG_LOADED = "config_loaded";
    
    // Public vars
    public static var s_config:Object;
    public static var s_loaded:Boolean = false;
    public static var s_game_region:String = null;

    // Load XVM mod config; config data is shared between all marker instances, so
    // it should be loaded only once per session. s_loaded flag indicates that
    // we've already initialized config loading process.
    public static function LoadConfig()
    {
        ConfigLoader.LoadConfig();
    }
}
