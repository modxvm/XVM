intrinsic class gfx.io.GameDelegate
{
	static public var responseHash : Object;
	static public var callBackHash : Object;
	static public var nextID : Object;
	static public var initialized : Object;

	public function GameDelegate();

	static public function call(methodName, params, scope, callBack);

	static public function receiveResponse(uid);

	static public function addCallBack(methodName, scope, callBack);

	static public function removeCallBack(methodName);

	static public function receiveCall(methodName);

	static public function initialize();

}