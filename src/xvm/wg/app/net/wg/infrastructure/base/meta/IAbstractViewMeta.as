package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;
    
    public interface IAbstractViewMeta extends flash.events.IEventDispatcher
    {
        function registerFlashComponentS(arg1:net.wg.infrastructure.interfaces.IDAAPIModule, arg2:String):void;

        function unregisterFlashComponentS(arg1:String):void;

        function as_populate():void;

        function as_dispose():void;
    }
}
