package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IExchangeFreeToTankmanXpWindowMeta extends flash.events.IEventDispatcher
    {
        function applyS():void;

        function onValueChangedS(arg1:Object):void;

        function calcValueRequestS(arg1:Number):void;

        function as_setInitData(arg1:Object):void;

        function as_setCalcValueResponse(arg1:Number):void;
    }
}
