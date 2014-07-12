package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IPremiumFormMeta extends IEventDispatcher
    {
        
        function onPremiumBuyS(param1:Number, param2:Number) : void;
        
        function onPremiumDataRequestS() : void;
        
        function as_setCosts(param1:Array) : void;
        
        function as_setGold(param1:Number) : void;
        
        function as_setPremium(param1:Boolean) : void;
    }
}
