package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IAmmunitionPanelMeta extends IEventDispatcher
    {

        function showTechnicalMaintenanceS() : void;

        function showCustomizationS() : void;

        function toRentContinueS() : void;

        function showChangeNationS() : void;

        function toggleNYCustomizationS(param1:Boolean) : void;

        function onNYBonusPanelClickedS() : void;

        function as_setAmmo(param1:Array, param2:Boolean) : void;

        function as_updateVehicleStatus(param1:Object) : void;

        function as_showBattleAbilitiesAlert(param1:Boolean) : void;

        function as_setCustomizationBtnCounter(param1:int) : void;

        function as_setBoosterBtnCounter(param1:int) : void;

        function as_setNeyYearVehicleBonus(param1:Boolean, param2:String, param3:String, param4:String, param5:String) : void;

        function as_setNYCustomizationSlotState(param1:Boolean, param2:Boolean) : void;
    }
}
