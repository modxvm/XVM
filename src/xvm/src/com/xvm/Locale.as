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
    public static var s_lang_fallback = {};
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
                LoadLanguageFallback();
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

    public static function LoadLanguageFallback() //This strings will be used if .xc not found
    {
        var tr;
        // EN
        tr = s_lang_fallback;
        if (_language = "RU")
        {
            tr["enabled"] = "включено";
            tr["disabled"] = "выключено";
            // win chance
            tr["Chance error"] = "Ошибка расчета шансов";
            tr["Chance to win"] = "Шанс на победу";
            tr["Global"] = "общий";
            tr["Per-vehicle"] = "по технике";
            // damage type
            tr["attack"] = "атака";
            tr["fire"] = "пожар";
            tr["ramming"] = "таран";
            tr["world_collision"] = "падение";
            tr["<font size='15' color='#FFFFFF'>Enemy base capture! {{extra}}</font>"] =
                "<font size='15' color='#FFFFFF'>Захват вражеской базы! {{extra}}</font>";
            tr["<font size='17' color='#FFCC66'>Enemy base captured!</font>"] =
                "<font size='17' color='#FFCC66'>Вражеская база захвачена!</font>";
            tr["<font size='15' color='#FFFFFF'>Ally base capture! {{extra}}</font>"] =
                "<font size='15' color='#FFFFFF'>Захват нашей базы! {{extra}}</font>";
            tr["<font size='17' color='#FFCC66'>Ally base captured!</font>"] =
                "<font size='17' color='#FFCC66'>Наша база захвачена!</font>";
            tr["Capturers: <b><font color='#FFCC66'>{{tanks}}</font></b> Timeleft: <b><font color='#FFCC66'>{{time}}</font><b>"] =
                "Захватчиков: <b><font color='#FFCC66'>{{tanks}}</font></b> Осталось: <b><font color='#FFCC66'>{{time}}</font><b>";
            tr["Hit percent"] = "Процент попаданий";
            tr["Damage upon detecting"] = "Урон по вашим разведданным";
            tr["Damage dealt"] = "Нанесенный урон";
            // TeamRenderers
            tr["TeamRenderersHeaderTip"] =
                "Рейтинг xwn.\n" +
                "Чтобы увидеть более подробную информацию, наведите курсор мыши на значение рейтинга интересующего игрока.";
            tr["Friend"] = "Друг";
            tr["Ignored"] = "Игнор";
            tr["Load statistics"] = "Загрузить статистику";
            // UserInfo
            tr["UserInfoEHint"] =
                "Эффективность по танку.\n" +
                "Значение указано на момент последнего обновления статистики: %DATE%\n" +
                "Актуальное значение на текущий момент - в детальной информации по технике.\n" +
                "Правильность значений в колонке зависит от качества полученных исходных данных.";
            tr["Data was updated at"] = "Данные были обновлены";
            tr[" to "] = " до ";
            tr["EFF"] = "РЭ";
            tr["updated"] = "обновлено";
            tr["unknown"] = "неизвестно";
            tr["Avg level"] = "Ср. уровень";
            tr["Spotted"] = "Засвет";
            tr["Defence"] = "Защита";
            tr["Capture"] = "Захват";
            tr["player (average / top)"] = "игрок (средний / топ)";
            tr["top"] = "топ";
            tr["Spec dmg"] = "Уд. дамаг";
            tr["All tanks"] = "Все танки";
            tr["Show all tanks in the game"] = "Показать все танки в игре";
            tr["Player tanks"] = "Танки игрока";
            tr["Show all tanks played"] = "Показать все танки, на которых играл";
            tr["In hangar"] = "В ангаре";
            tr["Show only tanks in own hangar"] = "Показать только танки в своем ангаре";
            tr["Filter"] = "Фильтр";
            tr["Level"] = "Уровень";
            tr["Type"] = "Тип";
            tr["Nation"] = "Нация";
            tr["Name"] = "Имя";
            tr["Fights"] = "Боёв";
            tr["Wins"] = "Побед";
            // crew
            tr["PutOwnCrew"] = "Родной экипаж";
            tr["PutBestCrew"] = "Лучший экипаж";
            //squad
            tr["Vehicle"] = "Танк";
            tr["Battle tiers"] = "Уровень боёв";
            tr["ussr"] = "СССР";
            tr["germany"] = "Германия";
            tr["usa"] = "США";
            tr["france"] = "Франция";
            tr["uk"] = "Великобритания";
            tr["china"] = "Китай";
            tr["HT"] = "ТТ";
            tr["MT"] = "СТ";
            tr["LT"] = "ЛТ";
            tr["TD"] = "ПТ";
            tr["SPG"] = "САУ";
        }
        else
        {
            tr["XVM translator"] = "Maxim Schedriviy";
            tr["attack"] = "attack";
            tr["fire"] = "fire";
            tr["ramming"] = "ramming";
            tr["world_collision"] = "falling";
            tr["UserInfoEHint"] =
                "Per-vehicle efficiency.\n" +
                "The values shown are as of the last statistics update: %DATE%\n" +
                "See actual current values in the detailed vehicle info.\n" +
                "Accuracy of the column values depends on the quality of the feed data.";
            tr["TeamRenderersHeaderTip"] =
                "Xwn rating.\n" +
                "To see detailed information, move mouse cursor to the player's name.";
            // crew
            tr["PutOwnCrew"] = "Put own crew";
            tr["PutBestCrew"] = "Put best crew";
            // squad
            tr["ussr"] = "USSR";
            tr["germany"] = "Germany";
            tr["usa"] = "USA";
            tr["france"] = "France";
            tr["uk"] = "UK";
            tr["china"] = "China";
        }

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

    public static function get(text: String,type: String): String
    {
        if (!type)
            type = "common";

        //Logger.add("Locale[get]: string: " + text + " | string: " + s_lang.locale[type][text] + " | fallback string: " + s_lang_fallback[text] );
        return s_lang.locale[type][text] || s_lang_fallback[text] || text;
    }
}