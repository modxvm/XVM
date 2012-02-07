/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
 
class wot.utils.Logger
{
  public static function add(str) 
  {
    str = str.split(":").join(".");
    str = str.split("/").join("_");
    str = str.split("\\").join("_");
    str = str.split(";").join(".");
    str = str.split("<").join("{");
    str = str.split(">").join("}");

    var p = new LoadVars();

    while (str.length > Defines.MAX_PATH)
    {
      p.load(Defines.COMMAND_LOG + " " + str.slice(0, Defines.MAX_PATH) + "... (continued)");
      str = "..." + str.slice(Defines.MAX_PATH);
    }

    p.load(Defines.COMMAND_LOG + " " + str);
  }
}