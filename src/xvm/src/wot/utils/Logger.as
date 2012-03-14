/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Utils;

class wot.utils.Logger
{
  public static var counter: Number = 0;

  public static function add(str: String)
  {
    var a: Array = ("[" + Utils.padLeft(String(counter++), 3, '0') + "] " + str).split("");
    var s: String = "";
    for (var i = 0; i < a.length; i++)
      s += Utils.padLeft(a[i].charCodeAt(0).toString(16), 2, '0');
    s = s.length.toString(16) + "," + s;

    var p = new LoadVars();
    while (s.length > Defines.MAX_PATH)
    {
      p.load(Defines.COMMAND_LOG + " " + s.slice(0, Defines.MAX_PATH));
      s = s.slice(Defines.MAX_PATH);
    }
    p.load(Defines.COMMAND_LOG + " " + s);
  }

  public static function addObject(obj: Object, name: String)
  {
    var s: String = (name || "[obj]") + "\n";
    for (var i in obj)
      s += "  " + i + " = " + obj[i] + "\n";
    add(s);
  }
}