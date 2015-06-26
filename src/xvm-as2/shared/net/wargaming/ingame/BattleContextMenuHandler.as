intrinsic class net.wargaming.ingame.BattleContextMenuHandler
{
	static public var currentContext : Object;
	static public var currentMenu : Object;
	static public var APPEAL_EVT : Object;
	static public var CMD_MAP : Object;

	public function BattleContextMenuHandler();

	static public function showMenu(context, data, menu, forceShow);

	static public function onContextMenuHideHandler(event);

	static public function hideMenu();

	static public function hitTestToCurrentMenu();

	static public function handleMenuAction(event);

}