intrinsic class net.wargaming.managers.BattleInputHandler
{
	public var m_focusHandler : Object;
	static public var __get__instance : Object;
	public var m_handlers : Object;
	static public var m_instance : Object;

	static public function get instance() : Object;


	public function BattleInputHandler();

	public function addHandler(keyCode, keyUp, scope, handler);

	public function removeHandlers(keyCode);

	public function clearHanders();

	public function setFocused(mc);

	public function setUnfocused(mc);

	public function init(unFocusMC);

	public function _handleInput(event);

	public function _getPathToFocus();

}