import com.xvm.Logger;
intrinsic class com.xvm.JSONx
{
	static public var maxDepth : Number;
	static public var curDepth : Number;
	public var _reference : Function;
	public var _number : Function;
	public var _word : Function;

	static public function stringifyDepth(arg, depth) : String;

	static public function stringify(arg, indent:String, compact:Boolean) : String;

	static public function parse(text:String) : Object;

}