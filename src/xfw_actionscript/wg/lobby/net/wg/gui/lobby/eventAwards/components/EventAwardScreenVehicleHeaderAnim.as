package net.wg.gui.lobby.eventAwards.components
{
    import scaleform.clik.constants.InvalidationType;

    public class EventAwardScreenVehicleHeaderAnim extends EventAwardScreenHeaderAnim
    {

        private static const DELIMITER_MARGIN_X:int = 20;

        private static const HEADER_EXTRA_MARGIN_BIG:int = -35;

        private static const HEADER_EXTRA_MARGIN_SMALL:int = -52;

        private static const HEADER_MARGIN_BIG:int = 58;

        private static const HEADER_MARGIN_SMALL:int = -27;

        private static const HEADER_EXTRA_SIZE_BIG:int = 144;

        private static const HEADER_EXTRA_SIZE_SMALL:int = 70;

        private static const HEADER_SIZE_BIG:int = 24;

        private static const HEADER_SIZE_SMALL:int = 18;

        private static const DELIMITER_MARGIN_Y_BIG:int = 18;

        private static const DELIMITER_MARGIN_Y_SMALL:int = 14;

        public var delimiterLeft:EventAwardScreenAnimatedContainer;

        public var delimiterRight:EventAwardScreenAnimatedContainer;

        public function EventAwardScreenVehicleHeaderAnim()
        {
            super();
        }

        override public function stageUpdate(param1:Number, param2:Number) : void
        {
            super.stageUpdate(param1,param2);
            invalidateSize();
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.validateSize();
            }
        }

        override protected function validateData() : void
        {
            if(data != null)
            {
                header.label = data.header;
                headerExtra.label = data.headerExtra;
            }
        }

        override protected function onDispose() : void
        {
            this.delimiterLeft.dispose();
            this.delimiterLeft = null;
            this.delimiterRight.dispose();
            this.delimiterRight = null;
            super.onDispose();
        }

        private function validateSize() : void
        {
            if(!data)
            {
                return;
            }
            if(screenH <= EventAwardScreenVehiclePrizeAnim.SCREEN_BREAK_POINT)
            {
                header.fontSize = HEADER_SIZE_SMALL;
                headerExtra.fontSize = HEADER_EXTRA_SIZE_SMALL;
                header.textY = HEADER_MARGIN_SMALL;
                headerExtra.textY = HEADER_EXTRA_MARGIN_SMALL;
                this.delimiterLeft.childY = this.delimiterRight.childY = DELIMITER_MARGIN_Y_SMALL + HEADER_MARGIN_SMALL;
            }
            else
            {
                header.fontSize = HEADER_SIZE_BIG;
                headerExtra.fontSize = HEADER_EXTRA_SIZE_BIG;
                headerExtra.textY = HEADER_EXTRA_MARGIN_BIG;
                header.textY = HEADER_MARGIN_BIG;
                this.delimiterLeft.childY = this.delimiterRight.childY = DELIMITER_MARGIN_Y_BIG + HEADER_MARGIN_BIG;
            }
            this.delimiterLeft.childX = header.x - DELIMITER_MARGIN_X - (header.contentWidth >> 1);
            this.delimiterRight.childX = header.x + DELIMITER_MARGIN_X + (header.contentWidth >> 1);
        }
    }
}
