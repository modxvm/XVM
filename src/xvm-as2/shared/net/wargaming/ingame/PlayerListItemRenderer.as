import gfx.core.UIComponent;
import net.wargaming.controls.UILoaderAlt;
intrinsic class net.wargaming.ingame.PlayerListItemRenderer extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.PlayersPanel.PlayerListItemRenderer;
    /////////////////////////////////////////////////////////////////

    var voice_waves;
    var icoIGR;
    var acceptSquadInvite;
    var addToSquad;
    var inviteWasSent;
    var inviteReceived;
    var inviteReceivedFromSquad;
    var inviteDisabled;
    var hit;
    var vehicleLevel:MovieClip;
    var iconLoader:UILoaderAlt;
    var bg:UIComponent;
    var squadIcon:MovieClip;
    var vehicleActionMarker;
    var data:Object;

    function initDynaicSquadItems();
    function onItemRollOver();
    function onItemRollOut();
    function onItemReleaseOutside();
    function dispatchLightPlayer(visibility);
    function lightPlayer(visibility);
    function checkLightState();
    function get speaking();
    function set speaking(value);
    function get selected();
    function set selected(value);
    function getColorTransform(schemeName);
    function get isDynamicSquadActive();
    function set isDynamicSquadActive(val);
    function get isShowExtraModeActive();
    function set isShowExtraModeActive(val);
    function setState();
    function isShowVehicleName(val);
    function update();
    function updateSquadIcons(squadPositionX, dynamicIcoPotionX);
    function setData(data);
    function setListData(index, label, selected);
}
