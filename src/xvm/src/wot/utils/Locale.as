/**
 * ...
 * @author Maxim Schedriviy
 */
class wot.utils.Locale
{
  // valid regions: EN, RU, CN
  private static var _region = "EN";

  private static var _translations = {
    EN: { },
    RU: { },
    CN: { }
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

    // RU
    tr = _translations["RU"];
    tr["Chance error"] = "Ошибка расчета шансов";
    tr["Chance to win"] = "Шанс на победу";
    tr["Global"] = "Общий";
    tr["Per-vehicle"] = "По технике";

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

    tr[" to "] = " до ";
    tr["EFF"] = "РЭ";
    tr["updated"] = "обновлено";
    tr["Avg level"] = "Ср. уровень";
    tr["Spotted"] = "Засвет";
    tr["Defence"] = "Защита";
    tr["Capture"] = "Захват";
    
//    tr["Using default settings."] = "Используются настройки по умолчанию.";
//    tr["Error parsing config file."] = "Ошибка чтения конфигурации.";
//    tr["Error loading config file."] = "Ошибка загрузки конфигурации.";

    // CN
    tr = _translations["CN"];
    tr["Chance error"] = "Chance error";
    tr["Chance to win"] = "Chance to win";
    tr["Global"] = "Global";
    tr["Per-vehicle"] = "Per-vehicle";
//    tr["Using default settings."] = "Using default settings.";
//    tr["Error parsing config file."] = "Error parsing config file.";
//    tr["Error loading config file."] = "Error loading config file.";
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
          initialize();
          break;
        default:
          _region = "EN";
      }
    }
  }

  public static function get(text: String): String
  {
    return _translations[_region][text] || text;
  }
}
