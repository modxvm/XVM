package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IOrdersPanelMeta extends IEventDispatcher
    {
        
        function getOrderTooltipBodyS(param1:String) : String;
        
        function as_setOrders(param1:Array) : void;
        
        function as_updateOrder(param1:Object) : void;
    }
}
