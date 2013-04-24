/**
 * Defines the methods that all Vehicle Marker components must define.
 */

interface wot.VehicleMarkersManager.IVehicleMarker
{
    /**
     * called by Battle.pyc
     */

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

    // UICompinent // TODO: Cleanup, not all methods required.
    function get visible():Boolean;
    function set visible(value:Boolean):Void;
    function get disabled():Boolean;
    function set disabled(value):Void;

    function onLoad():Void;
    function configUI():Void;
    function setSize(width:Number, height:Number):Void;
    function validateNow():Void;

    function invalidate():Void;
    function initSize():Void;
    function draw():Void;
    function changeFocus():Void;
    function onMouseWheel(delta:Number, target:Object):Void;
    function scrollWheel(delta:Number):Void;

    function get width():Number;
    function set width(value:Number):Void;
    function get height():Number;
    function set height(value:Number):Void;
    function get focused():Boolean;
    function set focused(value:Boolean):Void;
    function get displayFocus():Boolean;
    function set displayFocus(value:Boolean):Void;

    function handleInput(details, pathToFocus):Void;
    function toString():String;
}
