/**
 * ...
 * @author sirmax2
 */
import net.produxion.util.XML2Object;
import wot.utils.Defines;

class wot.utils.Config
{
  // Config
  public static var s_config = null;
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

  public static function ReloadConfig(filename)
  {
    var xml:XML = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success)
    {
      if (success)
        Config.s_config = XML2Object.deserialize(this).xvmconfig;
    };
    xml.load(filename);
  }
}
