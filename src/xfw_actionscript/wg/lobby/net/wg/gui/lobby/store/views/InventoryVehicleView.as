package net.wg.gui.lobby.store.views
{
    import net.wg.gui.lobby.store.views.base.ViewUIElementVO;
    import net.wg.gui.lobby.store.views.data.FiltersVO;
    import net.wg.gui.lobby.store.StoreViewsEvent;

    public class InventoryVehicleView extends VehicleView
    {

        public function InventoryVehicleView()
        {
            super();
        }

        override protected function onTagsArrayRequest() : Vector.<ViewUIElementVO>
        {
            return null;
        }

        override public function setFiltersData(param1:FiltersVO, param2:Boolean) : void
        {
            super.setFiltersData(param1,param2);
            dispatchEvent(getStoreViewEvent(StoreViewsEvent.VIEW_CHANGE));
        }

        override protected function get isBrokenChkBxEnabled() : Boolean
        {
            return true;
        }
    }
}
