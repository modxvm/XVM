package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface ICyberSportIntroMeta extends IEventDispatcher
    {
        
        function requestVehicleSelectionS() : void;
        
        function startAutoMatchingS() : void;
        
        function showSelectorPopupS() : void;
        
        function as_setSelectedVehicles(param1:Array, param2:String, param3:Boolean) : void;
    }
}
