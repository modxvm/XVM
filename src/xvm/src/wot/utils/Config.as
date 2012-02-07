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
  private static var s_config = null;
  private static var s_loaded = false;

  // Load OTM mod config; config data is shared between all marker instances, so
  // it should be loaded only once per session. _ConfigLoaded flag indicates that
  // we've already initialized config loading process.
  public static function LoadConfig()
  {
    if (s_loaded)
      return;

    s_loaded = true;

    ReloadConfig(Defines.DEFAULT_CONFIG_NAME);
  }

  private static var s_load_last_stat = false;
  public static function LoadConfigAndStat()
  {
    s_load_last_stat = true;
    LoadConfig();
  }
  
  public static function ReloadConfig(filename)
  {
    var xml:XML = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success)
    {
      if (!success)
        return;

      Config.s_config = XML2Object.deserialize(this).xvmconfig;
      if (Config.s_load_last_stat && Config.value("battle/showPlayerStatictics/data") == "true")
        Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
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
