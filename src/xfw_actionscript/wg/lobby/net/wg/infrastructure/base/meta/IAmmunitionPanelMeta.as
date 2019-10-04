package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IAmmunitionPanelMeta extends IEventDispatcher
    {

        function showTechnicalMaintenanceS() : void;

        function showCustomizationS() : void;

        function toRentContinueS() : void;

        function showChangeNationS() : void;

        function as_setAmmo(param1:Array, param2:Boolean) : void;

        function as_updateVehicleStatus(param1:Object) : void;

        function as_showBattleAbilitiesAlert(param1:Boolean) : void;

        function as_setCustomizationBtnCounter(param1:int) : void;
    }
}
