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
}