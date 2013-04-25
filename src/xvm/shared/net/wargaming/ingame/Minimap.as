import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.Minimap extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.Minimap.Minimap; 
    /////////////////////////////////////////////////////////////////

    static var MARKERS_SCALING:Number;
    
    var icons:MovieClip;
    var foreground:MovieClip;
    var foregroundHR:MovieClip;
    var backgrnd:MovieClip;
    var setSize;
    var MINIMAP_SIZE:Number;
    var MINIMAP_STEP:Number;
    
    var m_sizeIndex:Number;
    
    function Minimap();
    function scaleMarkers(val:Number);
    function onEntryInited();
    function sizeUp();
    function sizeDown();
    function setupSize(size, stageHeight);
    function onRecreateDevice(width, height);
    function defaultScaleSprite(destinationSprite, ethaloneSprite);
    function updateContentBeforeDraw(leftBorderSpace, topBorderSpace, rightBorderSpace, bottomBorderSpace);
    function updateContent();
    function draw();
}