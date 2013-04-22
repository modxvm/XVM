/**
 * ...
 * @author Maxim Schedriviy
 */
intrinsic class com.xvm.Locale
{
	static private var _region : Object;
	static private var _translations : Object;
	static private var _initialized : Object;

	static public function initialize();

	static public function setRegion(value:String);

	static public function get(text:String) : String;

}