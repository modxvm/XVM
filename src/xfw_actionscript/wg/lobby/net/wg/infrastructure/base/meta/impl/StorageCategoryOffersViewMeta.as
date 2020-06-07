package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.storage.categories.BaseCategoryView;
    import net.wg.data.constants.Errors;

    public class StorageCategoryOffersViewMeta extends BaseCategoryView
    {

        public var navigateToStore:Function;

        public var openOfferWindow:Function;

        public function StorageCategoryOffersViewMeta()
        {
            super();
        }

        public function navigateToStoreS() : void
        {
            App.utils.asserter.assertNotNull(this.navigateToStore,"navigateToStore" + Errors.CANT_NULL);
            this.navigateToStore();
        }

        public function openOfferWindowS(param1:int) : void
        {
            App.utils.asserter.assertNotNull(this.openOfferWindow,"openOfferWindow" + Errors.CANT_NULL);
            this.openOfferWindow(param1);
        }
    }
}
