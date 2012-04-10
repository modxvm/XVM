package utils
{
	public class StringUtils
	{
		public static function toHex(item:Object):String
		{
			var hex:String = Number(item).toString(16);
			return ("00000" + hex.toUpperCase()).substr(-6);
		}

		public static function toHexColor(item:Object):String
		{
			return "#" + toHex(item);
		}
	}
}