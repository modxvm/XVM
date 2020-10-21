package net.wg.gui.lobby.eventShopTab
{
    import net.wg.infrastructure.base.meta.impl.EventShopTabMeta;
    import net.wg.infrastructure.base.meta.IEventShopTabMeta;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import net.wg.gui.lobby.eventShopTab.components.ShopBannersContainer;
    import net.wg.gui.lobby.eventCoins.EventCoins;
    import net.wg.gui.lobby.eventShopTab.data.EventPackVO;
    import net.wg.data.constants.generated.HANGAR_ALIASES;
    import net.wg.gui.lobby.eventShopTab.events.ShopTabEvent;
    import scaleform.clik.constants.InvalidationType;

    public class EventShopTab extends EventShopTabMeta implements IEventShopTabMeta
    {

        private static const CLOSE_BTN_OFFSET:int = 10;

        private static const CONTENT_WIDTH_BIG:int = 1060;

        private static const CONTENT_WIDTH_SMALL:int = 800;

        private static const COINS_Y:int = 162;

        private static const COINS_OFFSET:int = 62;

        private static const CONTENT_Y_BIG:int = 200;

        private static const CONTENT_Y_SMALL:int = 160;

        public var bg:MovieClip = null;

        public var messengerBg:Sprite = null;

        public var content:ShopBannersContainer = null;

        public var eventCoins:EventCoins = null;

        public function EventShopTab()
        {
            super();
        }

        public function as_setVisible(param1:Boolean) : void
        {
            visible = param1;
        }

        public function as_setExpireDate(param1:String) : void
        {
            this.content.setExpireDate(param1);
        }

        override protected function setPackBannersData(param1:EventPackVO, param2:EventPackVO) : void
        {
            this.content.setBannersData(param1,param2);
        }

        override public function updateStage(param1:Number, param2:Number) : void
        {
            super.updateStage(param1,param2);
            var _loc3_:* = param1 >> 1;
            this.content.updateSize(param1,param2);
            this.content.x = _loc3_;
            this.content.y = this.content.isSmallSize?CONTENT_Y_SMALL:CONTENT_Y_BIG;
            var _loc4_:int = this.content.isSmallSize?CONTENT_WIDTH_SMALL:CONTENT_WIDTH_BIG;
            var _loc5_:int = this.content.isSmallSize?COINS_OFFSET:0;
            this.eventCoins.x = _loc3_ + (_loc4_ >> 1);
            this.eventCoins.y = COINS_Y - _loc5_;
        }

        override protected function configUI() : void
        {
            super.configUI();
            closeBtn.label = EVENT.TRADESTYLES_CLOSE;
            registerFlashComponentS(this.eventCoins,HANGAR_ALIASES.EVENT_COINS_COMPONENT);
            this.content.addEventListener(ShopTabEvent.MAINBANNER_CLICK,this.onMainBannerClickHandler);
            this.content.addEventListener(ShopTabEvent.ITEMSBANNER_CLICK,this.onItemsBannerClickHandler);
            this.content.addEventListener(ShopTabEvent.PACKBANNER_CLICK,this.onPackBannerClickHandler);
        }

        override protected function draw() : void
        {
            super.draw();
            if(isInvalid(InvalidationType.SIZE))
            {
                this.bg.width = _width;
                this.bg.height = _height + this.messengerBg.height;
                closeBtn.validateNow();
                closeBtn.x = _width - closeBtn.width - CLOSE_BTN_OFFSET | 0;
                this.messengerBg.y = _height;
                this.messengerBg.width = _width;
            }
        }

        override protected function onBeforeDispose() : void
        {
            this.content.removeEventListener(ShopTabEvent.MAINBANNER_CLICK,this.onMainBannerClickHandler);
            this.content.removeEventListener(ShopTabEvent.ITEMSBANNER_CLICK,this.onItemsBannerClickHandler);
            this.content.removeEventListener(ShopTabEvent.PACKBANNER_CLICK,this.onPackBannerClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.content.dispose();
            this.content = null;
            this.bg = null;
            this.messengerBg = null;
            this.eventCoins = null;
            super.onDispose();
        }

        override protected function onCloseBtn() : void
        {
            closeViewS();
        }

        override protected function onEscapeKeyDown() : void
        {
            if(visible)
            {
                closeViewS();
            }
        }

        private function onMainBannerClickHandler(param1:ShopTabEvent) : void
        {
            onMainBannerClickS();
        }

        private function onItemsBannerClickHandler(param1:ShopTabEvent) : void
        {
            onItemsBannerClickS();
        }

        private function onPackBannerClickHandler(param1:ShopTabEvent) : void
        {
            onPackBannerClickS(param1.id);
        }
    }
}
