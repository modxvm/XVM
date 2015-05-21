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
    var data: Object;

    function configUI();
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
    function get isDynamicSquadActive();
    function set isDynamicSquadActive(value);
    function get isShowExtraModeActive();
    function set isShowExtraModeActive(value);
    function __getColorTransform(schemeName);
    function setState();
    function update();
    function setData(data);
    function setListData(index, label, selected);
}
