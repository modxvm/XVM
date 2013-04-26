intrinsic class net.wargaming.ingame.PlayersPanel extends MovieClip
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.PlayersPanel.PlayersPanel;
    /////////////////////////////////////////////////////////////////

    static var PLAYER_NAME_LENGTH: Number;
    static var STATES: Object;
    static var SQUAD_SIZE: Number;

    var m_state: String;
    var m_type: String;
    var m_names: TextField;
    var m_frags: TextField;
    var m_vehicles: TextField;
    var m_list: MovieClip;
    var players_bg: MovieClip;

    function setData(data, sel, postmortemIndex, isColorBlind, knownPlayersCount);
    function update();
    function onRecreateDevice(width, height);
    function _setVehiclesStr(data, sel, isColorBlind, knownPlayersCount);
    function _setNamesStr(data, sel, isColorBlind, knownPlayersCount);
    function _getHTMLText(colorScheme, text);
    function updateWidthOfLongestName();
    function updatePanel();
}
