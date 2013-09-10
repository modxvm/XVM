package net.wg.infrastructure.interfaces 
{
    import flash.display.*;
    import flash.events.*;
    import scaleform.clik.interfaces.*;
    
    public interface IView extends net.wg.infrastructure.interfaces.IDAAPIModule, flash.events.IEventDispatcher, scaleform.clik.interfaces.IUIComponent
    {
        function get as_token():String;

        function set as_token(arg1:String):void;

        function get as_alias():String;

        function set as_alias(arg1:String):void;

        function get as_name():String;

        function set as_name(arg1:String):void;

        function get as_config():Object;

        function set as_config(arg1:Object):void;

        function get loader():flash.display.Loader;

        function set loader(arg1:flash.display.Loader):void;

        function getSubContainer():net.wg.infrastructure.interfaces.IManagedContainer;

        function playShowTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean;

        function playHideTween(arg1:flash.display.DisplayObject, arg2:Function=null):Boolean;

        function setFocus():void;

        function removeFocus():void;

        function setViewSize(arg1:Number, arg2:Number):void;

        function updateStage(arg1:Number, arg2:Number):void;
    }
}
