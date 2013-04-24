intrinsic class net.wargaming.ingame.VehicleMarker extends gfx.core.UIComponent implements wot.VehicleMarkersManager.IVehicleMarker
{
    /////////////////////////////////////////////////////////////////
    // XVM
    var xvm_proxy:wot.VehicleMarkersManager.VehicleMarkerProxy; 
    /////////////////////////////////////////////////////////////////

    var m_entityName:String;
    
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

    function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String,
        curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean, hunt:Boolean, entityType:String):Void;
    function update():Void;
    function updateMarkerSettings():Void;
    function setSpeaking(value:Boolean):Void;
    function setEntityName(value:String):Void;
    function updateHealth(curHealth:Number, flag:Number, damageType:String):Void;
    function updateState(newState:String, isImmediate:Boolean):Void;
    function showExInfo(show:Boolean):Void;
    function showActionMarker(actionState):Void;

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
}
