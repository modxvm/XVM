intrinsic class net.wargaming.managers.ContextMenuManager
{
	public var hitTest : Object;
	static public var __get__instance : Object;
	static public var _instance : Object;
	public var _menu : Object;

	static public function get instance() : Object;


	public function ContextMenuManager();

	public function show(menuGroupName, noAnim, data);

	public function hide();

}