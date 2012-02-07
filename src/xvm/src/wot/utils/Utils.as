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
}