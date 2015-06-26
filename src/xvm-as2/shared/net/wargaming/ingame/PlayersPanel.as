import gfx.core.UIComponent;
intrinsic class net.wargaming.ingame.PlayersPanel extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.PlayersPanel.PlayersPanel;
    /////////////////////////////////////////////////////////////////

    var players_bg:MovieClip;
    var m_list:TextField;
    var m_vehicles:TextField;
    var m_frags:TextField;
    var m_names:TextField;
    var inviteReceived:Boolean;
    var panel_width:Number;
    static var STATES:Object;
    var dynamicSquadReceived:Boolean;
    var _isDynamicSquadActive:Boolean;
    static var PLAYERS_PANEL_COUNT:Number;
    static var LARGE_PANEL_SHIFT:Number;
    static var SQUAD_ICO_MARGIN:Number;
    static var PLAYER_NAME_LENGTH:Object;
    static var MAX_VEHICLE_NAME_LENGTH:Object;
    static var SUBMENU:Array;
    static var ms_widthOfLongestName:Number;
    var _isPrebattleCreator:Boolean;
    var saved_params:Object;
    var getChemeFunc:Function;
    static var SQUAD_SIZE:Number;
    var m_type:String;
    var m_state:String;


    function isInitialized();
    function setIsDynamicSquadActive(val);
    function setIsShowExtraModeActive(val);
    function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStr, vehiclesStr, namesStr);
    function updateReceivedInviteIcon();
    function getPlayerNameLength();
    function getVehicleNameLength();
    function setPlayerSpeaking(vehicleId, flag);
    function get type();
    function set type(type);
    function get state(); // none, short, medium, medium2, large
    function set state(state);
    function update();
    function onRecreateDevice(width, height);
    function getHeight();
    function __getStateName(state);
    function getDynamicSquadMenuItem(contextMenuData, dynamicSquad, himself, isCommanderBySquad, squadId);
    function saveData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount, dead_players_count, fragsStr, vehiclesStr, namesStr);
    function getDenunciationsSubmenu(con, deninciationsLength, squadSize);
    function getDenunciationsSubmenuData(con, deninciationsLength, squadSize);
    function updateAlphas();
    function updatePositions();
    function updateSquadIcons();
    function _getHTMLText(colorScheme, text);
}
