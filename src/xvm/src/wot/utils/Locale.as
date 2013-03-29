/**
 * ...
 * @author Maxim Schedriviy
 */
class wot.utils.Locale
{
    // valid regions: EN, RU
    private static var _region = "EN";

    private static var _translations = {
        EN: { },
        RU: { }
    }

    private static var _initialized = false;
    public static function initialize()
    {
        if (_initialized)
            return;
        _initialized = true;

        var tr;

        // EN
        tr = _translations["EN"];
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
		tr["HT"] = "HT";
		tr["MT"] = "MT";
		tr["LT"] = "LT";
		tr["TD"] = "TD";
		tr["SPG"] = "SPG";
		
        // RU
        tr = _translations["RU"];

        // common
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
		tr["Battle levels"] = "Ур. боёв";
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
        initialize();
    }

    public static function get(text: String): String
    {
        //wot.utils.Logger.add(_region);
        return _translations[_region][text] || text;
    }
}
