intrinsic class net.wargaming.ingame.IngameHelpDialog extends net.wargaming.Dialog
{
	public var dispatchEvent : Object;
	public var lobbyMode : Object;
	static public var menuSource : Object;

	public function IngameHelpDialog();

	static public function show(lobbyMode);

	static public function showCursor();

	static public function hideCursor();

	public function handleInput(details, pathToFocus);

	public function configUI();

	public function handleClickSettingsButton(event);

	public function onGetCommandMapping();

	public function handleStageClick(event);

}