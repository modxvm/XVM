package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortSettingsDayoffPopoverMeta extends IEventDispatcher
    {
        
        function onApplyS(param1:int) : void;
        
        function as_setDescriptionsText(param1:String, param2:String) : void;
        
        function as_setButtonsText(param1:String, param2:String) : void;
        
        function as_setButtonsTooltips(param1:String, param2:String) : void;
        
        function as_setData(param1:Object) : void;
    }
}
