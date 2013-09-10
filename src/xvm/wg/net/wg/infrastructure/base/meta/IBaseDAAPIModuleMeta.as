package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IBaseDAAPIModuleMeta extends flash.events.IEventDispatcher
    {
        function as_populate():void;

        function as_dispose():void;
    }
}
