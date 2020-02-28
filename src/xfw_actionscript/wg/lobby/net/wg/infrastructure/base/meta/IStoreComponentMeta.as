package net.wg.infrastructure.base.meta
{
    import flash.events.IEventDispatcher;

    public interface IStoreComponentMeta extends IEventDispatcher
    {

        function requestTableDataS(param1:Number, param2:Boolean, param3:String, param4:Object) : void;

        function requestFilterDataS(param1:String) : void;

        function onShowInfoS(param1:String) : void;

        function getNameS() : String;

        function onAddVehToCompareS(param1:String) : void;

        function onUpgradeModuleS(param1:int) : void;

        function as_initFiltersData(param1:Array, param2:String) : void;

        function as_completeInit() : void;

        function as_update() : void;

        function as_setFilterType(param1:Object) : void;

        function as_setSubFilter(param1:Object) : void;

        function as_setFilterOptions(param1:Object) : void;

        function as_scrollPosition(param1:int) : void;

        function as_setVehicleCompareAvailable(param1:Boolean) : void;

        function as_setActionAvailable(param1:Boolean) : void;
    }
}
