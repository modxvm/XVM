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
    
    tr["<font size='16' color='#000000'>Enemy base capture! {{extra}}</font>"] = 
       "<font size='16' color='#000000'>Захват вражеской базы! {{extra}}</font>";
    tr["<font size='16' color='#000000'>Enemy base captured!</font>"] = 
       "<font size='16' color='#000000'>Вражеская база захвачена!</font>";
       
    tr["<font size='16' color='#000000'>Ally base capture! {{extra}}</font>"] = 
       "<font size='16' color='#000000'>Захват нашей базы! {{extra}}</font>";
    tr["<font size='16' color='#000000'>Ally base captured!</font>"] = 
       "<font size='16' color='#000000'>Наша база захвачена!</font>";
       
    tr[  "Capturers: <b>{{tanks}}</b> Timeleft: <b>{{time}}<b>"] = 
       "Захватчиков: <b>{{tanks}}</b> Осталось времени: <b>{{time}}<b>";

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
