package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.lobby.storage.categories.BaseCategoryView;
    import net.wg.data.constants.Errors;

    public class StorageCategoryCustomizationViewMeta extends BaseCategoryView
    {

        public var navigateToCustomization:Function;

        public var sellItem:Function;

        public function StorageCategoryCustomizationViewMeta()
        {
            super();
        }

        public function navigateToCustomizationS() : void
        {
            App.utils.asserter.assertNotNull(this.navigateToCustomization,"navigateToCustomization" + Errors.CANT_NULL);
            this.navigateToCustomization();
        }

        public function sellItemS(param1:Number) : void
        {
            App.utils.asserter.assertNotNull(this.sellItem,"sellItem" + Errors.CANT_NULL);
            this.sellItem(param1);
        }
    }
}
