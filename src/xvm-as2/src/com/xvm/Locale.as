/**
 * XVM Localization module
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 * @author Mikhail Paulyshka "mixail(at)modxvm.com"
 * @author Pavel Máca
 */
import com.xvm.*;

class com.xvm.Locale
{
    public static var EVENT_LOADED:String = "locale_loaded";

    private static var MACRO_PREFIX:String = "l10n";
    public static var s_lang:Object;
    private static var s_lang_fallback:Object = {};
    private static var s_filename:String;

    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    public static function get(format:String):String
    {
        //Logger.add("[AS2][Locale][get]: id: " + format + " | value: " + s_lang.locale[format] + " | fallback value: " + s_lang_fallback[format]);
        if (s_lang.locale && s_lang.locale.hasOwnProperty(format))
            format =  s_lang.locale[format];
        else if (s_lang_fallback.hasOwnProperty(format))
            format = s_lang_fallback[format];
        /** each item in array begin with macro */
        var formatParts:Array = format.split("{{" + MACRO_PREFIX + ":");

        /** begin part until first macro start */
        var res = formatParts.shift();

        for (var i = 0; i < formatParts.length; ++i)
        {
            /** "macro}} rest of text" */
            var part:String = formatParts[i];

            /** find macro end & make sure it contains at least 1 symbol */
            var macroEnd:Number = part.indexOf("}}", 1);
            if (macroEnd == -1) {
                /** no end chars => write everythink back */
                res += "{{" + MACRO_PREFIX + ":" + part;
                continue;
            }

            var macro:String = part.slice(0, macroEnd);
            res += Locale.get(macro);

            /** write rest of text after macro, without }} */
            res += part.slice(macroEnd + 2, part.length);
        }
        return res;
    }

    public static function languageFileCallback(data_str:String):Void
    {
        try
        {
            LoadLanguageFallback();

            if (data_str == null)
            {
                Logger.add("Locale: Can not find language file. Filename: " + s_filename);
                return;
            }

            try
            {
                s_lang = JSONx.parse(data_str);
                Logger.add("Locale: Loaded " + Config.config.language);
            }
            catch (ex:Error)
            {
                var text:String = "Error loading language file '" + s_filename + "': ";
                text += parseError(ex);
                Logger.add(text.substr(0, 200));
            }
        }
        finally
        {
            GlobalEventDispatcher.dispatchEvent( { type: EVENT_LOADED } );
        }
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    //This strings will be used if .xc not found
    private static function LoadLanguageFallback():Void
    {
        var tr = s_lang_fallback;
        //Logger.add(Config.config.region + " " + Config.config.language);
        if (Config.config.region == "RU")
        {
            /** Hardcoded RU language */
            // Win chance
            tr["Chance error"] = "Ошибка расчета шансов";
            tr["Chance to win"] = "Шансы на победу";
            //tr["global"] = "общий";
            //tr["per-vehicle"] = "по технике";
            tr["chanceLive"] = "Для живых";
            tr["chanceBattleTier"] = "Уровень боя";

            // Hitlog
            tr["attack"] = "атака";
            tr["fire"] = "пожар";
            tr["ramming"] = "таран";
            tr["world_collision"] = "падение";
            tr["Hits"] = "Пробитий";
            tr["Total"] = "Всего";
            tr["Last"] = "Последний";

            // Hp Left
            tr["hpLeftTitle"] = "Осталось HP:";

            // Capture
            tr["enemyBaseCapture"] = "Захват базы союзниками!";
            tr["enemyBaseCaptured"] = "База захвачена союзниками!";
            tr["allyBaseCapture"] = "Захват базы врагами!";
            tr["allyBaseCaptured"] = "База захвачена врагами!";
            tr["Timeleft"] = "Осталось";
            tr["Capturers"] = "Захватчиков";

            // FinalStatistics
            tr["Hit percent"] = "Процент попаданий";
            tr["Damage upon detecting"] = "Урон по вашим разведданным";
            tr["Damage dealt"] = "Нанесенный урон";

            // TeamRenderers
            tr["TeamRenderersHeaderTip"] =
                "Рейтинг xwn (или xeff).\n" +
                "Чтобы увидеть более подробную информацию, наведите курсор мыши на значение рейтинга интересующего игрока.";
            tr["Friend"] = "Друг";
            tr["Ignored"] = "Игнор";
            tr["Load statistics"] = "Загрузить статистику";
            tr["enabled"] = "включено";
            tr["disabled"] = "выключено";

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

            // UserInfo - filters
            tr["Filter"] = "Фильтр";
            tr["Spec dmg"] = "Уд. дамаг";
            tr["All tanks"] = "Все танки";
            tr["Show all tanks in the game"] = "Показать все танки в игре";
            tr["Player tanks"] = "Танки игрока";
            tr["Show all tanks played"] = "Показать все танки, на которых играл";
            tr["In hangar"] = "В ангаре";
            tr["Show only tanks in own hangar"] = "Показать только танки в своем ангаре";

            // VehicleMarkersManager
            tr["blownUp"] = "Взрыв БК!";
            
            //Vehicle status
            tr["Destroyed"] = "Уничтожен";
            tr["No data"] = "Нет данных";
            tr["Not ready"] = "Не готов";
        }
        else
        {
            /** Hardcoded EN language */
            // Win chance
            tr["chanceLive"] = "For alive";
            tr["chanceBattleTier"] = "Battle tier";

            // Hitlog
            tr["world_collision"] = "falling";

            // Hp Left
            tr["hpLeftTitle"] = "Hitpoints left:";

            // Capture
            tr["enemyBaseCapture"] = "Base capture by allies!";
            tr["enemyBaseCaptured"] = "Base captured by allies!";
            tr["allyBaseCapture"] = "Base capture by enemies!";
            tr["allyBaseCaptured"] = "Base captured by enemies!";

            // UserInfo
            tr["UserInfoEHint"] =
                "Per-vehicle efficiency.\n" +
                "The values shown are as of the last statistics update: %DATE%\n" +
                "See actual current values in the detailed vehicle info.\n" +
                "Accuracy of the column values depends on the quality of the feed data.";

            // TeamRenderers
            tr["TeamRenderersHeaderTip"] =
                "Xwn (or xeff) rating.\n" +
                "To see detailed information, move mouse cursor to the player's name.";

            // VehicleMarkersManager
            tr["blownUp"] = "Blown-up!";
        }
    }

    private static function parseError(ex):String {
        if (ex.at == null)
            return (ex.name != null ? Strings.trim(ex.name) + ": " : "") + Strings.trim(ex.message);
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

            return "[" + ex.at + "] " + Strings.trim(ex.name) + ": " + Strings.trim(ex.message) + "\n  " +
                head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
        }
    }
}
