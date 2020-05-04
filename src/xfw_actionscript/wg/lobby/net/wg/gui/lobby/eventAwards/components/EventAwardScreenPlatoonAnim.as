package net.wg.gui.lobby.eventAwards.components
{
    import net.wg.gui.lobby.eventAwards.data.EventAwardPlatoonVO;
    import flash.text.TextFieldAutoSize;
    import net.wg.gui.events.UILoaderEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventAwards.EventAwardScreen;

    public class EventAwardScreenPlatoonAnim extends EventAwardScreenRibbonAnim
    {

        private static const ICON_MARGIN_BIG:int = -81;

        private static const ICON_MARGIN_SMALL:int = -7;

        private static const SUB_ICON_MARGIN_BIG:int = -23;

        private static const SUB_ICON_MARGIN_SMALL:int = 1;

        private static const HEADER_MARGIN_BIG:int = -119;

        private static const HEADER_MARGIN_SMALL:int = -19;

        private static const HEADER_EXTRA_MARGIN_BIG:int = -142;

        private static const HEADER_EXTRA_MARGIN_SMALL:int = -42;

        private static const GENERAL_ICON_BIG:String = "192x192";

        private static const GENERAL_ICON_SMALL:String = "134x134";

        private static const TIER_ICON_BIG:String = "70x82";

        private static const TIER_ICON_SMALL:String = "52x62";

        public var header:EventAwardScreenAnimatedTextContainer;

        public var headerExtra:EventAwardScreenAnimatedTextContainer;

        public var icon:EventAwardScreenAnimatedLoaderContainer;

        public var subIcon:EventAwardScreenAnimatedLoaderContainer;

        private var _data:EventAwardPlatoonVO;

        public function EventAwardScreenPlatoonAnim()
        {
            super();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            this._data = new EventAwardPlatoonVO(param1);
            setRibbonAwardsData(this._data.awards);
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
            this.icon.autoSize = false;
            this.icon.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.subIcon.autoSize = false;
            this.subIcon.addEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.header.setHtmlText(this._data.header);
                this.headerExtra.setHtmlText(this._data.headerExtra);
                invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
                this.validateSize();
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.icon.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            this.subIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onLoaderCompleteHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.icon.dispose();
            this.icon = null;
            this.subIcon.dispose();
            this.subIcon = null;
            this.header.dispose();
            this.header = null;
            this.headerExtra.dispose();
            this.headerExtra = null;
            this._data.dispose();
            this._data = null;
            super.onDispose();
        }

        private function validateSize() : void
        {
            if(!this._data)
            {
                return;
            }
            this.icon.loaderX = -this.icon.loaderWidth >> 1;
            this.subIcon.loaderX = -this.subIcon.loaderWidth >> 1;
            if(screenH <= EventAwardScreen.SCREEN_BREAK_POINT)
            {
                this.icon.source = RES_ICONS.getGeneralIcon(GENERAL_ICON_SMALL,this._data.generalIconName);
                this.subIcon.source = RES_ICONS.getTierIcon(TIER_ICON_SMALL,this._data.tierLevel.toString());
                this.icon.loaderY = ICON_MARGIN_SMALL;
                this.subIcon.loaderY = SUB_ICON_MARGIN_SMALL;
                this.header.textY = HEADER_MARGIN_SMALL;
                this.headerExtra.textY = HEADER_EXTRA_MARGIN_SMALL;
            }
            else
            {
                this.icon.source = RES_ICONS.getGeneralIcon(GENERAL_ICON_BIG,this._data.generalIconName);
                this.subIcon.source = RES_ICONS.getTierIcon(TIER_ICON_BIG,this._data.tierLevel.toString());
                this.icon.loaderY = ICON_MARGIN_BIG;
                this.subIcon.loaderY = SUB_ICON_MARGIN_BIG;
                this.header.textY = HEADER_MARGIN_BIG;
                this.headerExtra.textY = HEADER_EXTRA_MARGIN_BIG;
            }
        }

        private function onLoaderCompleteHandler(param1:UILoaderEvent) : void
        {
            invalidateSize();
        }
    }
}
