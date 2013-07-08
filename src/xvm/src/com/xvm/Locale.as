/**
 * ...
 * @author Maxim Schedriviy
 * @author Michael Pavlyshko
 * @author Pavel Maca
 */
import com.xvm.Config;
import com.xvm.ConfigLoader;
import com.xvm.ConfigUtils;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import com.xvm.JSONxLoader;
import com.xvm.Logger;
import com.xvm.Utils;
import flash.external.ExternalInterface;
import net.wargaming.managers.Localization;

class com.xvm.Locale
{
    private static var _language:String;
    public static var s_lang:Object;
    public static var s_lang_fallback = {};
    private static var _initialized:Boolean = false;

    public static var AUTO_DETECTION = "auto";
    private static var timer;

    public static function loadLocale() 
    {
        if (_initialized) return;
        _initialized = true;

        if (Config.s_config.definition.language == AUTO_DETECTION) {
            getLanguageFromGettext();

        }else {
            _language = Config.s_config.definition.language.toLowerCase();
            Logger.add("Locale: '" + _language + "' (config)");
            loadLocaleFile();
        }
    }

    private static function getLanguageFromGettext() 
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

    private static function loadLocaleFile() 
    {
        LoadLanguageFallback();
        JSONxLoader.LoadAndParse(Defines.XVM_ROOT + "l10n/" + _language + ".xc", null, languageFileCallback);
    }

    private static function languageFileCallback(event)
    {
        if (event.error == null) {
            s_lang = event.data;
            Logger.add("Locale: Loaded '" + _language + "' language by " + get("XVM_translator"));
        }
        else {
            if (event.error.type == "NO_FILE")
            {
                Logger.add("Locale: Can not find language file. Filename:" + event.filename );
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

    public static function LoadLanguageFallback() //This strings will be used if .xc not found
    {
        var tr = s_lang_fallback;
        if (_language == "ru")
        {
            tr["XVM_translator"] = "Maxim Schedriviy";
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
            tr["XVM_translator"] = "Maxim Schedriviy";
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

    public static function get(text: String,type: String): String
    {
        if (!type)
            type = "common";
        //Logger.add("Locale[get]: string: " + text + " | string: " + s_lang.locale[type][text] + " | fallback string: " + s_lang_fallback[text] + " | language: " + _language );
        return s_lang.locale[type][text] || s_lang_fallback[text] || text;
    }
}