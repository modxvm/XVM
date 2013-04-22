/**
 * ...
 * @author sirmax2
 */
intrinsic class com.xvm.GlobalEventDispatcher
{
	static private var _listeners : Object;

	static public function indexOfListener(event, scope, callBack);

	static public function getEventListenersCount(event);

	static public function addEventListener(event, scope, callBack);

	static public function removeEventListener(event, scope, callBack);

	static public function dispatchEvent(event);

}