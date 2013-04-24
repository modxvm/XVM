intrinsic class gfx.core.UIComponent extends MovieClip
{
    public var initialized:Boolean;
    
    static function createInstance(context, symbol, name, depth, initObj);
    
    function get disabled():Boolean;
    function set disabled(value:Boolean):Void;
    function get visible():Boolean;
    function set visible(value:Boolean):Void;
    function get width():Number;
    function set width(value:Number):Void;
    function get height():Number;
    function set height(value:Number):Void;
    function setSize(width:Number, height:Number):Void;
    function get focused():Boolean;
    function set focused(value:Boolean):Void;
    function get displayFocus():Boolean;
    function set displayFocus(value:Boolean):Void;
    function handleInput(details, pathToFocus):Void;
    function invalidate():Void;
    function validateNow():Void;
    function toString():String;
    function configUI():Void;
    function initSize():Void;
    function draw():Void;
    function changeFocus():Void;
    function onMouseWheel(delta:Number, target:Object):Void;
    function scrollWheel(delta:Number):Void;

    // gfx.events.EventDispatcher inherits
    function addEventListener(event, scope, callBack);
    function removeEventListener(event, scope, callBack);
    function dispatchEvent(event);
    function hasEventListener(event);
}