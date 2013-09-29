package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IVehicleBuyWindowMeta extends flash.events.IEventDispatcher
    {
        function submitS(arg1:Object):void;

        function storeSettingsS(arg1:Boolean):void;

        function as_setGold(arg1:Number):void;

        function as_setCredits(arg1:Number):void;

        function as_setInitData(arg1:Object):void;
    }
}
