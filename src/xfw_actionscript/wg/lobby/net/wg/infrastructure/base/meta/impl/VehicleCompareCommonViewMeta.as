package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.AbstractScreen;
    import net.wg.data.constants.Errors;

    public class VehicleCompareCommonViewMeta extends AbstractScreen
    {

        public var closeView:Function;

        public function VehicleCompareCommonViewMeta()
        {
            super();
        }

        public function closeViewS() : void
        {
            App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
            this.closeView();
        }
    }
}
