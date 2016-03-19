import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.Minimap extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.Minimap.Minimap;
    /////////////////////////////////////////////////////////////////

    var onSizeChangeCallback;
    var checkFreeSpaceCallbcak;
    var gasAtackArea;
    var _gasXPos;
    var _gasYPos;
    var _gasRadius;
    var _mapWidth;
    var _mapHeight;
    var _gasAtackDepth;
    var _safeZoneRadius;
    var _markersInvalid:Boolean;
    var _gasAtackIsInit;
    var _isShown;
    var m_sizeIndex:Number;

    static var MINIMAP_SIZE:Number;
    static var MINIMAP_STEP:Number;
    static var TEXT_CORN_OFFSET:Number;
    static var CELLS_COUNT:Number;
    static var MARKERS_SCALING:Number;
    static var MNP_SIZE_UP = "minimap.sizeUp";
    static var MNP_SIZE_DOWN = "minimap.sizeDown";
    static var MNP_VISIBLE = "minimap.visible";
    static var MNP_SETUP_SIZE = "minimap.setupSize";
    static var MNP_SETUP_ALPHA = "minimap.setupAlpha";
    static var MNP_ENTRY_INITED = "minimap.entryInited";
    static var MNP_SET_SHOW_VEHICLE_NAME = "minimap.setShowVehicleName";
    static var MNP_GAS_ATACK_INIT = "minimap.gasAtackInit";
    static var MNP_GAS_ATACK_UPDATE = "minimap.gasAtackUpdate";
    static var CTRLR_SETSIZE_METHOD = "minimap.setSize";
    static var CTRLR_ONCLICK_METHOD = "minimap.onClick";
    static var CTRLR_SCALE_MARKERS = "minimap.scaleMarkers";
    static var CORRECT_WIDTH_SIZE:Number;
    static var CORRECT_HEIGHT_SIZE:Number;
    static var GAS_ATACK_IDENTIFIER = "GasAtackUI";
    static var GAS_ATACK_NAME = "gasAtackArea";
    static var BG_DEFAULT_OFFSET:Number;
    static var BG_DEFAULT_SIZE_CORRECT:Number;
    static var BG_HR_OFFSET_X:Number;
    static var BG_HR_OFFSET_Y:Number;
    static var BG_HR_SIZE_X_CORRECT:Number;
    static var BG_HR_SIZE_Y_CORRECT:Number;
    static var BORDER_TOP_SCALE_FACTOR:Number;
    static var BORDER_RIGHT_SCALE_FACTOR:Number;
    static var BORDER_BOTTOM_SCALE_FACTOR:Number;
    static var BORDER_LEFT_SCALE_FACTOR:Number;

    var icons:MovieClip;
    var foreground:MovieClip;
    var foregroundHR:MovieClip;
    var backgrnd:MovieClip;
    var setSize;
    var __height:Number;

    function configUI();
    function get foregroundVisibleWidth();
    function intiGasAtackArea(mapRealWidth, mapRealHeight, xPos, yPos, radius, safeZoneRadius);
    function updateGasAtackArea(radius, minimapGasIsVisible);
    function updateGasAtackSize();
    function get foregroundVisibleHeight();
    function onSetShowVehicleName(visibility);
    function normalizeTextFieldScaling(textField);
    function draw();
    function scaleMarkers(percent);
    function updateContent();
    function getRowsNames();
    function updateColsNames(colsNamesXOffset, colsNamesYOffset, colsNamesWidth, size);
    function updateRowsNames();
    function zoomIsNormal();
    function initRowsNames();
    function updateContentBeforeDraw();
    function defaultScaleSprite(destinationSprite, ethaloneSprite);
    function updatePlayerMessangersPanel();
    function setupSize(size, stageHeight, stageWidth);
    function setupAlpha(mAlpha);
    function correctSizeIndex(sizeIndex);
    function sizeUp();
    function onEntryInited();
    function sizeDown();
    function invalidateMarkers();
    function setVisible();
    function onRecreateDevice(width, height, left, top);
    function onMouseDown(button, target, mouseIdx, x, y, dblClick);
}
