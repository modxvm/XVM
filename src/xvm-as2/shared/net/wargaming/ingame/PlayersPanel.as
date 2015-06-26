intrinsic class net.wargaming.ingame.PlayersPanel extends gfx.core.UIComponent
{
	static public var STATES : Object;
	public var dynamicSquadReceived : Object;
	public var _isDynamicSquadActive : Object;
	static public var PLAYERS_PANEL_COUNT : Object;
	static public var LARGE_PANEL_SHIFT : Object;
	static public var SQUAD_ICO_MARGIN : Object;
	static public var PLAYER_NAME_LENGTH : Object;
	static public var MAX_VEHICLE_NAME_LENGTH : Object;
	static public var SUBMENU : Object;
	static public var ms_widthOfLongestName : Object;
	public var _isPrebattleCreator : Object;
	public var saved_params : Object;
	public var getChemeFunc : Object;
	static public var SQUAD_SIZE : Object;
	public var m_type : Object;
	public var m_state : Object;

	public function get type() : Object;
	public function set type(type) : Void;

	public function get state() : Object;
	public function set state(state) : Void;


	public function PlayersPanel();

	public function isInitialized();

	public function setIsDynamicSquadActive(val);

	public function setIsShowExtraModeActive(val);

	public function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStr, vehiclesStr, namesStr);

	public function updateReceivedInviteIcon();

	public function getPlayerNameLength();

	public function getVehicleNameLength();

	public function setPlayerSpeaking(vehicleId, flag);

	public function update();

	public function onRecreateDevice(width, height);

	public function getHeight();

	public function __getStateName(state);

	public function configUI();

	public function getDynamicSquadMenuItem(contextMenuData, dynamicSquad, himself, isCommanderBySquad, squadId);

	public function draw();

	public function saveData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStr, vehiclesStr, namesStr);

	public function getDenunciationsSubmenu(con, deninciationsLength, squadSize);

	public function getDenunciationsSubmenuData(con, deninciationsLength, squadSize);

	public function updateAlphas();

	public function updatePositions();

	public function updateSquadIcons();

	public function _getHTMLText(colorScheme, text);

}
