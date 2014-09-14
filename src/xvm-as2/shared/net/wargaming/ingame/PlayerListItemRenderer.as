import gfx.core.UIComponent;
import net.wargaming.controls.UILoaderAlt;
intrinsic class net.wargaming.ingame.PlayerListItemRenderer extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.PlayersPanel.PlayerListItemRenderer;
    /////////////////////////////////////////////////////////////////

    var vehicleLevel: MovieClip;
    var iconLoader: UILoaderAlt;
    var owner: Object;
    var data: Object;
    var squadIcon: MovieClip;
    var visibility;
    var bg:UIComponent;

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
    function __getColorTransform(schemeName);
    function setState();
    function update();
    function setData(data);
    function setListData(index, label, selected);
}
