/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.GlobalEventDispatcher;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;

class wot.utils.Config
{
    // Public vars
    public static var s_config: Object;
    public static var s_loaded: Boolean = false;
    public static var s_proxy_available: Boolean = true;
    public static var s_game_region: String = null;
    public static var s_vars: Object = {
        window_size: [ 1024, 768 ],
        map_name: "notset123"
    }

    private static var DEBUG_TIMES = false;
    private static var DEBUG_TUNING = false;

    // Private vars
    private static var s_loading: Boolean = false;
    private static var s_load_legacy_config: Boolean = false;
    private static var s_config_filename: String = "";
    private static var s_src: String = "";

    // Load XVM mod config; config data is shared between all marker instances, so
    // it should be loaded only once per session. s_loaded flag indicates that
    // we've already initialized config loading process.
    public static function LoadConfig(src: String, filename: String, legacy: Boolean)
    {
        //Logger.add("TRACE: LoadConfig()");
        if (s_loaded)
        {
            GlobalEventDispatcher.dispatchEvent({type: "config_loaded"});
            return;
        }
        s_src = src || "";
        s_config_filename = filename || Defines.DEFAULT_CONFIG_NAME;
        s_load_legacy_config = legacy ? true : false;
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
                    Config.GetGameRegionFromWOTLauncherCfg();
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
                    var text = "Error parsing config file. Using default settings.";
                    GlobalEventDispatcher.dispatchEvent( { type: "set_info", error: text } );
                    Logger.add(text);
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
                    GlobalEventDispatcher.dispatchEvent({ type: "set_info" }); // Just show version
                }
            }
            catch (ex)
            {
                var head = ex.at > 0 ? str.substring(0, ex.at) : "";
                head = head.split("\r").join("").split("\n").join("");
                while (head.indexOf("  ") != -1)
                    head = head.split("  ").join(" ");
                head = head.substr(head.length - 75, 75);

                var tail = (ex.at + 1 < str.length) ? str.substring(ex.at + 1, str.length) : "";
                tail = tail.split("\r").join("").split("\n").join("");
                while (tail.indexOf("  ") != -1)
                    tail = tail.split("  ").join(" ");

                var text:String = "Error loading config file: " +
                    "[" + ex.at + "] " + Utils.trim(ex.name) + ": " + Utils.trim(ex.message) + "\n  " +
                    head + ">>>" + str.charAt(ex.at) + "<<<" + tail;
                GlobalEventDispatcher.dispatchEvent( { type: "set_info", error: text } );
                Logger.add(String(text).substr(0, 200));
            }
        }
        else
        {
          GlobalEventDispatcher.dispatchEvent({ type: "set_info", warning: "" });
        }
    }

    private static function ReloadGameRegion()
    {
        //Logger.add("TRACE: Config.ReloadGameRegion()");
        var lv: LoadVars = new LoadVars();
        lv.onData = function(str: String)
        {
            if (!str) // proxy is not running
            {
                Config.s_proxy_available = false;
                Config.GetGameRegionFromWOTLauncherCfg();
                return;
            }

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

                for (var i = 2; i < a.length; ++i)
                {
                    try
                    {
                        var v = a[i].split("=");
                        switch (v[0].toLowerCase())
                        {
                            case "window_size":
                                var sz = v[1].split(",");
                                Config.s_vars.window_size = [ Math.max(800, parseInt(sz[0])), Math.max(600, parseInt(sz[1])) ];
                                break;
                            case "map_name":
                                var mapName:String = v[1];
                                Config.s_vars.map_name = mapName;
                                break;
                        }
                    }
                    catch (e)
                    {
                        Logger.add("Invalid variable received: " + a[i] + "\n" + e);
                    }
                }
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

    private static function GetGameRegionFromWOTLauncherCfg()
    {
        //Logger.add("TRACE: Config.GetGameRegionFromWOTLauncherCfg()");

        var xml:XML = new XML();
        xml.ignoreWhite = true;
        xml.onLoad = function(success: Boolean)
        {
            var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How? F*ck!
            try
            {
                if (!success)
                    return;
                var cfg = com.produxion.util.XML2Object.deserialize(xml);
                var items = cfg["wotlauncher.cfg"]["patch_info_urls"]["item"];
                if (!(items instanceof Array))
                    items = [ items ];
                for (var i = 0; i < items.length; ++i)
                {
                    var url:String = Utils.trim(items[i]["data"]).toLowerCase();
                    //Logger.add("url: " + url);
                    if (url.indexOf("http://update.wot.ru.wargaming.net") > -1 || url.indexOf("http://update.worldoftanks.ru") > -1)
                        Config.s_game_region = "RU";
                    else if (url.indexOf("http://update.worldoftanks.eu") > -1)
                        Config.s_game_region = "EU";
                    else if (url.indexOf("http://update.worldoftanks.com") > -1)
                        Config.s_game_region = "US";
                    else if (url.indexOf("http://update-ct.wargaming.net") > -1)
                        Config.s_game_region = "CT";
                    else if (url.indexOf("http://update.worldoftanks.cn") > -1)
                        Config.s_game_region = "CN";
                    else if (url.indexOf("http://update.worldoftanks-sea.com") > -1)
                        Config.s_game_region = "SEA";
                    else if (url.indexOf("http://update.worldoftanks.vn") > -1)
                        Config.s_game_region = "VTC";
                }
                Locale.setRegion(Config.s_game_region);
            }
            finally
            {
                if (finallyBugWorkaround)
                    return;
                finallyBugWorkaround = true;
                Config.SetConfigLoaded();
            }
        };

        xml.load("../../../../WOTLauncher.cfg");
    }

    private static function SetConfigLoaded()
    {
        Logger.add("Config: Loaded (" + s_src + ")");
        s_loaded = true;
        s_loading = false;
        GlobalEventDispatcher.dispatchEvent({type: "config_loaded"});
    }

    /**
     * Recursive walt default config and merge with loaded values.
     */
    private static function MergeConfigs(config, def, prefix: String)
    {
        if (!prefix)
            prefix = "def";

        switch (typeof def)
        {
            case 'object':
                if (def instanceof Array)
                {
                    // warning: arrays are not checked now
                    return (config instanceof Array) ? config : def;
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
    private static function TuneupConfig()
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

    /**
     * Convert config to new format.
     */
    private static function FixConfig(config:Object):Object
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
}
