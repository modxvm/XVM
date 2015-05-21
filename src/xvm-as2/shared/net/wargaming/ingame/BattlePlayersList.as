intrinsic class net.wargaming.ingame.BattlePlayersList extends gfx.controls.ScrollingList
{
    static var DYNAMIC_ICONS_SHIFT_ON_SQUAD:Number;

    function setPlayerSpeaking(accountDBID, flag);
    function getDataByPoint(x, y);
    function handleInput(details, pathToFocus);
    function updateSquadIconPosition(squadPositionX);
    function isShowVehicleName(val);
    function isDynamicSquadActive(val);
    function set isShowExtraModeActive(val);
    function get isShowExtraModeActive();
    function get type();
    function set type(val);
    function populateData(data);
}
