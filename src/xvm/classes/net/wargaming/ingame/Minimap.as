import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.Minimap extends UIComponent
{
    static var MARKERS_SCALING:Number;
    
    var icons:MovieClip;
    var foreground:MovieClip;
    var foregroundHR:MovieClip;
    var backgrnd:MovieClip;
    
    function Minimap();
    function scaleMarkers(val:Number);
    function onEntryInited();
    function sizeUp();
    function sizeDown();
}