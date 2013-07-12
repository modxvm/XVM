/**
 * ...
 * @author Maxim Schedriviy
 * @author Michael Pavlyshko
 * @author Pavel Maca
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
    public static var AUTO_DETECTION:String = "auto";

    private static var s_lang:Object;
    private static var s_lang_fallback:Object = {};
    private static var _language:String;
    private static var _initialized:Boolean = false;
    private static var timer:Number;

    /////////////////////////////////////////////////////////////////
    // PUBLIC STATIC

    public static function loadLocale():Void
    {
        if (_initialized) return;
        _initialized = true;

        if (Config.s_config.language == AUTO_DETECTION) {
            getLanguageFromGettext();

        }else {
            _language = Config.s_config.language.toLowerCase();
            Logger.add("Locale: '" + _language + "' (config)");
            loadLocaleFile();
        }
    }

    public static function get(text:String,type:String):String
    {
        if (!type)
            type = "common";
        //Logger.add("Locale[get]: string: " + text + " | string: " + s_lang.locale[type][text] + " | fallback string: " + s_lang_fallback[text] + " | language: " + _language );
        return s_lang.locale[type][text] || s_lang_fallback[text] || text;
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
            
            // Capture
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
        }
        else
        {
            /** Hardcoded EN language */
            tr["XVM_translator"] = "Maxim Schedriviy";
            
            // Hitlog
            tr["world_collision"] = "falling";
            
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
        }
    }

    private static function languageFileCallback(event):Void
    {
        if (event.error == null) {
            s_lang = event.data;
            Logger.add("Locale: Loaded '" + _language + "' language by " + get("XVM_translator"));
        }
        else {
            if (event.error.type == "NO_FILE")
            {
                Logger.add("Locale: Can not find language file. Filename: " + event.filename );
                return;
            }

            var ex = event.error;
            var text:String = "Error loading language file '" + event.filename + "': ";
            text += ConfigUtils.parseErrorEvent(event);

            /** Show error message on battle loading */
            var info_event = { type: "set_info", error: text };
            GlobalEventDispatcher.dispatchEvent(info_event);
            Logger.add(String(text).substr(0, 200));
        }
    }
}