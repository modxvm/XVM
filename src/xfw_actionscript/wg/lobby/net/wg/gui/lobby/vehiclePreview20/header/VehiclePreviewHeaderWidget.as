package net.wg.gui.lobby.vehiclePreview20.header
{
    import net.wg.gui.components.containers.inject.GFInjectComponent;
    import scaleform.clik.constants.InvalidationType;

    public class VehiclePreviewHeaderWidget extends GFInjectComponent implements IVehiclePreviewHeader
    {

        public static const HEIGHT:int = 212;

        private var _containerWidth:int;

        public function VehiclePreviewHeaderWidget()
        {
            super();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                setSize(this._containerWidth,HEIGHT);
            }
        }

        public function resize(param1:int, param2:int) : void
        {
            this._containerWidth = param1;
            invalidateSize();
        }
    }
}
