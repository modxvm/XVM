package net.wg.gui.lobby.store.views.base.interfaces
{
    import net.wg.infrastructure.interfaces.IViewStackContent;
    import flash.events.IEventDispatcher;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.data.VO.ShopSubFilterData;

    public interface IStoreMenuView extends IViewStackContent, IEventDispatcher
    {

        function setFiltersData(param1:FiltersVO, param2:Boolean) : void;

        function setSubFilterData(param1:int, param2:ShopSubFilterData) : void;

        function updateSubFilter(param1:int) : void;

        function getFiltersData() : FiltersVO;

        function resetTemporaryHandlers() : void;

        function setUIName(param1:String, param2:Function) : void;

        function get fittingType() : String;
    }
}
