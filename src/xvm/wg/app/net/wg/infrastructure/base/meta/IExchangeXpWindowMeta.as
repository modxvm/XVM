package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IExchangeXpWindowMeta extends flash.events.IEventDispatcher
    {
        function as_vehiclesDataChanged(arg1:Boolean, arg2:Array):void;

        function as_totalExperienceChanged(arg1:Number):void;
    }
}
