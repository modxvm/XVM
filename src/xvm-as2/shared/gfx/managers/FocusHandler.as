intrinsic class gfx.managers.FocusHandler
{
	public var inputDelegate : Object;
	static public var __get__instance : Object;
	static public var _instance : Object;
	public var inited : Object;

	static public function get instance() : Object;


	public function FocusHandler();

	public function initialize();

	public function getFocus();

	public function setFocus(focus);

	public function handleInput(event);

	public function getPathToFocus();

	public function onSetFocus(oldFocus, newFocus);

	public function textFieldHandleInput(nav);

}