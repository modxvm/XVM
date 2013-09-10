package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IUtilsManagerMeta extends flash.events.IEventDispatcher
    {
        function getNationNamesS():Array;

        function getNationIndicesS():Object;

        function getGUINationsS():Array;
    }
}
