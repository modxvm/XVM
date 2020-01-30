package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.storage.categories.BaseCategoryView;
    import net.wg.data.constants.Errors;

    public class RegularItemsWithTypeFilterTabViewMeta extends BaseCategoryView
    {

        public var navigateToStore:Function;

        public function RegularItemsWithTypeFilterTabViewMeta()
        {
            super();
        }

        public function navigateToStoreS() : void
        {
            App.utils.asserter.assertNotNull(this.navigateToStore,"navigateToStore" + Errors.CANT_NULL);
            this.navigateToStore();
        }
    }
}
