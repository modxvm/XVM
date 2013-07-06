/**
 * ...
 * @author sirmax2
 */
import com.xvm.ConfigLoader;

class com.xvm.Config
{
    // Public vars
    public static var s_config:Object;
    public static var s_loaded:Boolean = false;
    public static var s_game_region:String = null;
    public static var s_game_language:String = null;
    public static var s_vars:Object = {
        window_size: [ 1024, 768 ],
        map_name: ""
    }

    // Load XVM mod config; config data is shared between all marker instances, so
    // it should be loaded only once per session. s_loaded flag indicates that
    // we've already initialized config loading process.
    public static function LoadConfig(src: String)
    {
        ConfigLoader.LoadConfig(src);
    }
}
