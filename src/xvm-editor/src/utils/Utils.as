/**
 * ...
 * @author sirmax2
 */
package utils
{
  public class Utils
  {
	  public static function startsWith(substr: String, str: String): Boolean
	  {
		  return str.indexOf(substr, 0) == 0;
	  }

	  public static function endsWith(substr: String, str: String): Boolean
	  {
		  return str.lastIndexOf(substr) == (str.length - substr.length);
	  }

	  public static function fixPath(path: String): String
	  {
		  path = path.split("\\").join("/");
		  if (!Utils.endsWith("/", path))
			  path += "/";
		  return path;
	  }

	  public static function toBool(value: Object, defaultValue: Boolean): Boolean
	  {
		  if ((typeof value) == "boolean")
			  return Boolean(value);
		  if (!value)
			  return defaultValue;
		  value = String(value).toLowerCase();
		  return defaultValue ? value != "false" : value == "true";
	  }

	  public static function toInt(value: Object, defaultValue: Number): Number
	  {
		  if (!defaultValue)
			  defaultValue = 0;
		  if (!value)
			  return defaultValue;
		  var n: Number = parseInt(value.toString());
		  return isNaN(n) ? defaultValue : n;
	  }

	  public static function toString(value: Object, defaultValue: String): String
	  {
		  return value ? String(value) : defaultValue;
	  }

	  public static function trim(s:String):String
	  {
		  return s ? s.replace(/^\s+|\s+$/gs, '') : "";
	  }

	  public static function elapsedMSec(start:Date, end:Date): Number
	  {
		  var d1:Number = start.hours * 3600000 + start.minutes * 60000 + start.seconds * 1000 + start.milliseconds;
		  var d2:Number = end.hours * 3600000 + end.minutes * 60000 + end.seconds * 1000 + end.milliseconds;
		  return d2 - d1;
	  }
  }
}
