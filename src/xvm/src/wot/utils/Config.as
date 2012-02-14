/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Stat;

class wot.utils.Config
{
  // Private vars
  public static var s_config: Object = null;
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
    if (filename.toLowerCase() != "otmdata.xml")
    {
      // new config
      var lv:LoadVars = new LoadVars();
      lv.onData = function(str)
      {
        Config.s_config = net.wargaming.io.JSON.parse(str);
        if (Config.s_load_last_stat && Config.value("rating/showPlayersStatistics") == "true")
          Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
      };
      lv.load(filename);
    }
    else
    {
      // legacy config
      var xml:XML = new XML();
      xml.ignoreWhite = true;
      xml.onLoad = function(success)
      {
        if (!success)
          return;

        Config.s_config = net.produxion.util.XML2Object.deserialize(this);
        Config.s_config = Config.s_config["overTargetMarkers"];

        if (Config.s_load_last_stat && Config.value("rating/showPlayersStatistics/data") == "true")
          Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
      };
      xml.load(filename);
    }
  }

  public static function int(path: String)
  {
    return parseInt(value(path));
  }
  
  public static function bool(path: String, trueIsDefault: Boolean)
  {
    var v = value(path).toLowerCase();
    return trueIsDefault ? v != "false" : v == "true";
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
