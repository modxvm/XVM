/**
 * ...
 * @author sirmax2
 */
package utils
{
    import mx.collections.XMLListCollection;

    import utils.Defines;
    import utils.Utils;

    public class Config
    {
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
                    if (def == null)
                        return (typeof config == 'string' || typeof config == 'number') ? config : null;
                    var result: Object = { };
                    for (var name:String in def)
                    {
                        result[name] = config.hasOwnProperty(name)
                            ? MergeConfigs(config[name], def[name], prefix + "." + name)
                            : def[name];
                    }
                    return result;

                case 'number':
                    if (!isNaN(parseFloat(config)))
                        return parseFloat(config);
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
                    return (config == null || typeof config == 'string') ? config : def;

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
            Config.s_config.battle.clanIconsFolder = Utils.fixPath(Config.s_config.battle.clanIconsFolder);

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

        public static function FixConfig(config:Object):Object
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
                    if (config.battle.mirroredVehicleIcons != null)
                        config.battle.mirroredVehicleIcons = Utils.toBool(config.battle.mirroredVehicleIcons, true);
                    if (config.battle.showPostmortemTips != null)
                        config.battle.showPostmortemTips = Utils.toBool(config.battle.showPostmortemTips, true);
                }

                if (config.rating)
                {
                    if (config.rating.showPlayersStatistics != null)
                        config.rating.showPlayersStatistics = Utils.toBool(config.rating.showPlayersStatistics, false);
                    if (config.rating.battleLoading) {
                        if (config.rating.battleLoading.show != null)
                            config.rating.battleLoading.show = Utils.toBool(config.rating.battleLoading.show, true);
                    }
                    if (config.rating.playersPanel)
                    {
                        if (config.rating.playersPanel.show != null)
                            config.rating.playersPanel.show = Utils.toBool(config.rating.playersPanel.show, true);
                    }
                    if (config.rating.statisticForm)
                    {
                        if (config.rating.statisticForm.show != null)
                            config.rating.statisticForm.show = Utils.toBool(config.rating.statisticForm.show, true);
                    }
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
                if (config.battle)
                {
                    if (config.battle.battleLoadingShowClock != null)
                    {
                        if (!config.battleLoading)
                            config.battleLoading = { };
                        config.battleLoading.showClock = Utils.toBool(config.battle.battleLoadingShowClock, true);
                        delete config.battle.battleLoadingShowClock;
                    }
                    if (config.battle.playersPanelAlpha != null)
                    {
                        if (!config.playersPanel)
                            config.playersPanel = { };
                        config.playersPanel.alpha = Utils.toInt(config.battle.playersPanelAlpha, 100);
                        delete config.battle.playersPanelAlpha;
                    }
                    if (config.battle.playersPanelLargeWidth != null)
                    {
                        if (!config.playersPanel)
                            config.playersPanel = { };
                        config.playersPanel.large = { };
                        config.playersPanel.large.width = Utils.toInt(config.battle.playersPanelLargeWidth, 170);
                        delete config.battle.playersPanelLargeWidth;
                    }
                }

                if (config.rating)
                {
                    if (config.rating.battleLoading)
                    {
                        if (config.rating.battleLoading.format)
                        {
                            if (!config.battleLoading)
                                config.battleLoading = { };
                            config.battleLoading.formatLeft = config.rating.battleLoading.format;
                            config.battleLoading.formatRight = config.rating.battleLoading.format;
                        }
                        delete config.rating.battleLoading;
                    }

                    if (config.rating.statisticForm)
                    {
                        if (config.rating.statisticForm.format != null)
                        {
                            if (!config.statisticForm)
                                config.statisticForm = { };
                            config.statisticForm.formatLeft = config.rating.statisticForm.format;
                            config.statisticForm.formatRight = config.rating.statisticForm.format;
                        }
                        delete config.rating.statisticForm;
                    }

                    if (config.rating.playersPanel)
                    {
                        if (config.rating.playersPanel.format != null)
                        {
                            if (!config.playersPanel)
                                config.playersPanel = { };
                            if (!config.playersPanel.large)
                                config.playersPanel.large = { };
                            config.playersPanel.large.nickFormatLeft = config.rating.playersPanel.format + " {{nick}}";
                            config.playersPanel.large.nickFormatRight = "{{nick}} " + config.rating.playersPanel.format;
                        }
                        if (config.rating.playersPanel.middleColor)
                        {
                            if (!config.playersPanel)
                                config.playersPanel = { };
                            if (!config.playersPanel.medium)
                                config.playersPanel.medium = { };
                            config.playersPanel.medium.formatLeft = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
                            config.playersPanel.medium.formatRight = "<font color='" + config.rating.playersPanel.middleColor + "'>{{nick}}</font>";
                        }
                        delete config.rating.playersPanel;
                    }
                }

                v = "1.2.0";
            }

            if (v == "1.2.0")
                v = "1.3.0";

            if (v == "1.3.0")
            {
                if (config.battleLoading)
                {
                    if (config.battleLoading.showClock != null)
                    {
                        config.battleLoading.clockFormat = config.battleLoading.showClock == true ? "H:N:S" : "";
                        delete config.battleLoading.showClock;
                    }
                    if (config.battleLoading.formatLeft != null)
                        config.battleLoading.formatLeft = "{{vehicle}}" + (config.battleLoading.formatLeft ? " " + config.battleLoading.formatLeft : "");
                    if (config.battleLoading.formatRight != null)
                        config.battleLoading.formatRight = (config.battleLoading.formatRight ? config.battleLoading.formatRight + " " : "") + "{{vehicle}}";
                }
                if (config.statisticForm)
                {
                    if (config.statisticForm.formatLeft != null)
                        config.statisticForm.formatLeft = "{{vehicle}} " + (config.statisticForm.formatLeft ? " " + config.statisticForm.formatLeft : "");
                    if (config.statisticForm.formatRight != null)
                        config.statisticForm.formatRight = (config.statisticForm.formatRight ? config.statisticForm.formatRight + " " : "") + " {{vehicle}}";
                }
                v = "1.4.0";
            }

            if (v == "1.4.0")
            {
                // todo: set battle.clanIconsFolder from config.players..root
                v = "1.5.0";
            }

    /*
            if (v == "1.x.x")
            {
                v = "1.y.y";
            }
    */

            config.configVersion = v;
            return config;
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
//    		if (value === undefined)
//                delete root[valueElement];
            if (value === null || value === undefined) // FIXIT: why undefined presents?
    			root[valueElement] = null;
    		else
                root[valueElement] = value;
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
    }
}
