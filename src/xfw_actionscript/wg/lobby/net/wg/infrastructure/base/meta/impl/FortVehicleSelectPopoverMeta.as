package net.wg.infrastructure.base.meta.impl
{
    import net.wg.gui.components.popovers.VehicleSelectPopoverBase;
    import net.wg.data.constants.Errors;

    public class FortVehicleSelectPopoverMeta extends VehicleSelectPopoverBase
    {

        public var onFilterChange:Function;

        public function FortVehicleSelectPopoverMeta()
        {
            super();
        }

        public function onFilterChangeS(param1:int, param2:Boolean) : void
        {
            App.utils.asserter.assertNotNull(this.onFilterChange,"onFilterChange" + Errors.CANT_NULL);
            this.onFilterChange(param1,param2);
        }
    }
}
