package net.wg.infrastructure.base.meta 
{
    import flash.events.*;
    
    public interface IRecruitWindowMeta extends flash.events.IEventDispatcher
    {
        function updateVehicleClassDropdownS(arg1:Number):void;

        function updateVehicleTypeDropdownS(arg1:Number, arg2:String):void;

        function updateRoleDropdownS(arg1:Number, arg2:String, arg3:Number):void;

        function updateNationDropdownS():void;

        function buyTankmanS(arg1:Number, arg2:Number, arg3:String, arg4:Number, arg5:Number):void;

        function updateAllDropdownsS(arg1:Number, arg2:String, arg3:Number, arg4:String):void;

        function as_setVehicleClassDropdown(arg1:Array):void;

        function as_setVehicleTypeDropdown(arg1:Array):void;

        function as_setRoleDropdown(arg1:Array):void;

        function as_setCreditsChanged(arg1:Number):void;

        function as_setGoldChanged(arg1:Number):void;

        function as_initData(arg1:Object):void;

        function as_setNations(arg1:Array):void;

        function as_setAllDropdowns(arg1:Array, arg2:Array, arg3:Array, arg4:Array):void;
    }
}
