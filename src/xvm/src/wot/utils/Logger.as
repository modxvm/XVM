/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;

class wot.utils.Logger
{
  public static var counter: Number = 0;

  public static function add(str: String)
  {
    str = str.split(":").join(".");
    str = str.split("/").join("_");
    str = str.split("\\").join("_");
    str = str.split(";").join(".");
    str = str.split("<").join("{");
    str = str.split(">").join("}");
    str = str.split("\"").join("'");

    var p = new LoadVars();

    while (str.length > Defines.MAX_PATH)
    {
      p.load(Defines.COMMAND_LOG + " " + str.slice(0, Defines.MAX_PATH) + "... (continued)");
      str = "..." + str.slice(Defines.MAX_PATH);
    }

    p.load(Defines.COMMAND_LOG + " [" + wot.utils.Utils.padLeft(String(counter), 3, '0') + "] " + str);
    counter++;
  }

  public static function addObject(obj: Object, name: String)
  {
    add((name || "[obj]") + ".");
    for (var i in obj)
      add("  " + i + " = " + obj[i]);
  }
}