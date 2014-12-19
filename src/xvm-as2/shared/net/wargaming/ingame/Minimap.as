import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.Minimap extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.Minimap.Minimap;
    /////////////////////////////////////////////////////////////////

    static var MINIMAP_SIZE:Number;
    static var MINIMAP_STEP:Number;
    static var TEXT_CORN_OFFSET:Number;
    static var CELLS_COUNT:Number;
    static var MARKERS_SCALING:Number;
    static var NORMAL_LEADING:Number;
    static var MNP_SIZE_UP:String;
    static var MNP_SIZE_DOWN:String;
    static var MNP_VISIBLE:String;
    static var MNP_SETUP_SIZE:String;
    static var MNP_SETUP_ALPHA:String;
    static var MNP_ENTRY_INITED:String;
    static var MNP_SET_SHOW_VEHICLE_NAME:String;
    static var CTRLR_SETSIZE_METHOD:String;
    static var CTRLR_ONCLICK_METHOD:String;
    static var CTRLR_SCALE_MARKERS:String;

    var icons:MovieClip;
    var foreground:MovieClip;
    var foregroundHR:MovieClip;
    var backgrnd:MovieClip;
    var setSize;
    var __height:Number;
    var m_sizeIndex:Number;
    var _markersInvalid:Boolean;

    function Minimap();
    function scaleMarkers(val:Number);
    function onEntryInited();
    function correctSizeIndex(sizeIndex, stageHeight);
    function sizeUp();
    function sizeDown();
    function invalidateMarkers();
    function setupSize(size, stageHeight);
    function onRecreateDevice(width, height);
    function defaultScaleSprite(destinationSprite, ethaloneSprite);
    function updateContentBeforeDraw(leftBorderSpace, topBorderSpace, rightBorderSpace, bottomBorderSpace);
    function updateContent();
    function draw();
    function updatePlayerMessangersPanel(stageHeight);
}
