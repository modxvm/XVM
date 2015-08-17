intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_worker:wot.VehicleMarkersManager.VehicleMarkerProxy;
    var m_team:String;
    /////////////////////////////////////////////////////////////////

    var m_entityName:String;
    var m_markerLabel:String;
    var m_speaking:Boolean;
    var m_squadIcon;

    var levelIcon:MovieClip;
    var iconLoader:net.wargaming.controls.UILoaderAlt;
    var hp_mc:MovieClip;
    var actionMarker:MovieClip;
    var marker:MovieClip;
    var hitLbl:gfx.core.UIComponent;
    var hitExplosion:gfx.core.UIComponent;
    var vNameField:TextField;
    var pNameField:TextField;
    var healthBar:MovieClip;
    var bgShadow:MovieClip;
    var flagMC:MovieClip;
    var squadIcon:MovieClip;

    static var ICON;
    static var LEVEL;
    static var HEALTH_LBL;
    static var HEALTH_BAR;
    static var P_NAME_LBL;
    static var V_NAME_LBL;
    static var DAMAGE_PANEL;

    function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String, pName:String,
        pClan:String, pRegion:String, curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean,
        hunt:Boolean, entityType:String, isFlagBearer:Boolean, squadIcon):Void;
    function update():Void;
    function updateMarkerSettings():Void;
    function setSpeaking(value:Boolean):Void;
    function setEntityName(value:String):Void;
    function updateHealth(curHealth:Number, flag:Number, damageType:String):Void;
    function updateState(newState:String, isImmediate:Boolean):Void;
    function showExInfo(show:Boolean):Void;
    function showActionMarker(actionState):Void;
    function updateFlagbearerState(isFlagbearer:Boolean):Void;

    function getPartVisibility(part);

    function settingsUpdate(flag);
    function getMarkerState();
    function setMarkerState(value);
    function setVehicleClass();
    function initMarkerLabel();
    function updateMarkerLabel();

    function get exInfo();
    function set exInfo(value);
    function get markerSettings();
    function set markerSettings(value);

    function get colorsManager():net.wargaming.managers.ColorSchemeManager;
    function get colorSchemeName();
}
