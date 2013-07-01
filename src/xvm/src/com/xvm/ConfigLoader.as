/**
 * ...
 * @author sirmax2
 */
import com.xvm.Comm;
import com.xvm.Config;
import com.xvm.ConfigUtils;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONxLoader;
import com.xvm.Locale;
import com.xvm.Logger;
import com.xvm.Utils;

class com.xvm.ConfigLoader
{
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
        if (Config.s_loaded)
        {
            if (info_event != null)
            {
                // Use set timeout to avoid overriding by default value
                _global.setTimeout(function() { GlobalEventDispatcher.dispatchEvent(ConfigLoader.info_event); }, 1);
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

        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + Defines.CONFIG_FILE_NAME, null, ReloadConfigCallback);
    }

    private static function ReloadConfigCallback(event)
    {
        //Logger.add("TRACE: ReloadConfigCallback(): start");
        if (event.error != null && event.error.type == "NO_FILE")
        {
            if (event.filename == Defines.CONFIG_FILE_NAME)
            {
                // xvm.xc not found, try to load legacy config XVM.xvmconf
                JSONxLoader.LoadAndParse(Defines.CONFIG_FILE_NAME_XVMCONF, null, ReloadConfigCallback);
                return;
            }
        }

        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times.
        try
        {
            ConfigLoader.ProcessConfig(event);
            ConfigUtils.TuneupConfig();
        }
        finally
        {
            //Logger.add("TRACE: ReloadConfigCallback(): finally:start");
            if (finallyBugWorkaround)
                return;
            finallyBugWorkaround = true;
            ConfigLoader.ReloadGameRegion();
            //Logger.add("TRACE: ReloadConfigCallback(): finally::end");
        }
        //Logger.add("TRACE: ReloadConfigCallback(): end");
    }

    private static function ProcessConfig(event)
    {
        if (event.error != null && event.error.type == "NO_FILE")
        {
            info_event = { type: "set_info", warning: "" };
            GlobalEventDispatcher.dispatchEvent(info_event);
            return;
        }

        if (event.error != null)
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

        Config.s_config = ConfigUtils.MergeConfigs(ConfigUtils.FixConfig(event.data), Config.s_config);
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
                ConfigLoader.GetGameRegionFromWOTLauncherCfg();
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
                ConfigLoader.SetConfigLoaded();
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
                ConfigLoader.SetConfigLoaded();
            }
        };

        xml.load("../../../../WOTLauncher.cfg");
    }

    private static function SetConfigLoaded()
    {
        Logger.add("Config: Loaded (" + s_src + ")");
        Config.s_loaded = true;
        s_loading = false;
        GlobalEventDispatcher.dispatchEvent({type: "config_loaded"});
    }

}
