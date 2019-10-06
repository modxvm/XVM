package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.storage.categories.BaseCategoryView;
    import net.wg.data.constants.Errors;

    public class RentVehiclesTabViewMeta extends BaseCategoryView
    {

        public var removeItem:Function;

        public function RentVehiclesTabViewMeta()
        {
            super();
        }

        public function removeItemS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.removeItem,"removeItem" + Errors.CANT_NULL);
            this.removeItem(param1);
        }
    }
}
