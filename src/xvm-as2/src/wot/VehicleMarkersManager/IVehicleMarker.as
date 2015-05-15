/**
 * Defines the methods that all Vehicle Marker components must define.
 */

interface wot.VehicleMarkersManager.IVehicleMarker
{
    /**
     * called by Battle.pyc
     */

    function init(vClass:String, vIconSource:String, vType:String, vLevel:Number, pFullName:String, pName:String,
        pClan:String, pRegion:String, curHealth:Number, maxHealth:Number, entityName:String, speaking:Boolean,
        hunt:Boolean, entityType:String, isFlagBearer:Boolean):Void;
    function update():Void;
    function updateMarkerSettings():Void;
    function setSpeaking(value:Boolean):Void;
    function setEntityName(value:String):Void;
    function updateHealth(curHealth:Number, flag:Number, damageType:String):Void;
    function updateState(newState:String, isImmediate:Boolean):Void;
    function showExInfo(show:Boolean):Void;
    function showActionMarker(actionState):Void;
    function updateFlagbearerState(isFlagbearer:Boolean):Void;

    /**
     * MovieClip
     */
    function onEnterFrame();
}
