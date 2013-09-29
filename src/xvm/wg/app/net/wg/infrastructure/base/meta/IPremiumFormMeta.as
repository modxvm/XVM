package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IPremiumFormMeta extends flash.events.IEventDispatcher
    {
        function onPremiumBuyS(arg1:Number, arg2:Number):void;

        function onPremiumDataRequestS():void;

        function as_setCosts(arg1:Array):void;

        function as_setGold(arg1:Number):void;

        function as_setPremium(arg1:Boolean):void;
    }
}
