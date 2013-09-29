package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IGameInputManagerMeta extends flash.events.IEventDispatcher
    {
        function handleGlobalKeyEventS(arg1:Number, arg2:String):void;

        function as_addKeyHandler(arg1:Number, arg2:String, arg3:Boolean):void;

        function as_clearKeyHandler(arg1:Number, arg2:String):void;
    }
}
