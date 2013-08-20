/**
 * ...
 * @author Maxim Schedriviy
 * @author Michael Pavlyshko
 * @author Pavel Máca
 */
import com.xvm.Config;
import com.xvm.ConfigUtils;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONxLoader;
import com.xvm.Logger;
import flash.external.ExternalInterface;
import net.wargaming.managers.Localization;

class com.xvm.Locale
{
    public static var EVENT_LOADED:String = "locale_loaded";

    private static var MACRO_PREFIX:String = "l10n";
    private static var _initialized:Boolean = false;
    private static var _language:String;
    private static var _loaded:Boolean = false;
    private static var s_lang:Object;
    private static var s_lang_fallback:Object = {};
    private static var timer:Number;

    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    public static function loadLocale():Void
    {
        if (_initialized) return;
        _initialized = true;

        if (Config.s_config.language == Defines.LOCALE_AUTO_DETECTION) {
            getLanguageFromGettext();

        }else {
            _language = Config.s_config.language.toLowerCase();
            Logger.add("Locale: '" + _language + "' (config)");
            loadLocaleFile();
        }
    }

    public static function get(text:String):String
    {
        //Logger.add("Locale[get]: string: " + text + " | string: " + s_lang.locale[text] + " | fallback string: " + s_lang_fallback[text] + " | language: " + _language );
        return s_lang.locale[text] || s_lang_fallback[text] || text;
    }

    public static function formatMacros(format:String):String
    {
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

    public static function isLoaded():Boolean
    {
        return _loaded;
    }

    /////////////////////////////////////////////////////////////////
    // PRIVATE

    private static function getLanguageFromGettext():Void
    {
        //Logger.add("Locale: timer tick");
        if (ExternalInterface.available)
        {
            clearInterval(timer);
            timer = null;

            _language = Localization.makeString("#settings:LANGUAGE_CODE", { } ).toLowerCase();
            Logger.add("Locale: '" + _language + "' (detected)");
            loadLocaleFile();
        }else if(!timer){
            timer = setInterval(getLanguageFromGettext, 100);
        }
    }

    private static function loadLocaleFile():Void
    {
        LoadLanguageFallback();
        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + "l10n/" + _language + ".xc", null, languageFileCallback);
    }

    //This strings will be used if .xc not found
    private static function LoadLanguageFallback():Void
    {
        var tr = s_lang_fallback;
        if (_language == "ru")
        {
            /** Hardcoded RU language */
            tr["XVM_translator"] = "Maxim Schedriviy";

            // Win chance
            tr["Chance error"] = "Ошибка расчета шансов";
            tr["Chance to win"] = "Шанс на победу";
            tr["global"] = "общий";
            tr["per-vehicle"] = "по технике";

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
            tr["enemyBaseCapture"] = "Захват вражеской базы!";
            tr["enemyBaseCaptured"] = "Вражеская база захвачена!";
            tr["allyBaseCapture"] = "Захват нашей базы!";
            tr["allyBaseCaptured"] = "Наша база захвачена!";
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

            // UserInfo - buttons
            tr["Level"] = "Уровень";
            tr["Type"] = "Тип";
            tr["Nation"] = "Нация";
            tr["Name"] = "Имя";
            tr["Fights"] = "Боёв";
            tr["Wins"] = "Побед";

            // Crew
            tr["PutOwnCrew"] = "Родной экипаж";
            tr["PutBestCrew"] = "Лучший экипаж";

            // Squad
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

            // VehicleMarkersManager
            tr["blownUp"] = "Взрыв БК!";

            // Minimap
            tr["metersSymbol"] = "м";
        }
        else
        {
            /** Hardcoded EN language */
            tr["XVM_translator"] = "Maxim Schedriviy";

            // Hitlog
            tr["world_collision"] = "falling";

            // Hp Left
            tr["hpLeftTitle"] = "Hitpoints left:";

                // Capture
            tr["enemyBaseCapture"] = "Enemy base capture!";
            tr["enemyBaseCaptured"] = "Enemy base captured!";
            tr["allyBaseCapture"] = "Ally base capture!";
            tr["allyBaseCaptured"] = "Ally base captured!";

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

            // Crew
            tr["PutOwnCrew"] = "Put own crew";
            tr["PutBestCrew"] = "Put best crew";

            // Squad
            tr["ussr"] = "USSR";
            tr["germany"] = "Germany";
            tr["usa"] = "USA";
            tr["france"] = "France";
            tr["uk"] = "UK";
            tr["china"] = "China";

            // VehicleMarkersManager
            tr["blownUp"] = "Blown-up!";

            // Minimap
            tr["metersSymbol"] = "m";
        }
    }

    private static function languageFileCallback(event):Void
    {
        if (event.error == null) {
            s_lang = event.data;
            Logger.add("Locale: Loaded '" + _language + "' language by " + get("XVM_translator"));
        }
        else {
            if (event.error.type != "NO_FILE")
            {
                var ex = event.error;
                var text:String = "Error loading language file '" + event.filename + "': ";
                text += ConfigUtils.parseErrorEvent(event);

                /** Show error message on battle loading */
                var info_event = { type: Config.E_SET_INFO, error: text };
                GlobalEventDispatcher.dispatchEvent(info_event);
                Logger.add(String(text).substr(0, 200));
            }else{
                Logger.add("Locale: Can not find language file. Filename: " + event.filename );
            }
        }

        _loaded = true;
        GlobalEventDispatcher.dispatchEvent( { type: EVENT_LOADED } );
    }
}
