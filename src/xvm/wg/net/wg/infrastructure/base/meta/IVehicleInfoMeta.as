package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IVehicleInfoMeta extends flash.events.IEventDispatcher
    {
        function getVehicleInfoS():void;

        function onCancelClickS():void;

        function as_setVehicleInfo(arg1:Object):void;
    }
}
