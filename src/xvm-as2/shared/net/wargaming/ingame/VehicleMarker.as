intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.VehicleMarkersManager.VehicleMarkerProxy;
    var m_team:String;
    /////////////////////////////////////////////////////////////////

    var m_markerLabel:String;
    var m_entityName:String;
    var m_curHealth:Number;
    var m_maxHealth:Number;
    var m_speaking:Boolean;
    var m_hunt:Boolean;
    var m_entityType:String;
    var m_source:String;
    var m_level:Number;
    var m_isPopulated:Boolean;
    var _flag:String;
    var _damageType:String;
    var _isInited:Boolean;
    var _isFlagbearer:Boolean;
    var m_squadIconIdx:Number;
    var _exInfoOverride:Boolean;

    var levelIcon:MovieClip;
    var iconLoader:net.wargaming.controls.UILoaderAlt;
    var hp_mc:MovieClip;
    var actionMarker:MovieClip;
    var marker:MovieClip;
    var marker2:MovieClip;
    var hitLbl:gfx.core.UIComponent;
    var hitExplosion:gfx.core.UIComponent;
    var pNameField:TextField;
    var vNameField:TextField;
    var healthBar:MovieClip;
    var bgShadow:MovieClip;
    var squadIcon:MovieClip;

    static var ICON;
    static var LEVEL;
    static var HEALTH_LBL;
    static var HEALTH_BAR;
    static var P_NAME_LBL;
    static var V_NAME_LBL;
    static var DAMAGE_PANEL;
    static var SQUAD_ICON;
    static var ACTION_Y;
    static var ICON_Y;
    static var LEVEL_Y;
    static var V_NAME_LBL_Y;
    static var P_NAME_LBL_Y;
    static var HEALTH_BAR_Y;
    static var MARKER_Y;
    static var BG_SHADOW_Y;
    static var FLAG_Y_OFFSET1;
    static var FLAG_Y_OFFSET2;
    static var ICON_OFFSET;
    static var LEVEL_OFFSET;
    static var V_NAME_LBL_OFFSET;
    static var P_NAME_LBL_OFFSET;
    static var HEALTH_BAR_OFFSET;
    static var VEHICLE_ICON_OFFSET_X;
    static var OFFSETS;
    static var s_offsets;
    static var s_vehicleDestroyColor;
    static var s_showExInfo;
    static var s_markerSettings;

    function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String, pName:String,
        pClan:String, pRegion:String, curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean,
        hunt:Boolean, entityType:String, isFlagBearer:Boolean, squadIconIdx:Number);
    function settingsUpdate(flag);
    function update();
    function updateMarkerSettings();
    function onSplashHidden(event);
    function layoutParts(partsVisArray);
    function get colorsManager():net.wargaming.managers.ColorSchemeManager;
    function get colorSchemeName():String;
    function get colorSchemeTankName();
    function get vehicleDestroyed();
    function get isEnabledExInfo();
    function isSpeaking();
    function setSpeaking(value:Boolean);
    function getMarkerState();
    function setMarkerState(value);
    function setEntityName(value:String);
    function updateHealth(curHealth:Number, flag:Number, damageType:String);
    function updateFlagbearerState(isFlagbearer:Boolean);
    function updateState(newState:String, isImmediate:Boolean);
    function showExInfo(show:Boolean);
    function showActionMarker(actionState);
    function getPartVisibility(part);
    function getNameText(part);
    function getHelthText();
    function getHealthPercents();
    function configUI();
    function setupIconLoader();
    function setupSquadIcon();
    function populateData();
    function setVehicleClass();
    function initMarkerLabel();
    function updateMarkerLabel();
    function _onCompleteLoad(event);
    function _getMarkerFrame();
    function get exInfo();
    function set exInfo(value);
    function get markerSettings();
    function set markerSettings(value);
    function getSquadIconY();
}
