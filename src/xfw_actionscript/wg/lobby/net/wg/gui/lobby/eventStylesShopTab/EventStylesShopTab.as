package net.wg.gui.lobby.eventStylesShopTab
{
    import net.wg.infrastructure.base.meta.impl.EventStylesShopTabMeta;
    import net.wg.infrastructure.base.meta.IEventStylesShopTabMeta;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import net.wg.gui.lobby.eventStylesShopTab.components.ShopTabContent;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventStylesShopTab.data.EventStylesShopTabDataVO;
    import scaleform.clik.constants.InvalidationType;
    import scaleform.clik.events.ButtonEvent;
    import net.wg.gui.lobby.eventStylesShopTab.events.StylesShopTabEvent;

    public class EventStylesShopTab extends EventStylesShopTabMeta implements IEventStylesShopTabMeta
    {

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const CONTENT_OFFSET:int = 20;

        public var backBtn:ISoundButtonEx = null;

        public var content:ShopTabContent = null;

        public var bg:MovieClip = null;

        public var messengerBg:Sprite = null;

        private var _data:EventStylesShopTabDataVO = null;

        public function EventStylesShopTab()
        {
            super();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        override protected function onEscapeKeyDown() : void
        {
            if(visible)
            {
                closeViewS();
            }
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.bg.width = _width;
                this.bg.height = _height + this.messengerBg.height;
                this.content.x = _width >> 1;
                closeBtn.validateNow();
                closeBtn.x = width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
            }
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                this.content.setData(this._data);
            }
            if(this._data != null && _height > 0 && isInvalid(InvalidationType.SIZE,InvalidationType.DATA))
            {
                this.content.setSize(_width,_height);
                this.content.validateNow();
                this.content.y = (_height - this.content.getContentHeight() >> 1) + CONTENT_OFFSET;
            }
        }

        override protected function setData(param1:EventStylesShopTabDataVO) : void
        {
            this._data = param1;
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.backBtn.addEventListener(ButtonEvent.CLICK,this.onBackClickHandler);
            this.content.addEventListener(StylesShopTabEvent.BANNER_CLICK,this.onBannerClickHandler);
            this.content.addEventListener(StylesShopTabEvent.TANK_CLICK,this.onTankClickHandler);
            closeBtn.label = EVENT.TRADESTYLES_CLOSE;
            this.backBtn.label = EVENT.TRADESTYLES_BACK;
        }

        override protected function onBeforeDispose() : void
        {
            this.backBtn.removeEventListener(ButtonEvent.CLICK,this.onBackClickHandler);
            this.content.removeEventListener(StylesShopTabEvent.BANNER_CLICK,this.onBannerClickHandler);
            this.content.removeEventListener(StylesShopTabEvent.TANK_CLICK,this.onTankClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.backBtn.dispose();
            this.backBtn = null;
            this.content.dispose();
            this.content = null;
            this.bg = null;
            this.messengerBg = null;
            this._data = null;
            super.onDispose();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        private function onBannerClickHandler(param1:StylesShopTabEvent) : void
        {
            onBannerClickS(param1.index);
        }

        private function onTankClickHandler(param1:StylesShopTabEvent) : void
        {
            onTankClick(param1.index);
        }

        private function onBackClickHandler(param1:ButtonEvent) : void
        {
            closeViewS();
        }
    }
}
