/**
 * ...
 * @author sirmax2
 */
import com.xvm.JSONxLoader;
import com.xvm.Comm;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;

class com.xvm.Config
{
    // Public vars
    public static var s_config:Object;
    public static var s_loaded:Boolean = false;
    public static var s_proxy_available:Boolean = true;
    public static var s_game_region:String = null;
    public static var s_vars:Object = {
        window_size: [ 1024, 768 ],
        map_name: ""
    }

    // Private vars
    private static var s_loading:Boolean = false;
    private static var s_src:String = "";
    private static var info_event:Object = null;
    
    // Load XVM mod config; config data is shared between all marker instances, so
    // it should be loaded only once per session. s_loaded flag indicates that
    // we've already initialized config loading process.
    public static function LoadConfig(src: String)
    {
        //Logger.add("TRACE: LoadConfig()");
        if (s_loaded)
        {
            if (info_event != null)
            {
                // Use set timeout to avoid overriding by default value
                _global.setTimeout(function() { GlobalEventDispatcher.dispatchEvent(Config.info_event); }, 1);
            }
            GlobalEventDispatcher.dispatchEvent({type: "config_loaded"});
            return;
        }
        s_src = src || "";
        ReloadConfig();
    }

    private static function ReloadConfig()
    {
        //Logger.add("TRACE: Config.ReloadConfig()");
        if (s_loading)
            return;
        s_loading = true;

        Config.s_config = com.xvm.DefaultConfig.config;

        //Logger.add("TRACE: Config.ReloadXvmConfig()");
        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + Defines.CONFIG_FILE_NAME, null, ReloadXvmConfigCallback);
    }

    private static function ReloadXvmConfigCallback(event)
    {
//Logger.add("ReloadXvmConfigCallback::start");
        if (event.error != null && event.error.type == "NO_FILE")
        {
            if (event.filename == Defines.CONFIG_FILE_NAME)
            {
                // xvm.xc not found, try to load legacy config XVM.xvmconf
                JSONxLoader.LoadAndParse(Defines.CONFIG_FILE_NAME_XVMCONF, null, ReloadXvmConfigCallback);
                return;
            }
            else
            {
                // xvm.xc is primary config
                event.filename = Defines.CONFIG_FILE_NAME;
            }
        }

        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times.
        try
        {
            Config.ProcessXvmConfig(event);
            Config.TuneupConfig();
        }
        finally
        {
//Logger.add("ReloadXvmConfigCallback::finally:start");
            if (finallyBugWorkaround)
                return;
            finallyBugWorkaround = true;
            Config.ReloadGameRegion();
//Logger.add("ReloadXvmConfigCallback::finally::end");
        }
//Logger.add("ReloadXvmConfigCallback::end");
    }

    private static function ProcessXvmConfig(event)
    {
        if (event.error)
        {
            var ex = event.error;

            var text:String = "Error loading config file '" + event.filename + "': ";

            if (ex.at == null)
                text += (ex.name != null ? Utils.trim(ex.name) + ": " : "") + Utils.trim(ex.message);
            else
            {
                var head = ex.at > 0 ? ex.text.substring(0, ex.at) : "";
                head = head.split("\r").join("").split("\n").join("");
                while (head.indexOf("  ") != -1)
                    head = head.split("  ").join(" ");
                head = head.substr(head.length - 75, 75);

                var tail = (ex.at + 1 < ex.text.length) ? ex.text.substring(ex.at + 1, ex.text.length) : "";
                tail = tail.split("\r").join("").split("\n").join("");
                while (tail.indexOf("  ") != -1)
                    tail = tail.split("  ").join(" ");

                var fn = Utils.startsWith(Defines.XVM_ROOT, event.filename) ? event.filename.substring(Defines.XVM_ROOT.length) : event.filename;
                text += "[" + ex.at + "] " + Utils.trim(ex.name) + ": " + Utils.trim(ex.message) + "\n  " +
                    head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
            }
            info_event = { type: "set_info", error: text };
            GlobalEventDispatcher.dispatchEvent(info_event);
            Logger.add(String(text).substr(0, 200));
            return;
        }
            
        if (!event.data)
        {
            info_event = { type: "set_info", warning: "" };
            GlobalEventDispatcher.dispatchEvent(info_event);
            return;
        }

        Config.s_config = Config.MergeConfigs(Config.FixConfig(event.data), Config.s_config);
        //Logger.addObject(Config.s_config, "config", 2);
        //Logger.addObject(Config.s_config.markers.enemy.alive.normal, "", 3);
        info_event = { type: "set_info" };
        GlobalEventDispatcher.dispatchEvent(info_event); // Just show version
    }

    private static function ReloadGameRegion()
    {
        //Logger.add("TRACE: Config.ReloadGameRegion()");
        Comm.Sync(Defines.COMMAND_GET_VERSION, null, null, function(event) {
            if (!event.str) // proxy is not running
            {
                Config.s_proxy_available = false;
                Config.GetGameRegionFromWOTLauncherCfg();
                return;
            }

            var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times. Why? How? F*ck!
            try
            {
                var a: Array = event.str.split("\n");
                Config.s_game_region = a[0].toUpperCase();
                Locale.setRegion(Config.s_game_region);

                // MAX_PATH is 259 on NTFS
                // WARNING: What if MAX_PATH less then 50?
                //   259 - "\res_mods\xvm\.xvmfs\".length - 1 = 237
                // 199 - ?
                Defines.MAX_PATH = Math.min(199, Math.max(50, 237 - a[1].length));

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
        });
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
            v = "1.5.0";

        if (v == "1.5.0")
        {
            if (!config.markers.ally.alive.normal.damageTextPlayer)
                config.markers.ally.alive.normal.damageTextPlayer = config.markers.ally.alive.normal.damageText;
            if (!config.markers.ally.alive.normal.damageTextSquadman)
                config.markers.ally.alive.normal.damageTextSquadman = config.markers.ally.alive.normal.damageText;
            if (!config.markers.ally.alive.extended.damageTextPlayer)
                config.markers.ally.alive.extended.damageTextPlayer = config.markers.ally.alive.extended.damageText;
            if (!config.markers.ally.alive.extended.damageTextSquadman)
                config.markers.ally.alive.extended.damageTextSquadman = config.markers.ally.alive.extended.damageText;
            if (!config.markers.ally.dead.normal.damageTextPlayer)
                config.markers.ally.dead.normal.damageTextPlayer = config.markers.ally.dead.normal.damageText;
            if (!config.markers.ally.dead.normal.damageTextSquadman)
                config.markers.ally.dead.normal.damageTextSquadman = config.markers.ally.dead.normal.damageText;
            if (!config.markers.ally.dead.extended.damageTextPlayer)
                config.markers.ally.dead.extended.damageTextPlayer = config.markers.ally.dead.extended.damageText;
            if (!config.markers.ally.dead.extended.damageTextSquadman)
                config.markers.ally.dead.extended.damageTextSquadman = config.markers.ally.dead.extended.damageText;
            if (!config.markers.enemy.alive.normal.damageTextPlayer)
                config.markers.enemy.alive.normal.damageTextPlayer = config.markers.enemy.alive.normal.damageText;
            if (!config.markers.enemy.alive.normal.damageTextSquadman)
                config.markers.enemy.alive.normal.damageTextSquadman = config.markers.enemy.alive.normal.damageText;
            if (!config.markers.enemy.alive.extended.damageTextPlayer)
                config.markers.enemy.alive.extended.damageTextPlayer = config.markers.enemy.alive.extended.damageText;
            if (!config.markers.enemy.alive.extended.damageTextSquadman)
                config.markers.enemy.alive.extended.damageTextSquadman = config.markers.enemy.alive.extended.damageText;
            if (!config.markers.enemy.dead.normal.damageTextPlayer)
                config.markers.enemy.dead.normal.damageTextPlayer = config.markers.enemy.dead.normal.damageText;
            if (!config.markers.enemy.dead.normal.damageTextSquadman)
                config.markers.enemy.dead.normal.damageTextSquadman = config.markers.enemy.dead.normal.damageText;
            if (!config.markers.enemy.dead.extended.damageTextPlayer)
                config.markers.enemy.dead.extended.damageTextPlayer = config.markers.enemy.dead.extended.damageText;
            if (!config.markers.enemy.dead.extended.damageTextSquadman)
                config.markers.enemy.dead.extended.damageTextSquadman = config.markers.enemy.dead.extended.damageText;

            if (config.battle.clanIconsFolder == "../../../clanicons")
                config.battle.clanIconsFolder = "clanicons";

            if (!config.colors.system.ally_alive)
                config.colors.system.ally_alive = config.colors.system.ally_alive_normal;
            if (!config.colors.system.ally_dead)
                config.colors.system.ally_dead = config.colors.system.ally_dead_normal;
            if (!config.colors.system.ally_blowedup)
                config.colors.system.ally_blowedup = config.colors.system.ally_blowedup_normal;
            if (!config.colors.system.squadman_alive)
                config.colors.system.squadman_alive = config.colors.system.squadman_alive_normal;
            if (!config.colors.system.squadman_dead)
                config.colors.system.squadman_dead = config.colors.system.squadman_dead_normal;
            if (!config.colors.system.squadman_blowedup)
                config.colors.system.squadman_blowedup = config.colors.system.squadman_blowedup_normal;
            if (!config.colors.system.teamKiller_alive)
                config.colors.system.teamKiller_alive = config.colors.system.teamKiller_alive_normal;
            if (!config.colors.system.teamKiller_dead)
                config.colors.system.teamKiller_dead = config.colors.system.teamKiller_dead_normal;
            if (!config.colors.system.teamKiller_blowedup)
                config.colors.system.teamKiller_blowedup = config.colors.system.teamKiller_blowedup_normal;
            if (!config.colors.system.enemy_alive)
                config.colors.system.enemy_alive = config.colors.system.enemy_alive_normal;
            if (!config.colors.system.enemy_dead)
                config.colors.system.enemy_dead = config.colors.system.enemy_dead_normal;
            if (!config.colors.system.enemy_blowedup)
                config.colors.system.enemy_blowedup = config.colors.system.enemy_blowedup_normal;

            v = "4.0.0";
        }

/*
        if (v == "4.x.x")
        {
            v = "4.y.y";
        }
*/

        config.configVersion = v;
        return config;
    }
}
