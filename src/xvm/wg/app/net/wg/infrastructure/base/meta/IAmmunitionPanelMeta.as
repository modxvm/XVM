package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;
    
    public interface IAmmunitionPanelMeta extends IEventDispatcher
    {
        
        function setVehicleModuleS(param1:String, param2:int, param3:String, param4:Boolean) : void;
        
        function showModuleInfoS(param1:String) : void;
        
        function showTechnicalMaintenanceS() : void;
        
        function showCustomizationS() : void;
        
        function highlightParamsS(param1:String) : void;
        
        function toRentContinueS() : void;
        
        function as_setData(param1:Array, param2:String) : void;
        
        function as_setAmmo(param1:Object) : void;
        
        function as_setVehicleHasTurret(param1:Boolean) : void;
        
        function as_setHistoricalBattle(param1:Number) : void;
        
        function as_setModulesEnabled(param1:Boolean) : void;
        
        function as_updateVehicleStatus(param1:String, param2:String, param3:String, param4:Boolean) : void;
    }
}
