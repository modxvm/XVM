package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IAmmunitionPanelMeta extends flash.events.IEventDispatcher
    {
        function setVehicleModuleS(arg1:String, arg2:int, arg3:String, arg4:Boolean):void;

        function showModuleInfoS(arg1:String):void;

        function showTechnicalMaintenanceS():void;

        function showCustomizationS():void;

        function highlightParamsS(arg1:String):void;

        function as_setData(arg1:Array, arg2:String):void;

        function as_setAmmo(arg1:Object):void;

        function as_setVehicleHasTurret(arg1:Boolean):void;
    }
}
