package net.wg.infrastructure.interfaces 
{
    import flash.display.*;
    import flash.events.*;
    
    public interface IManagedContainer extends flash.events.IEventDispatcher
    {
        function get type():String;

        function set type(arg1:String):void;

        function get manageSize():Boolean;

        function set manageSize(arg1:Boolean):void;

        function updateStage(arg1:Number, arg2:Number):void;

        function setFocused(arg1:Boolean=false):Boolean;

        function setFocusedView(arg1:flash.display.DisplayObject):void;

        function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function removeChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject;

        function contains(arg1:flash.display.DisplayObject):Boolean;
    }
}
