package net.wg.gui.lobby.vehicleCompare.configurator
{
    import net.wg.gui.lobby.hangar.VehicleParameters;
    import flash.display.Sprite;
    import net.wg.data.constants.generated.VEHICLE_COMPARE_CONSTANTS;
    import scaleform.clik.constants.InvalidationType;

    public class VehConfParameters extends VehicleParameters
    {

        private static const INV_SHADOW:String = "InvShadow";

        private static const BOTTOM_SHADOW_OFFSET:int = 8;

        private static const TOP_SHADOW_OFFSET:int = 11;

        public var topShadow:Sprite;

        public var bottomShadow:Sprite;

        public function VehConfParameters()
        {
            super();
            this.topShadow.mouseEnabled = this.topShadow.mouseChildren = false;
            this.bottomShadow.mouseEnabled = this.bottomShadow.mouseChildren = false;
        }

        override protected function getRendererLinkage() : String
        {
            return VEHICLE_COMPARE_CONSTANTS.VEHICLE_CONFIGURATOR_PARAM_RENDERER_LINKAGE;
        }

        override protected function configUI() : void
        {
            super.configUI();
            _snapHeightToRenderers = false;
            bg.visible = false;
        }

        override protected function onDispose() : void
        {
            this.topShadow = null;
            this.bottomShadow = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:* = 0;
            var _loc2_:* = false;
            super.draw();
            if(isInvalid(InvalidationType.SIZE) || isInvalid(INV_SHADOW))
            {
                _loc1_ = paramsList.rowHeight * paramsList.dataProvider.length;
                _loc2_ = _loc1_ > height;
                this.topShadow.visible = this.bottomShadow.visible = _loc2_;
                this.topShadow.y = TOP_SHADOW_OFFSET;
                this.bottomShadow.y = height + BOTTOM_SHADOW_OFFSET;
            }
        }

        override protected function onRendererClick() : void
        {
            super.onRendererClick();
            invalidate(INV_SHADOW);
        }
    }
}
