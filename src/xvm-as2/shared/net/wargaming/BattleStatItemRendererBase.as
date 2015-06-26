intrinsic class net.wargaming.BattleStatItemRendererBase extends gfx.controls.ListItemRenderer
{
	public var __get__label : Object;
	public var _teamType : Object;
	public var dynamicSquadHelper : Object;
	public var _isShowExtraModeActive : Object;
	public var _isDynamicSquadActive : Object;
	public var _isDynaicSquadItemsInited : Object;

	public function set label(value) : Void;

	public function get isDynamicSquadActive() : Object;
	public function set isDynamicSquadActive(val) : Void;

	public function get isShowExtraModeActive() : Object;
	public function set isShowExtraModeActive(val) : Void;


	public function BattleStatItemRendererBase();

	public function configUI();

	public function initDynaicSquadItems();

	public function handleMouseRollOver(mouseIndex, nestingIdx);

	public function handleMouseRollOut(mouseIndex, nestingIdx);

	public function handleDragOver(mouseIndex, nestingIdx);

	public function handleDragOut(mouseIndex, nestingIdx);

	public function onItemRollOver();

	public function onItemRollOut();

	public function updateData();

	public function updateState();

	public function setData(data);

	public function applyData();

	public function initVehicleStateValues();

	public function getColorSchemeNames();

	public function applyPlayerColor(rgbColor);

	public function updateAfterStateChange();

	public function formatStatValue(value);

	public function setTeamType(val);

}