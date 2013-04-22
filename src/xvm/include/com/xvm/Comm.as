import com.xvm.JSONx;
import com.xvm.Defines;
import com.xvm.Sandbox;
intrinsic class com.xvm.Comm
{
	static private var timeouts : Object;
	static public var commandId : Object;

	static public function SetVar(name:String, value:String) : Void;

	static public function Sync(command:String, arg:String, target:Object, callback:Function) : Void;

	static public function SyncEncoded(command:String, arg:String, target:Object, callback:Function) : Void;

	/**
     * Run async command. Callback will be called after result received or timeout.
     * @param command command
     * @param resultId id of result, or -1 for auto
     * @param arg arguments string or null
     * @param target target object or null
     * @param callback callback function (required)
     * @param _recursiveData internal argument, must ne null or omitted
     */
	static public function Async(command:String, resultId:Number, arg:String, target:Object, callback:Function, _recursiveData:Object) : Void;

	static private function onAsyncData(str:String, command, resultId, arg, target, callback, rData);

}