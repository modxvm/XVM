/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.StatFormat;

class wot.utils.TextCache
{
  private static var s_textCache = {};
  private static var s_widthTester: TextField;

  private static var data: Object;
  private static var state: String;
  private static var format: String;
  private static var width: Number;
  private static var tf: TextFormat;
    
  public static function GetFormattedText(data: Object, state: String, isDead: Boolean,
    format: String, width: Number, tf: TextFormat): String
  {
    TextCache.data = data;
    TextCache.state = state;
    TextCache.fieldType = fieldType;
    TextCache.format = format;
    TextCache.width = width;
    TextCache.tf = tf;
    
    var key_prefix = "/" + data.label + "/" + data.vehicle + "/" + state + "/" + fieldType;
    var key = (isDead ? "d" : "a") + key_prefix;
    if (!s_textCache.hasOwnProperty(key))
    {
      s_textCache["a" + key_prefix] = FormatText(false);
      s_textCache["d" + key_prefix] = FormatText(true);
    }
    return s_textCache[key];
  }

  public static function ClearFormattedText(data: Object, state: String, fieldType: Number)
  {
    var key_prefix = "/" + data.label + "/" + data.vehicle + "/" + state + "/" + fieldType;
    delete s_textCache["a" + key_prefix];
    delete s_textCache["d" + key_prefix];
  }
  
  private static function FormatText(isDead: Boolean): String
  {
    var name = data.label + ((data.clanAbbrev == "") ? "" : "[" + data.clanAbbrev + "]");

    format = format.split("{{vehicle}}").join(data.vehicle.toString());
    format = StatFormat.FormatText(data, format, isDead);

    // cut player name for field width
    if (format.indexOf("{{nick}}") > -1)
    {
      var str: String = name;
      var pname: String = name;
      if (width >= 0 && tf)
      {
        if (s_widthTester == null)
        {
          s_widthTester = _root.createTextField("widthTester", _root.getNextHighestDepth(), 0, 0, 268, 20);
          s_widthTester.autoSize = false;
          s_widthTester.html = true;
          s_widthTester.condenseWhite = true;
          s_widthTester._visible = false;
          s_widthTester.setNewTextFormat(tf);
        }
        while (pname.length > 0)
        {
          str = (pname == name || state != "pp_large") ? pname : pname + "...";
          s_widthTester.htmlText = format.split("{{nick}}").join(str);
          if (Math.round(s_widthTester.getLineMetrics(0).width) + 4 <= width) // 4 is a size of gutters
          {
            //Logger.add("width=" + width + " _width=" + s_widthTester._width + " lineWidth=" + Math.round(s_widthTester.getLineMetrics(0).width) + " " + str);
            break;
          }
          pname = pname.substr(0, pname.length - 1);
        }
      }
      format = format.split("{{nick}}").join(pname.length == 0 ? "" : str);
    }

    return format;
  }
  
}