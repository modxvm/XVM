package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.BaseDAAPIComponent;
    import net.wg.data.constants.Errors;

    public class VehiclePreviewModulesTabMeta extends BaseDAAPIComponent
    {

        public var setActiveState:Function;

        public function VehiclePreviewModulesTabMeta()
        {
            super();
        }

        public function setActiveStateS(param1:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
            this.setActiveState(param1);
        }
    }
}
