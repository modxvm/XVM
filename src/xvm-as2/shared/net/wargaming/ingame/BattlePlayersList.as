intrinsic class net.wargaming.ingame.BattlePlayersList extends gfx.controls.ScrollingList
{
	public var renderers : Object;
	public var _isShowExtraModeActive : Object;
	public var _type : Object;
	static public var DYNAMIC_ICONS_SHIFT_ON_SQUAD : Object;
	public var _isDynamicSquadActive : Object;
	public var _isShowVehicleName : Object;

	public function get isShowExtraModeActive() : Object;
	public function set isShowExtraModeActive(val) : Void;

	public function get type() : Object;
	public function set type(val) : Void;


	public function BattlePlayersList();

	public function setPlayerSpeaking(accountDBID, flag);

	public function getDataByPoint(x, y);

	public function handleInput(details, pathToFocus);

	public function updateSquadIconPosition(squadPositionX);

	public function isShowVehicleName(val);

	public function isDynamicSquadActive(val);

	public function populateData(data);

	public function configUI();

}