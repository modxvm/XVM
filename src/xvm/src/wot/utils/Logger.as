/**
 * ...
 * @author sirmax2
 */
import wot.utils.Defines;
import wot.utils.Utils;

class wot.utils.Logger
{
  public static var counter: Number = 0;

  public static var dummy; // avoid import warning

  public static function add(str: String)
  {
    var a:Array = ("[" + Utils.padLeft(String(counter++), 3, '0') + "] " + str).split("");
    var s:String = "";
    var a_length:Number = a.length;
    for (var i = 0; i < a_length; ++i)
    {
      var b:Number = a[i].charCodeAt(0);
      var c:String = (b < 128) ? b.toString(16) : escape(a[i].charAt(0)).split("%").join("");
      s += (c.length % 2 == 0 ? "" : "0") + c;
    }
    s = s.length.toString(16) + "," + s;

    //s = LZW.compress(s);
    
    var command:String = Defines.COMMAND_LOG + " ";
    var max_len:Number = Defines.MAX_PATH - command.length;
    var p:LoadVars = new LoadVars();
    while (s.length > max_len)
    {
      p.load(command + s.slice(0, max_len));
      s = s.slice(max_len);
    }
    p.load(command + s);
  }

  public static function addObject(obj: Object, name: String, depth: Number)
  {
    if (isNaN(depth) || depth < 1)
      depth = 1;
    if (depth > 10)
      depth = 10;
    add((name || "[obj]") + ": " + com.xvm.JSON.stringifyDepth(obj, depth));
  }
}
