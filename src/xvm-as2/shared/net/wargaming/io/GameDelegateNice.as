intrinsic class net.wargaming.io.GameDelegateNice
{
	static public var responseHash : Object;
	static public var callBackHash : Object;
	static public var nextID : Object;
	static public var initialized : Object;

	public function GameDelegateNice();

	static public function call(methodName, params, scope, callBack);

	static public function receiveResponse(uid, jsonString);

	static public function addCallBack(methodName, scope, callBack);

	static public function removeCallBack(methodName);

	static public function receiveCall(methodName, jsonString);

	static public function initialize();

	static public function convertFromJson(jsonStr);

	static public function convertToJson(obj);

}