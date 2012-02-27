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
  private static var s_config_cache: Object = { };

  // Load XVM mod config; config data is shared between all marker instances, so
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
    var lv:LoadVars = new LoadVars();
    lv.onData = function(str)
    {
      Config.s_config = net.wargaming.io.JSON.parse(str);
      if (Config.s_load_last_stat && Config.bool("rating/showPlayersStatistics"))
        Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
    };
    lv.load(filename);
  }


  public static function int(path: String, defaultValue: Number): Number
  {
    if (!Config.s_config)
      return undefined;
    if (s_config_cache.hasOwnProperty(path))
      return s_config_cache[path];

    if (!defaultValue)
      defaultValue = 0;
    var v = value(path);
    var n: Number = parseInt(v);
    n = isNaN(n) ? defaultValue : n;
    s_config_cache[path] = n;
    return n;
  }

  public static function bool(path: String, trueIsDefault: Boolean): Boolean
  {
    if (!Config.s_config)
      return undefined;
    if (s_config_cache.hasOwnProperty(path))
      return s_config_cache[path];
    var v = value(path).toLowerCase();
    var b = trueIsDefault ? v != "false" : v == "true";
    s_config_cache[path] = b;
    return b;
  }

  public static function string(path: String, defaultValue: String): String
  {
    if (!Config.s_config)
      return undefined;
          
    if (s_config_cache.hasOwnProperty(path))
      return s_config_cache[path];
    var v = value(path);
    v = v ? String(v) : defaultValue;
    s_config_cache[path] = v;
    return v;
  }

  public static function value(path: String)
  {
    if (!Config.s_config)
      return undefined;
          
    if (s_config_cache.hasOwnProperty(path))
      return s_config_cache[path];

    var p: Array = path.split("/"); // "path/to/value"

    // Start from root element
    var root = s_config;

    for (var i = 0; i < p.length; i++)
    {
      // Create child if not exist
      if (!root.hasOwnProperty(p[i]))
      {
        s_config_cache[path] = undefined;
        return undefined;
      }
      // Shift root to next child
      root = root[p[i]];
    }

    // Return value
    s_config_cache[path] = root;
    return root;
  }
}
