/**
 * ...
 * @author sirmax2
 */
import net.produxion.util.XML2Object;
import wot.utils.Defines;
import wot.utils.Stat;

class wot.utils.Config
{
  // Private vars
  private static var s_config: Object = null;
  private static var s_loaded: String = "";
  private static var s_load_last_stat: Boolean = false;

  // Load OTM mod config; config data is shared between all marker instances, so
  // it should be loaded only once per session. _ConfigLoaded flag indicates that
  // we've already initialized config loading process.
  public static function LoadConfig(filename: String)
  {
    var fn = filename || Defines.DEFAULT_CONFIG_NAME;
    if (s_loaded == fn)
      return;
    s_loaded = fn;
    ReloadConfig(fn);
  }

  public static function LoadConfigAndStat(filename: String)
  {
    s_load_last_stat = true;
    LoadConfig(filename);
  }

  public static function ReloadConfig(filename)
  {
    var xml:XML = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success)
    {
      if (!success)
        return;

      Config.s_config = XML2Object.deserialize(this);
      if (Config.s_config.hasOwnProperty("xvmconfig"))
      {
        // new config
        Config.s_config = Config.s_config["xvmconfig"];
        if (Config.s_load_last_stat && Config.value("battle/showPlayerStatictics/data") == "true")
          Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
      }
      else
      {
        // legacy config
        Config.s_config = Config.s_config["overTargetMarkers"];
      }
    };
    xml.load(filename);
  }
  
  public static function value(path: String)
  {
    var p: Array = path.split("/"); // "path/to/value"

    // Start from root element
    var root = s_config;

    for (var i = 0; i < p.length; i++)
    {
      // Create child if not exist
      if (!root.hasOwnProperty(p[i]))
        return undefined;
      // Shift root to next child
      root = root[p[i]];
    }

    // Return value
    return root;
  }
}
