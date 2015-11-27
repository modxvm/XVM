import gfx.core.UIComponent;

intrinsic class net.wargaming.ingame.MinimapEntry extends UIComponent
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.Minimap.MinimapEntry;
    private var _xvm_attachments:MovieClip;
    var orig_entryName:String;
    function init_xvm();
    /////////////////////////////////////////////////////////////////

    var vehicleNameTextFieldClassic:TextField;
    var vehicleNameTextFieldAlt:TextField;
    var markMC:MovieClip;
    var _directionLineVisibility:Boolean;
    var player:MovieClip;
    var teamPoint:MovieClip;
    var flagMC:MovieClip;
    var repairPointMC:MovieClip;
    var resourcePointMC:MovieClip;
    var backMarker:MovieClip;
    var _deg1:Number;
    var _deg2:Number;
    var _sectorLine1:MovieClip;
    var _sectorLine2:MovieClip;
    var selfIcon:MovieClip;
    var frtConsumables:MovieClip;;
    var _needLinesScale:Boolean;
    var _parentNormalScale:Number;
    var cameraWithDirection:MovieClip;

    static var showVehicleNames:Boolean;
    var m_type:String;
    var _vehicleName:String;
    var entryName:String;
    var vehicleClass:String;
    var markLabel:String;
    var isTeamKiller:Boolean;
    var isDead:Boolean;
    var isDeadPermanent:Boolean;
    var isPostmortem:Boolean;
    var isMarketLit:Boolean;
    static var ms_lastLitEntry:MovieClip;
    var playingTimeoutId;
    static var isDebug:Boolean;
    var _needInitSector:Boolean;
    static var SQUAD_HANG:Number;

    function configUI();
    function init(markerType, entryName, vehicleClass, markLabel, vehicleName);
    function showAction(markLabel);
    function showCameraDirectionLine();
    function hideCameraDirectionLine();
    function update();
    function lightPlayer(visibility);
    function playPlayer();
    static function unhighlightLastEntry();
    function get colorsManager():net.wargaming.managers.ColorSchemeManager;
    function get colorSchemeName():String;
    function getTextColorSchemeName();
    function setEntryName(value);
    function setVehicleClass(value);
    function setDead(isPermanent);
    function setPostmortem(isPostmortem);
    function isTeamPoint();
    function isFlagPoint();
    function isRepairPoint();
    function isResourcePoint();
    function isBackMarker();
    function isFortConsumables();
    function updateType();
    function showSector(deg1, deg2);
    function hideSector();
    function updateIfEntryIsPlayer();
    function draw();
    function getNormalScale();
    function initSectorLines();
    function onSectorLine1Loaded();
    function onSectorLine2Loaded();
    function onCameraWithDirectionLoaded();
    function onCameraWithDirectionIOError();
    function getMinimap():net.wargaming.ingame.Minimap;
    function onEnterFrameHandler();
    function sectorLineLoaded(sectorLine, deg, callback);
    function updateLinesScale(parentNormalScale);
    function checkForSectorLines();
    function initSectorContent();
    function updateVehicleName();
    function get vehicleNameTextField():TextField;
    function resumeAnimation()
    function stopAnimation()
    function initFlagPoint()
    function initRepairPoint()
}
