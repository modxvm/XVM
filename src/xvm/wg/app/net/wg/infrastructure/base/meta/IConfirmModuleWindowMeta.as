package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IConfirmModuleWindowMeta extends flash.events.IEventDispatcher
    {
        function submitS(arg1:Number, arg2:String):void;

        function as_setData(arg1:Object):void;

        function as_setSettings(arg1:Object):void;
    }
}
