/**
 * ...
 * @author sirmax2
 */
class wot.utils.Utils
{
  public static function indexOf(array:Array, value:Object):Number
  {
    var i:Number = 0;
    var len:Number = array.length;
    while(i < len)
    {
      if(array[i] === value)
        return i
      i++;
    }
    return -1;
  }
  
  public static function trim(str: String): String
  {
    while (str.charAt(0) == " ")
      str = str.substring(1, str.length);
    while (str.charAt(str.length - 1) == " ")
      str = str.substring(0, str.length-1);
    return str;
  }
  
  public static function padLeft(str: String, len: Number)
  {
    if (!str)
      return null;
    while (str.length < len)
      str = " " + str;
    return str;
  }

  // 0 - equal, -1 - v1<v2, 1 - v1>v2, -2 - error
  public static function compareVersions(v1: String, v2: String): Number
  {
    try
    {
      var a: Array = v1.split(".");
      while (a.length < 4)
        a.push("0");
      var b: Array = v2.split(".");
      while (b.length < 4)
        b.push("0");

      for (var i = 0; i < 4; i++)
      {
        if (isNaN(parseInt(a[i])) && isNaN(parseInt(b[i])))
          return a[i] == b[i] ? 0 : a[i] < b[i] ? -1 : 1;

        if (isNaN(parseInt(a[i])))
          return -1;

        if (isNaN(parseInt(b[i])))
          return 1;

        if (parseInt(a[i]) < parseInt(b[i]))
          return -1;

        if (parseInt(a[i]) > parseInt(b[i]))
          return 1;
      }

      return 0;
    }
    catch (e)
    {
      return -2;
    }
  }
}