package net.wg.gui.lobby.eventAwards.components
{
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventAwards.data.EventAwardUnitVO;
    import flash.text.TextFieldAutoSize;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventAwards.EventAwardScreen;

    public class EventAwardScreenUnitAnim extends EventAwardScreenRibbonAnim
    {

        private static const HEADER_MARGIN_BIG:int = -116;

        private static const HEADER_MARGIN_SMALL:int = -17;

        private static const HEADER_EXTRA_MARGIN_BIG:int = -139;

        private static const HEADER_EXTRA_MARGIN_SMALL:int = -40;

        private static const ICON_SMALL:String = "small";

        private static const ICON_BIG:String = "big";

        public var header:EventAwardScreenAnimatedTextContainer;

        public var headerExtra:EventAwardScreenAnimatedTextContainer;

        public var icon:MovieClip;

        protected var data:EventAwardUnitVO = null;

        public function EventAwardScreenUnitAnim()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            this.data = new EventAwardUnitVO(param1);
            setRibbonAwardsData(this.data.awards);
            invalidateData();
        }

        override public function stageUpdate(param1:Number, param2:Number) : void
        {
            super.stageUpdate(param1,param2);
            invalidateSize();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.header.autoSize = TextFieldAutoSize.CENTER;
            this.headerExtra.autoSize = TextFieldAutoSize.CENTER;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this.data != null && isInvalid(InvalidationType.DATA))
            {
                this.header.setHtmlText(this.data.header);
                this.headerExtra.setHtmlText(this.data.headerExtra);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.validateSize();
            }
        }

        override protected function onDispose() : void
        {
            this.header.dispose();
            this.header = null;
            this.headerExtra.dispose();
            this.headerExtra = null;
            this.data.dispose();
            this.data = null;
            this.icon = null;
            super.onDispose();
        }

        private function validateSize() : void
        {
            if(screenH <= EventAwardScreen.SCREEN_BREAK_POINT)
            {
                this.header.textY = HEADER_MARGIN_SMALL;
                this.headerExtra.textY = HEADER_EXTRA_MARGIN_SMALL;
                this.icon.gotoAndStop(ICON_SMALL);
            }
            else
            {
                this.header.textY = HEADER_MARGIN_BIG;
                this.headerExtra.textY = HEADER_EXTRA_MARGIN_BIG;
                this.icon.gotoAndStop(ICON_BIG);
            }
        }
    }
}
