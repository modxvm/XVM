import com.xvm.JSONxLoader;
import com.xvm.Comm;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;
/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.Config
{
	static public var s_config : Object;
	static public var s_loaded : Boolean;
	static public var s_proxy_available : Boolean;
	static public var s_game_region : String;
	static public var s_vars : Object;
	static private var s_loading : Boolean;
	static private var s_src : String;

	static public function LoadConfig(src:String);

	static private function ReloadConfig();

	static private function ReloadXvmConfigCallback(event);

	static private function ProcessXvmConfig(event);

	static private function ReloadGameRegion();

	static private function GetGameRegionFromWOTLauncherCfg();

	static private function SetConfigLoaded();

	/**
     * Recursive walt default config and merge with loaded values.
     */
	static private function MergeConfigs(config, def, prefix:String);

	/**
     * Modify some parameters to be with correct format.
     */
	static private function TuneupConfig();

	/**
     * Convert config to new format.
     */
	static private function FixConfig(config:Object) : Object;

}