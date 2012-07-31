/**
 * ...
 * @author Maxim Schedriviy
 */
class wot.utils.Locale
{
  // valid regions: EN, RU, CN
  private static var _region = "EN";

  private static var _translations = {
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

    // RU
    tr = _translations["RU"];
    tr["Chance error"] = "Ошибка расчета шансов";
    tr["Chance to win"] = "Шанс на победу";
    tr["Global"] = "Общий";
    tr["Per-vehicle"] = "По технике";
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
    if (_region == "EN")
      return text;
    return _translations[_region][text] || text;
  }
}