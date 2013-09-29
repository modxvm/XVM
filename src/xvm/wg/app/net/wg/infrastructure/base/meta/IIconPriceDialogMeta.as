package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IIconPriceDialogMeta extends flash.events.IEventDispatcher
    {
        function as_setMessagePrice(arg1:String, arg2:String):void;

        function as_setPriceLabel(arg1:String):void;

        function as_setOperationAllowed(arg1:Boolean):void;
    }
}
