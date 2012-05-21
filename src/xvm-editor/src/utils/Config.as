/**
 * ...
 * @author sirmax2
 */
package utils
{
  import utils.Defines;
  import utils.Utils;

  public class Config
  {
    // Private vars
    public static var s_config: Object;

    /**
     * Recursive walt default config and merge with loaded values.
     */
    public static function MergeConfigs(config:*, def:*, prefix: String = null):*
    {
      if (!prefix)
        prefix = "def";

      switch (typeof def)
      {
        case 'object':
          if (def is Array)
          {
            // warning: arrays are not checked now
            return (config is Array) ? config : def;
          }
          var result:* = { };
          for (var name:String in def)
          {
            result[name] = config.hasOwnProperty(name) ? MergeConfigs(config[name], def[name], prefix + "." + name) : def[name];
          }
          return result;

        case 'number':
          if (isFinite(config))
            return Number(config);
          if (typeof config == 'string')
            return config;
          return def;

        case 'boolean':
          if (typeof config == 'boolean')
            return config;
          if (typeof config == 'string')
            return config.toLowerCase() == "true";
          return def;

        case 'string':
          return (typeof config == 'string') ? config : def;

		case 'undefined':
		case 'null':
		  return (typeof config == 'string' || typeof config == 'number') ? config : def;

        default:
          return def;
        }
    }

    /**
     * Modify some parameters to be with correct format.
     */
    public static function TuneupConfig():void
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
	 * Get config value
	 */
	public static function GetValue(path:String, root:Object = null):*
	{
		if (root == null)
			root = s_config;
		if (!root)
			return null;

		var p:Array = path.split("."); // "path.to.value"
		var valueElement:String = p.pop(); // last element is value

		for each (var e:String in p)
		{
			// Create shild if not exist
			if (!root.hasOwnProperty(e))
				return undefined;
			// Shift root to next child
			root = root[e];
		}

		return root[valueElement];
	}

	/**
	 * Set config value
	 */
	public static function SetValue(path:String, value:*, root:Object = null):void
	{
		if (root == null)
			root = s_config;
		if (!root)
			return;

		var p:Array = path.split("."); // "path.to.value"
		var valueElement:String = p.pop(); // last element is value

		for each (var e:String in p)
		{
			// Create shild if not exist
			if (!root.hasOwnProperty(e))
				root[e] = new Object();
			// Shift root to next child
			root = root[e];
		}

		// Set value
		if (value != null)
			root[valueElement] = value;
		else
			delete root[valueElement];
	}

	public static function SetDefaultValue(path:String):Boolean
	{
		var defValue:Object = GetValue(path, DefaultConfig.config);
		if (defValue == null)
			return false;

		Config.SetValue(path, defValue);
		Config.TuneupConfig();
		return true;
	}
	
    /**
     * Convert config to new format.
     */
    public static function FixConfig(config:*):*
    {
      if (!config)
        return undefined;

      var v: String = config.configVersion;

      if (!v || v == "")
        v = "1.0.0";

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
}