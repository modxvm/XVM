/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Stat;

// Class for legacy config OTMData.xml
class wot.utils.ConfigOld
{
  // Private vars
  public static var s_config: Object = null;
  private static var s_loaded: String = "";
  private static var s_load_last_stat: Boolean = false;

  // Load mod config; config data is shared between all marker instances, so
  // it should be loaded only once per session. s_loaded flag indicates that
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

      ConfigOld.s_config = net.produxion.util.XML2Object.deserialize(this);
      ConfigOld.s_config = ConfigOld.s_config["overTargetMarkers"];

      if (ConfigOld.s_load_last_stat && ConfigOld.bool("rating/showPlayersStatistics/data"))
        Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
    };
    xml.load(filename);
  }

  public static function int(path: String, defaultValue: Number): Number
  {
    if (!defaultValue)
      defaultValue = 0;
    var value = parseInt(string(path));
    return isNaN(value) ? defaultValue : value;
  }

  public static function bool(path: String, trueIsDefault: Boolean): Boolean
  {
    var v = value(path).toLowerCase();
    return trueIsDefault ? v != "false" : v == "true";
  }

  public static function string(path: String, defaultValue: String): String
  {
    var value = value(path);
    return value ? String(value) : defaultValue;
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
