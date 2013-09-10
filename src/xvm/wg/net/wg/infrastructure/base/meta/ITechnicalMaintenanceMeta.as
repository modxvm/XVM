package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface ITechnicalMaintenanceMeta extends flash.events.IEventDispatcher
    {
        function getEquipmentS(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String, arg6:String, arg7:int):void;

        function repairS():void;

        function setRefillSettingsS(arg1:String, arg2:Boolean, arg3:Boolean, arg4:Boolean):void;

        function showModuleInfoS(arg1:String):void;

        function fillVehicleS(arg1:Boolean, arg2:Boolean, arg3:Boolean, arg4:Boolean, arg5:Boolean, arg6:Boolean, arg7:Array, arg8:Array):void;

        function as_setData(arg1:Object):void;

        function as_setEquipment(arg1:Array, arg2:Array, arg3:Array):void;

        function as_onAmmoInstall():void;

        function as_setCredits(arg1:Number):void;

        function as_setGold(arg1:Number):void;
    }
}
