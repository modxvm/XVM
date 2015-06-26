intrinsic class gfx.events.EventDispatcher
{
	public var _listeners : Object;
	static public var _instance : Object;

	public function EventDispatcher();

	static public function initialize(target);

	static public function indexOfListener(listeners, scope, callBack);

	public function addEventListener(event, scope, callBack);

	public function removeEventListener(event, scope, callBack);

	public function dispatchEvent(event);

	public function hasEventListener(event);

	public function removeAllEventListeners(event);

	public function dispatchQueue(dispatch, event);

	static public function $dispatchEvent(dispatch, listeners, event);

	public function cleanUp();

	public function cleanUpEvents();

}