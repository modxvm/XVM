/**
 * ...
 * @author Maxim Schedriviy
 * @author Michael Pavlyshko
 */

import com.xvm.Config;
import com.xvm.ConfigLoader;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONxLoader;
import com.xvm.Logger;
import com.xvm.Utils;

class com.xvm.Locale
{
    // valid regions: EN, RU
    private static var _region = "EN";
    private static var _language = "EN";
    public static var s_lang:Object;
    private static var info_event:Object = null;
    private static var _initialized = false;

    public static function GetGameLanguage()
    {
        var loadvars:LoadVars = new LoadVars();
        loadvars.onLoad = function(success: Boolean)
        {
            var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice. Why? How? F*ck!
            try
            {
                if (success)
                {
                    Config.s_game_language = loadvars.lang;
                    Logger.add("Locale: game language set to " + Config.s_game_language.toUpperCase() + " using lang.xc file");
                    Locale.SetGameLanguage(Config.s_game_language.toUpperCase(), true);
                }
                else
                {
                    var xml:XML = new XML();
                    xml.ignoreWhite = true;
                    xml.onLoad = function(succcess: Boolean)
                    {
                        if (!succcess)
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
                                Config.s_game_language = "RU";
                            else if (url.indexOf("http://update.worldoftanks.eu") > -1)
                                Config.s_game_language = "EU";
                            else if (url.indexOf("http://update.worldoftanks.com") > -1)
                                Config.s_game_language = "US";
                            else if (url.indexOf("http://update-ct.wargaming.net") > -1)
                                Config.s_game_language = "CT";
                            else if (url.indexOf("http://update.worldoftanks.cn") > -1)
                                Config.s_game_language = "CN";
                            else if (url.indexOf("http://update.worldoftanks-sea.com") > -1)
                                Config.s_game_language = "SEA";
                            else if (url.indexOf("http://update.worldoftanks.vn") > -1)
                                Config.s_game_language = "VTC";
                        }
                        Logger.add("Locale: game language set to " + Config.s_game_language + " using region fallback");
                        Locale.SetGameLanguage(Config.s_game_language, false);
                    }
                    xml.load("../../../../WOTLauncher.cfg");
                }
            }
            finally
            {
                if (finallyBugWorkaround)
                    return;
                finallyBugWorkaround = true;
                ConfigLoader.SetConfigLoaded();
            }
        };
        loadvars.load(Defines.XVM_ROOT + "lang.xc");
    }

    public static function SetGameLanguage(value: String, force:Boolean)
    {
        if (!value)
            _language = "EN";
        else
        {
            if (force = true)
                _language = value;
            else
            {
                switch (value)
                {
                    case "RU":
                    case "CN":
                        _language = value;
                        break;
                    default:
                        _language = "EN";
                        break;
                }
            }
        }
        if (_initialized)
            return;
        _initialized = true;
        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + "l10n/" + _language.toLowerCase() + ".xc", null, LanguageFileCallback);
    }

    private static function LanguageFileCallback(event)
    {
        if (event.error != null && event.error.type == "NO_FILE")
        {
            Logger.add("Locale: can not find language file. Filename:" + event.filename )
            if (event.filename == "en.xc")
            {
                // en.xc not found, load strings from DefaultConfig.as
                Logger.add("Locale: Fallback loaded. Translator: " + Config.s_config.locale.XVM_translator );
                return;
            }
            else
            {
                // xx.xc not found, try to load en.xc
                JSONxLoader.LoadAndParse(Defines.XVM_ROOT + "l10n/en.xc", null, LanguageFileCallback);
            }
        }

        var finallyBugWorkaround: Boolean = false; // Workaround: finally block have a bug - it can be called twice times.
        try
        {
            Locale.ProcessLanguageFile(event);
        }
        finally
        {
            if (finallyBugWorkaround)
                return;
            finallyBugWorkaround = true;
        }
    }

    private static function ProcessLanguageFile(event)
    {
        if (event.error != null)
        {
            var ex = event.error;
            var text:String = "Error loading language file '" + event.filename + "': ";

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
        Locale.s_lang = event.data;
        info_event = { type: "set_info" };
        GlobalEventDispatcher.dispatchEvent(info_event); // Just show version
        Logger.add("Locale: language file loaded. Translator: " + get("XVM_translator"));
    }

    public static function setRegion(value: String)
    {
        if (!value)
            _region = "EN";
        else
        {
            switch (value)
            {
                case "RU":
                case "CN":
                    _region = value;
                    break;
                default:
                    _region = "EN";
                    break;
            }
        }
    }

    public static function get(text: String): String
    {
        //Logger.add("Locale: value: " + text + " | string: " + Config.s_config.locale[text] + " | fallback string: " + Config.s_config[text] );
        return s_lang[text] || Config.s_config.locale[text] || text;
    }
}