import com.xvm.JSONx;
import com.xvm.Logger;
/**
 * Loader for JSONx format (JSON with references)
 * @author sirmax2
 */
intrinsic class com.xvm.JSONxLoader
{
	private var rootPath : Object;
	private var rootFileName : Object;
	private var target : Object;
	private var callback : Function;
	private var file_cache : Object;
	private var obj_cache : Object;
	private var pendingFiles : Array;
	private var rootObj : Object;
	private var loadingCount : Number;

	static public function LoadAndParse(filename:String, target:Object, callback:Function);

	public function JSONxLoader(rootFileName:String, target:Object, callback:Function);

	private function LoadFiles() : Void;

	private function LoadFile(filename:String);

	private function LoadFileCallback();

	private function Deref(data:Object, level:Number, file:Object);

	private function getValue(obj:Object, path:String);

}