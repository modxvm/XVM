intrinsic class com.xvm.Cache
{
	static private var s_cache : Object;

	static public function Exist(key:String);

	static public function Get(key:String, populateFunc:Function);

	static public function Remove(key:String);

}