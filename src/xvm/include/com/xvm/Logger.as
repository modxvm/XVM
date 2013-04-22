import com.xvm.Comm;
import com.xvm.Defines;
import com.xvm.Sandbox;
import com.xvm.Utils;
intrinsic class com.xvm.Logger
{
	static public var counter : Number;

	static public function add(str:String);

	static public function addObject(obj:Object, name:String, depth:Number);

}