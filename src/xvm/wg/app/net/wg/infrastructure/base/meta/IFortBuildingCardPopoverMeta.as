package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IFortBuildingCardPopoverMeta extends IEventDispatcher
    {
        
        function openUpgradeWindowS(param1:Object) : void;
        
        function openAssignedPlayersWindowS(param1:Object) : void;
        
        function openDemountBuildingWindowS(param1:String) : void;
        
        function openDirectionControlWindowS() : void;
        
        function openBuyOrderWindowS() : void;
        
        function as_setData(param1:Object) : void;
        
        function as_setModernizationDestructionEnabling(param1:Boolean, param2:Boolean, param3:String, param4:String) : void;
    }
}
