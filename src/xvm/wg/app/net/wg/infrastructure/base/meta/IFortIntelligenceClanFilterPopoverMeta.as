package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    import net.wg.gui.lobby.fortifications.data.IntelligenceClanFilterVO;
    
    public interface IFortIntelligenceClanFilterPopoverMeta extends IEventDispatcher
    {
        
        function useFilterS(param1:IntelligenceClanFilterVO, param2:Boolean) : void;
        
        function getAvailabilityProviderS() : Array;
        
        function as_setDescriptionsText(param1:String, param2:String, param3:String, param4:String) : void;
        
        function as_setButtonsText(param1:String, param2:String, param3:String) : void;
        
        function as_setButtonsTooltips(param1:String, param2:String) : void;
        
        function as_setData(param1:Object) : void;
    }
}
