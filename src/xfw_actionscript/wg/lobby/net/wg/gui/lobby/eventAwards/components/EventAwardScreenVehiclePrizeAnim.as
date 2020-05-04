package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.personalMissions.components.PersonalMissionExtraAwardDesc;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventAwards.data.EventAwardVehiclePrizeVO;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenVehiclePrizeAnim extends EventAwardScreenRibbonAnim
    {

        public static const SCREEN_BREAK_POINT:uint = 1017;

        private static const ICON_MARGIN_BIG:int = -30;

        private static const ICON_MARGIN_SMALL:int = 130;

        private static const DESC_MARGIN_BIG:int = -42;

        private static const DESC_MARGIN_SMALL:int = 12;

        private static const RIBBON_MARGIN_BIG:int = 80;

        private static const RIBBON_MARGIN_SMALL:int = 85;

        private static const DESC_SIZE_BIG:int = 25;

        private static const DESC_SIZE_SMALL:int = 21;

        private static const VEHICLE_DESC_GAP:int = 6;

        private static const SIZE_BIG:String = "big";

        private static const SIZE_SMALL:String = "small";

        private static const DESC_ORIGIN_POSITION:Object = {
            "level":-37,
            "icon":-54,
            "name":-37
        };

        public var vehicleDesk:PersonalMissionExtraAwardDesc;

        public var vehicle:EventAwardScreenAnimatedLoaderContainer;

        public var shineBig:MovieClip = null;

        public var picRibbon:EventAwardScreenAnimatedContainer;

        private var _data:EventAwardVehiclePrizeVO;

        public function EventAwardScreenVehiclePrizeAnim()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            this._data = new EventAwardVehiclePrizeVO(param1);
            setRibbonAwardsData(this._data.awards);
        }

        override public function stageUpdate(param1:Number, param2:Number) : void
        {
            super.stageUpdate(param1,param2);
            invalidateSize();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.shineBig.mouseEnabled = false;
            this.vehicle.autoSize = false;
            this.vehicle.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.vehicleDesk.extraGap = VEHICLE_DESC_GAP;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data && isInvalid(InvalidationType.DATA))
            {
                this.vehicleDesk.setDesc(this._data.vehicleTypeIcon,this._data.vehicleLevel,this._data.vehicleName);
                this.vehicle.source = this._data.vehicleSrc;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.validateSize();
            }
        }

        override protected function onDispose() : void
        {
            stop();
            this._data.dispose();
            this._data = null;
            this.vehicleDesk.dispose();
            this.vehicleDesk = null;
            this.vehicle.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.vehicle.dispose();
            this.vehicle = null;
            this.shineBig = null;
            this.picRibbon.dispose();
            this.picRibbon = null;
            super.onDispose();
        }

        private function validateSize() : void
        {
            if(!this._data)
            {
                return;
            }
            if(screenH <= SCREEN_BREAK_POINT)
            {
                this.picRibbon.gotoAndStop(SIZE_SMALL);
                this.picRibbon.childY = RIBBON_MARGIN_SMALL;
                this.vehicle.loaderY = -this.vehicle.loaderWidth + ICON_MARGIN_SMALL >> 1;
                this.vehicleDesk.setSize(DESC_SIZE_SMALL,DESC_SIZE_SMALL);
                this.vehicleDesk.setComponentsY(DESC_ORIGIN_POSITION.level + DESC_MARGIN_SMALL,DESC_ORIGIN_POSITION.icon + DESC_MARGIN_SMALL,DESC_ORIGIN_POSITION.name + DESC_MARGIN_SMALL);
            }
            else
            {
                this.picRibbon.gotoAndStop(SIZE_BIG);
                this.picRibbon.childY = RIBBON_MARGIN_BIG;
                this.vehicle.loaderY = -this.vehicle.loaderHeight + ICON_MARGIN_BIG >> 1;
                this.vehicleDesk.setSize(DESC_SIZE_BIG,DESC_SIZE_BIG);
                this.vehicleDesk.setComponentsY(DESC_ORIGIN_POSITION.level + DESC_MARGIN_BIG,DESC_ORIGIN_POSITION.icon + DESC_MARGIN_BIG,DESC_ORIGIN_POSITION.name + DESC_MARGIN_BIG);
            }
            this.vehicle.loaderX = -this.vehicle.loaderWidth >> 1;
        }

        override public function get height() : Number
        {
            return this.vehicle.height;
        }

        override public function get width() : Number
        {
            return this.vehicle.width;
        }

        private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
