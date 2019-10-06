package net.wg.gui.components.interfaces
{
    import net.wg.infrastructure.interfaces.entity.IDisposable;
    import flash.events.IEventDispatcher;
    import scaleform.clik.interfaces.IDataProvider;
    import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;

    public interface IVehicleSelector extends IDisposable, IEventDispatcher
    {

        function setHeaderDP(param1:IDataProvider) : void;

        function setFiltersData(param1:IVehicleSelectorFilterVO) : void;

        function getListDP() : IDataProvider;

        function updateTableSortField(param1:String, param2:String) : void;
    }
}
