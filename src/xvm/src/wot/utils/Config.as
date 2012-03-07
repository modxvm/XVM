/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Logger;
import wot.utils.Stat;
import wot.utils.Utils;

class wot.utils.Config
{
  public static var DEBUG_TIMES = false;

  // Private vars
  public static var s_config: Object;
  private static var s_loaded: Boolean = false;
  private static var s_load_last_stat: Boolean = false;
  private static var s_load_legacy_config: Boolean = false;
  private static var s_config_filename: String = "";

  // Load XVM mod config; config data is shared between all marker instances, so
  // it should be loaded only once per session. s_loaded flag indicates that
  // we've already initialized config loading process.
  public static function LoadConfig(filename: String)
  {
    if (s_loaded)
      return;
    s_loaded = true;
    s_config_filename = filename || Defines.DEFAULT_CONFIG_NAME;
    ReloadConfig();
  }

  public static function LoadConfigAndStat(filename: String)
  {
    s_load_last_stat = true;
    LoadConfig(filename);
  }

  public static function LoadConfigAndStatLegacy(filename: String)
  {
    s_load_legacy_config = true;
    LoadConfigAndStat(filename);
  }

  public static function ReloadConfig()
  {
    Config.s_config = wot.utils.DefaultConfig.config;
    if (s_load_legacy_config)
      ReloadLegacyConfig();
    else
      ReloadXvmConfig();
  }
  
  public static function ReloadLegacyConfig()
  {
    var start = new Date();
    var xml:XML = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success: Boolean)
    {
      try
      {
        var diff = 0;
        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadLegacyConfig(): Load:  " + (curr - diff) + " ms");
          diff = curr;
        }

        if (!success)
          return;

        var config = net.produxion.util.XML2Object.deserialize(xml);
        config = config["overTargetMarkers"];
        if (!config)
          return;

        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadLegacyConfig(): Parse: " + (curr - diff) + " ms");
          diff = curr;
        }

        config = wot.utils.OTMConfigConverter.convert(config);
        Config.s_config = Config.MergeConfigs(Config.FixConfig(config), Config.s_config);
        //Logger.addObject(Config.s_config);
        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadLegacyConfig(): Apply: " + (curr - diff) + " ms");
        }
      }
      finally
      {
        Config.ReloadXvmConfig();
      }
    };
    xml.load("OTMData.xml");
  }


  private static function ReloadXvmConfig()
  {
    var start = new Date();
    var lv:LoadVars = new LoadVars();
    lv.onData = function(str: String)
    {
      if (str)
      {
        var diff = 0;
        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadXvmConfig(): Load:  " + (curr - diff) + " ms");
          diff = curr;
        }
        try
        {
          var config = wot.utils.JSON.parse(str);
          
          if (Config.DEBUG_TIMES)
          {
            var curr = Utils.elapsedMSec(start, new Date());
            Logger.add("DEBUG TIME: ReloadXvmConfig(): Parse: " + (curr - diff) + " ms");
            diff = curr;
          }
          if (!config)
            wot.BattleLoading.setInfoFieldData( { error: "Error parsing config file. Using default settings." } );
          else
          {
            Config.s_config = Config.MergeConfigs(Config.FixConfig(config), Config.s_config);
            //Logger.addObject(Config.s_config);
            if (Config.DEBUG_TIMES)
            {
              var curr = Utils.elapsedMSec(start, new Date());
              Logger.add("DEBUG TIME: ReloadXvmConfig(): Apply: " + (curr - diff) + " ms");
            }
          }
        }
        catch (ex)
        {
          var txt = str.substring(ex.at - 50, ex.at - 1) + ">>>" + str.charAt(ex.at) + "<<<" + str.substr(ex.at + 1, 50);
          txt = txt.split("\r").join("").split("\n").join("");
          while (txt.indexOf("  ") != -1)
            txt = txt.split("  ").join(" ");
          wot.BattleLoading.setInfoFieldData( { error: "Error loading config file. Using default settings.\n" + 
            "[" + Utils.trim(ex.at) + "] " + Utils.trim(ex.name) + ": " + Utils.trim(ex.message) + "\n  " + txt } );
        }
      }
      else
      {
        wot.BattleLoading.setInfoFieldData({ error: "Error loading config file. Using default settings." });
      }
      if (Config.s_load_last_stat && Config.s_config.rating.showPlayersStatistics)
        Stat.LoadStatData(Defines.COMMAND_GET_LAST_STAT);
    };
    lv.load(s_config_filename);
  }

  /**
   * Recursive walt default config and merge with loaded values.
   */
  private static function MergeConfigs(config, def, prefix)
  {
    if (!prefix)
      prefix = "def";

    switch (typeof def)
    {
      case 'object':
        if (def instanceof Array)
        {
          // warning: arrays are not checked now
          //Logger.add(prefix + " = [ ]");
          return (config instanceof Array) ? config : def;
        }
        var result = { };
        for (var name in def)
        {
          //Logger.add(prefix + "." + name);
          result[name] = config.hasOwnProperty(name) ? MergeConfigs(config[name], def[name], prefix + "." + name) : def[name];
        }
        return result;

      case 'number':
        //Logger.add(prefix + " = number " + config + " = " + def);
        return isFinite(config) ? Number(config) : def;

      case 'boolean':
        //Logger.add(prefix + " = boolean " + config + " = " + def);
        if (typeof config == 'boolean')
          return config;
        if (typeof config == 'string')
          return config.toLowerCase() == "true";
        return def;

      case 'string':
        //Logger.add(prefix + " = string " + config + " = " + def);
        return (typeof config == 'string') ? config : def;
        return def;

      default:
        //Logger.add(prefix + " = default " + (typeof def) + " = " + config + " = " + def);
        return (typeof config == 'string') ? config : def;
    }
  }
   
  /**
   * Convert config to new format.
   */
  private static function FixConfig(config)
  {
    if (!config)
      return undefined;

    var v: String = config.configVersion;

    if (!v || v == "")
    {
      // Convert OTMData.xml => XVM 1.0.0
      //xml = instance.EncodeXML(new OTMConfigConverter((new PatchedXMLDecoder().decode(xml))).config);
      //throw new Error(xml.toXMLString());
      v = "1.0.0";
    }

    if (v == "1.0.0")
    {
      // Convert XVM 1.0.0 => 1.1.0
      if (config.battle)
      {
        config.battle.mirroredVehicleIcons = Utils.toBool(config.battle.mirroredVehicleIcons, true);
        config.battle.showPostmortemTips = Utils.toBool(config.battle.showPostmortemTips, true);
        config.battle.drawGrid = Utils.toBool(config.battle.drawGrid, false);
      }

      if (config.rating)
      {
        config.rating.showPlayersStatistics = Utils.toBool(config.rating.showPlayersStatistics, false);
        if (config.rating.battleLoading)
          config.rating.battleLoading.show = Utils.toBool(config.rating.battleLoading.show, true);
        if (config.rating.playersPanel)
          config.rating.playersPanel.show = Utils.toBool(config.rating.playersPanel.show, true);
        if (config.rating.statisticForm)
          config.rating.statisticForm.show = Utils.toBool(config.rating.statisticForm.show, true);
        if (config.rating.colors)
        {
          config.colors = config.rating.colors;
          delete config.rating.colors;
        }
      }

      v = "1.1.0";
    }

/*
    if (v == "1.0.x")
    {
      // Convert XVM 1.0.x => 1.0.y
    }
*/
    return config;
  }

}
