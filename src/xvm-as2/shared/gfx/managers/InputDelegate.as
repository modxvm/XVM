intrinsic class gfx.managers.InputDelegate extends gfx.events.EventDispatcher
{
	public var dispatchEvent : Object;
	static public var _instance : Object;

	static public function get instance() : Object;


	public function InputDelegate();

	public function readInput(type, code, scope, callBack);

	public function inputToNav(type, code, value);

	public function onKeyDown();

	public function onKeyUp();

	public function handleKeyPress(type);

}