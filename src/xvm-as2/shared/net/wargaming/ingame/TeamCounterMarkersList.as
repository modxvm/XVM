intrinsic class net.wargaming.ingame.TeamCounterMarkersList extends gfx.core.UIComponent
{
    function clear();
    function get dataProvider();
    function set dataProvider(value);
    function get align();
    function get markerType();
    function cleanupRenderers();
    function drawRenderers(resetPrevData);
    function createItemRenderer(data, resetPrevData);
    function setUpRenderer(clip);
}
