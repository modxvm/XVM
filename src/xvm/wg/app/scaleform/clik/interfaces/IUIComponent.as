package scaleform.clik.interfaces 
{
    import flash.events.*;
    import flash.geom.*;
    import scaleform.clik.core.*;
    import scaleform.clik.events.*;
    
    public interface IUIComponent extends flash.events.IEventDispatcher
    {
        function get x():Number;

        function set x(arg1:Number):void;

        function get y():Number;

        function set y(arg1:Number):void;

        function get width():Number;

        function set width(arg1:Number):void;

        function get height():Number;

        function set height(arg1:Number):void;

        function get enabled():Boolean;

        function set enabled(arg1:Boolean):void;

        function get tabEnabled():Boolean;

        function set tabEnabled(arg1:Boolean):void;

        function get scale9Grid():flash.geom.Rectangle;

        function set scale9Grid(arg1:flash.geom.Rectangle):void;

        function get alpha():Number;

        function set alpha(arg1:Number):void;

        function get doubleClickEnabled():Boolean;

        function set doubleClickEnabled(arg1:Boolean):void;

        function get focusTarget():scaleform.clik.core.UIComponent;

        function set focusTarget(arg1:scaleform.clik.core.UIComponent):void;

        function validateNow(arg1:flash.events.Event=null):void;

        function handleInput(arg1:scaleform.clik.events.InputEvent):void;
    }
}
