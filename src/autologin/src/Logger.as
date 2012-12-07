/**
 * ...
 * @author sirmax2
 */
class Logger
{
  public static var counter: Number = 0;

  public static var dummy; // avoid import warning

  public static function add(str: String)
  {
    var a:Array = ("[" + String(counter++) + "] " + str).split("");
    var s:String = "";
    var a_length:Number = a.length;
    for (var i = 0; i < a_length; ++i)
    {
      var b:Number = a[i].charCodeAt(0);
      var c:String = (b < 128) ? b.toString(16) : escape(a[i].charAt(0)).split("%").join("");
      s += (c.length % 2 == 0 ? "" : "0") + c;
    }
    s = s.length.toString(16) + "," + s;

    var command:String = "../../../.stat/@LOG ";
    var max_len:Number = 199 - command.length;
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
    add((name || "[obj]") + ": " + JSON.stringifyDepth(obj, depth));
  }
}
