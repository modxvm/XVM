/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;

class wot.utils.Config
{
  public static var DEBUG_TIMES = false;
  public static var DEBUG_TUNING = false;

  // Private vars
  public static var s_config: Object;
  public static var s_loaded: Boolean = false;
  public static var s_game_region: String = null;
  private static var s_loading: Boolean = false;
  private static var s_load_legacy_config: Boolean = false;
  private static var s_load_complete_funcs: Array = []; // Static only
  private static var s_config_filename: String = "";
  private static var s_src: String = "";

  // Load XVM mod config; config data is shared between all marker instances, so
  // it should be loaded only once per session. s_loaded flag indicates that
  // we've already initialized config loading process.
  public static function LoadConfig(src: String, filename: String, legacy: Boolean, completeFunc: Function)
  {
    //Logger.add("TRACE: LoadConfig()");
    if (s_loaded)
    {
      if (Utils.indexOf(s_load_complete_funcs, completeFunc) == -1)
        completeFunc.call();
      return;
    }
    s_src = src || "";
    s_config_filename = filename || Defines.DEFAULT_CONFIG_NAME;
    s_load_legacy_config = legacy ? true : false;
    if (Utils.indexOf(s_load_complete_funcs, completeFunc) == -1)
      s_load_complete_funcs.push(completeFunc);
    ReloadConfig();
  }

  private static function ReloadConfig()
  {
    //Logger.add("TRACE: Config.ReloadConfig()");
    if (s_loading)
      return;
    s_loading = true;

    Config.s_config = wot.utils.DefaultConfig.config;
    if (s_load_legacy_config)
      ReloadLegacyConfig();
    else
      ReloadXvmConfig();
  }

  private static function ReloadLegacyConfig()
  {
    //Logger.add("TRACE: Config.ReloadLegacyConfig()");
    var start = new Date();
    if (Config.DEBUG_TIMES)
      Logger.add("DEBUG TIME: ReloadLegacyConfig(): Start " + s_src);
    var xml:XML = new XML();
    xml.ignoreWhite = true;
    xml.onLoad = function(success: Boolean)
    {
      var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How? F*ck!
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

        var config = com.produxion.util.XML2Object.deserialize(xml);
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
        //Logger.addObject(Config.s_config.markers.enemy.dead);
        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadLegacyConfig(): Apply: " + (curr - diff) + " ms");
        }
      }
      finally
      {
        if (finallyBugWorkaround)
          return;
        finallyBugWorkaround = true;
        Config.ReloadXvmConfig();
      }
    };
    xml.load("OTMData.xml");
  }

  private static function ReloadXvmConfig()
  {
    //Logger.add("TRACE: Config.ReloadXvmConfig()");
    var start = new Date();
    if (Config.DEBUG_TIMES)
      Logger.add("DEBUG TIME: ReloadXvmConfig(): Start " + s_src);

    var lv:LoadVars = new LoadVars();
    lv.onData = function(str: String)
    {
//Logger.add("ReloadXvmConfig::onData::start");
      var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times. Why? How? F*ck!
      try
      {
        Config.ProcessXvmConfig(str, start);
        Config.TuneupConfig();
      }
      finally
      {
//Logger.add("ReloadXvmConfig::onData::finally:start");
        if (finallyBugWorkaround)
          return;
        finallyBugWorkaround = true;
        if (Config.s_config.rating.showPlayersStatistics)
          Config.ReloadGameRegion();
        else
          Config.SetConfigLoaded();
//Logger.add("ReloadXvmConfig::onData::finally::end");
      }
//Logger.add("ReloadXvmConfig::onData::end");
    };
    lv.load(s_config_filename);
  }

  private static function ProcessXvmConfig(str: String, start: Date)
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
        var config = com.xvm.JSON.parse(str);

        if (Config.DEBUG_TIMES)
        {
          var curr = Utils.elapsedMSec(start, new Date());
          Logger.add("DEBUG TIME: ReloadXvmConfig(): Parse: " + (curr - diff) + " ms");
          diff = curr;
        }

        if (!config)
        {
          if (_global.xvm_battleloading)
            _global.xvm_battleloading.setInfoFieldData( { error: "Error parsing config file. Using default settings." } );
        }
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
        var txt = str.substring(ex.at - 100, ex.at - 1) + ">>>" + str.charAt(ex.at) + "<<<" + str.substr(ex.at + 1, 100);
        txt = txt.split("\r").join("").split("\n").join("");
        while (txt.indexOf("  ") != -1)
          txt = txt.split("  ").join(" ");
        if (_global.xvm_battleloading)
        {
          _global.xvm_battleloading.setInfoFieldData( { error: "Error loading config file. Using default settings.\n" +
              "[" + ex.at + "] " + Utils.trim(ex.name) + ": " + Utils.trim(ex.message) + "\n  " + txt } );
        }
      }
    }
    else
    {
      if (_global.xvm_battleloading)
        _global.xvm_battleloading.setInfoFieldData({ warning: " " });
    }
  }

  private static function ReloadGameRegion()
  {
    //Logger.add("TRACE: Config.ReloadGameRegion()");

    var lv: LoadVars = new LoadVars();
    lv.onData = function(str: String)
    {
      var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times. Why? How? F*ck!
      try
      {
        var a: Array = str.split("\n");
        Config.s_game_region = a[0].toUpperCase();
        Locale.setRegion(Config.s_game_region);

        // MAX_PATH is 259 on NTFS
        // WARNING: What if MAX_PATH less then 50?
        //   259 - "\res_mods\.stat\".length - 1 = 242
        // 199 - ?
        Defines.MAX_PATH = Math.min(199, Math.max(50, 242 - a[1].length));
      }
      finally
      {
        if (finallyBugWorkaround)
          return;
        finallyBugWorkaround = true;
        Config.SetConfigLoaded();
      }
    }
    lv.load(Defines.COMMAND_GET_VERSION);
  }

  private static function SetConfigLoaded()
  {
    Logger.add("Config: Loaded (" + s_src + ")");
    s_loaded = true;
    s_loading = false;
    TuneConfigForServerRegion();
    for (var i = 0; i < s_load_complete_funcs.length; ++i)
      s_load_complete_funcs[i].call();
  }

  private static var useFallback: Boolean = false;
  private static function TuneConfigForServerRegion()
  {
    var region = Config.s_game_region;
    useFallback = !region || useFallback;
    var root: String = "";
    var folders: Array = [];
    for (var i in s_config.players)
    {
      var ele = s_config.players[i];
      if (ele.root != null && ele.folders != null)
      {
        root = ele.root;
        if (root != "" && root.charAt(root.length - 1) != "/")
          root += "/";
        folders = ele.folders.split(',');
        folders = Utils.removeDuplicatesAndTrim(folders);
        break;
      }
    }
    if (Config.DEBUG_TUNING)
    {
      Logger.add("DEBUG TUNING TuneConfigForServer: " + region + ": Begin:");
      for (var i = 0; i < s_config.players.length; ++i)
        Logger.addObject(s_config.players[i], "players");
    }

    var subsections: Array = [];
    for (var i in s_config.players)
    {
      var ele = s_config.players[i];
      if (ele.folder != undefined)
      { // check if folder matches game version or fallback should be used
        if (ele.folder.toUpperCase() == region || useFallback)
        { // check if folder is in folders
          for (var j in folders)
          {
            var folder = folders[j];
            if (folder.toUpperCase() == ele.folder.toUpperCase())
            {
              if (Config.DEBUG_TUNING)
              {
                Logger.add("DEBUG TUNING: TuneConfigForServer: " + region + ": Found:");
                for (var k = 0; k < ele.players.length; ++k)
                  Logger.addObject(ele.players[k], "players");
              }
              ele.players = Utils.addRootFor(ele.players, root + ele.folder + "/");
              subsections = ele.players.concat(subsections);
              break;
            }
          }
        }
      }
    }
    s_config.players = subsections;
    if (Config.DEBUG_TUNING)
    {
      Logger.add("DEBUG TUNING: TuneConfigForServer: " + region + ": Finished:");
      for (var i = 0; i < s_config.players.length; i++)
        Logger.addObject(s_config.players[i], "players");
    }
  }

  /**
   * Recursive walt default config and merge with loaded values.
   */
  private static function MergeConfigs(config, def, prefix: String)
  {
    if (!prefix)
      prefix = "def";

    //if (prefix.indexOf("damageText.color") >= 0)
    //  Logger.add(prefix + " def=" + def + " config=" + config);

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
          /*if (prefix.indexOf("damageText") >= 0 && name == "color")
          {
            Logger.add(prefix + " " + name + " def=" + def + " config=" + config + " c[n]=" + config[name]);
            Logger.addObject(config, "config");
          }*/
          result[name] = config.hasOwnProperty(name) ? MergeConfigs(config[name], def[name], prefix + "." + name) : def[name];
        }
        return result;

      case 'number':
        //Logger.add(prefix + " = number " + config + " = " + def);
        if (isFinite(config))
          return Number(config);
        if (typeof config == 'string')
          return config;
        return def;

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

      case 'undefined':
      case 'null':
        //if (prefix.indexOf("damageText") >= 0)
        //  Logger.add(prefix + " t(def)=" + (typeof def) + " def=" + def + " t(config)=" + (typeof config) + " config=" + config);
        return (typeof config == 'string' || typeof config == 'number') ? config : def;

      default:
        //Logger.add("unknown type = " + (typeof def) + " prefix=" + prefix);
        return def;
      }
  }

  /**
   * Modify some parameters to be with correct format.
   */
  private static function TuneupConfig()
  {
    Config.s_config.iconset.battleLoading = Utils.fixPath(Config.s_config.iconset.battleLoading);
    Config.s_config.iconset.playersPanel = Utils.fixPath(Config.s_config.iconset.playersPanel);
    Config.s_config.iconset.statisticForm = Utils.fixPath(Config.s_config.iconset.statisticForm);
    Config.s_config.iconset.vehicleMarker = Utils.fixPath(Config.s_config.iconset.vehicleMarker);

    if (isNaN(Config.s_config.battleLoading.clanIcon.xr))
      Config.s_config.battleLoading.clanIcon.xr = Config.s_config.battleLoading.clanIcon.x;
    if (isNaN(Config.s_config.battleLoading.clanIcon.yr))
      Config.s_config.battleLoading.clanIcon.yr = Config.s_config.battleLoading.clanIcon.y;
    if (isNaN(Config.s_config.statisticForm.clanIcon.xr))
      Config.s_config.statisticForm.clanIcon.xr = Config.s_config.statisticForm.clanIcon.x;
    if (isNaN(Config.s_config.statisticForm.clanIcon.yr))
      Config.s_config.statisticForm.clanIcon.yr = Config.s_config.statisticForm.clanIcon.y;
    if (isNaN(Config.s_config.playersPanel.clanIcon.xr))
      Config.s_config.playersPanel.clanIcon.xr = Config.s_config.playersPanel.clanIcon.x;
    if (isNaN(Config.s_config.playersPanel.clanIcon.yr))
      Config.s_config.playersPanel.clanIcon.yr = Config.s_config.playersPanel.clanIcon.y;
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

    if (v == "1.1.0")
    {
      // Convert XVM 1.1.0 => 1.2.0
      config.battleLoading = { };
      config.statisticForm = { };
      config.playersPanel = { };
      config.playersPanel.medium = { };
      config.playersPanel.large = { };

      if (config.battle)
      {
        config.battleLoading.showClock = Utils.toBool(config.battle.battleLoadingShowClock, true);
        config.playersPanel.alpha = Utils.toInt(config.battle.playersPanelAlpha, 100);
        config.playersPanel.large.width = Utils.toInt(config.battle.playersPanelLargeWidth, 170); // TODO: * coef
      }

      if (config.rating)
      {
        if (config.rating.battleLoading && config.rating.battleLoading.format)
        {
          config.battleLoading.formatLeft = config.rating.battleLoading.format;
          config.battleLoading.formatRight = config.rating.battleLoading.format;
        }
        if (config.rating.statisticForm && config.rating.statisticForm.format)
        {
          config.statisticForm.formatLeft = config.rating.statisticForm.format;
          config.statisticForm.formatRight = config.rating.statisticForm.format;
        }
        if (config.rating.playersPanel)
        {
          if (config.rating.playersPanel.format)
          {
            config.playersPanel.large.nickFormatLeft = config.rating.playersPanel.format + " {{nick}}";
            config.playersPanel.large.nickFormatRight = "{{nick}} " + config.rating.playersPanel.format;
          }
          if (config.rating.playersPanel.middleColor)
          {
            config.playersPanel.medium.formatLeft = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
            config.playersPanel.medium.formatRight = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
          }
        }
      }

      v = "1.2.0";
    }

    if (v == "1.2.0")
    {
      if (config.players)
      {
        config.players = [
          { root: "", folders: "" },
          { folder: "", players: config.players }
        ];
        Config.useFallback = true;
      }
      v = "1.3.0";
    }

/*
    if (v == "1.x.x")
    {
      // Convert XVM 1.x.x => 1.y.y
    }
*/

    config.configVersion = v;
    return config;
  }

}
