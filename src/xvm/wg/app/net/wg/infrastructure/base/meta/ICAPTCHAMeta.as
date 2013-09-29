package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ICAPTCHAMeta extends flash.events.IEventDispatcher
    {
        function submitS(arg1:String):void;

        function reloadS():void;

        function as_setImage(arg1:String, arg2:Number, arg3:Number):void;

        function as_setErrorMessage(arg1:String):void;
    }
}
