package net.wg.infrastructure.base.meta.impl
{
    import net.wg.infrastructure.base.SmartPopOverView;
    import net.wg.data.constants.Errors;

    public class CustomizationKitPopoverMeta extends SmartPopOverView
    {

        public var removeCustomizationKit:Function;

        public var updateAutoProlongation:Function;

        public function CustomizationKitPopoverMeta()
        {
            super();
        }

        public function removeCustomizationKitS() : void
        {
            App.utils.asserter.assertNotNull(this.removeCustomizationKit,"removeCustomizationKit" + Errors.CANT_NULL);
            this.removeCustomizationKit();
        }

        public function updateAutoProlongationS() : void
        {
            App.utils.asserter.assertNotNull(this.updateAutoProlongation,"updateAutoProlongation" + Errors.CANT_NULL);
            this.updateAutoProlongation();
        }
    }
}
