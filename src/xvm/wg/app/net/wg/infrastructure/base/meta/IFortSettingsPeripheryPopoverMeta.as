package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortSettingsPeripheryPopoverMeta extends IEventDispatcher
    {
        
        function onApplyS(param1:int) : void;
        
        function as_setData(param1:Object) : void;
        
        function as_setTexts(param1:Object) : void;
    }
}
