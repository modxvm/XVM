package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class MaintenanceComponentMeta extends BaseDAAPIComponent
    {

        public var refresh:Function;

        public function MaintenanceComponentMeta()
        {
            super();
        }

        public function refreshS() : void
        {
            App.utils.asserter.assertNotNull(this.refresh,"refresh" + Errors.CANT_NULL);
            this.refresh();
        }
    }
}
