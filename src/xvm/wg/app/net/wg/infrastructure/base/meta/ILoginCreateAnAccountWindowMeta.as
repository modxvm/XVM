package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ILoginCreateAnAccountWindowMeta extends flash.events.IEventDispatcher
    {
        function onRegisterS(arg1:String):void;

        function as_updateTexts(arg1:String, arg2:String, arg3:String, arg4:String):void;

        function as_registerResponse(arg1:Boolean, arg2:String):void;
    }
}
