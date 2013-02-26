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
            "The value shown for the last data scan moment: %DATE%\n" +
            "See actual E value for present moment in the detailed vehicle info.";
        tr["TeamRenderersHeaderTip"] =
            "Xwn rating.\n" +
            "To see detailed information, move mouse cursor to the player's name.";

        // RU
        tr = _translations["RU"];
        tr["Chance error"] = "Ошибка расчета шансов";
        tr["Chance to win"] = "Шанс на победу";
        tr["Global"] = "общий";
        tr["Per-vehicle"] = "по технике";

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
        tr["Damage upon detecting"] = "Урон по разведданным";
        tr["Damage dealt"] = "Нанесенный урон";

        // TeamRenderers
        tr["TeamRenderersHeaderTip"] =
            "Рейтинг xwn.\n" +
            "Чтобы увидеть более подробную информацию, наведите курсор мыши на значение рейтинга интересующего игрока.";
        tr["Friend"] = "Друг";
        tr["Ignored"] = "Игнор";

        // UserInfo
        tr["UserInfoEHint"] =
            "Эффективность по танку.\n" +
            "Значение указано на момент последнего обновления данных: %DATE%\n" +
            "Актуальное значение на текущий момент - в детальной информации по технике.";
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
        tr["Eff damage"] = "Эф. дамаг";
        tr["Level"] = "Уровень";
        tr["Type"] = "Тип";
        tr["Nation"] = "Нация";
        tr["Name"] = "Имя";
        tr["Fights"] = "Боёв";
        tr["Wins"] = "Побед";
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
