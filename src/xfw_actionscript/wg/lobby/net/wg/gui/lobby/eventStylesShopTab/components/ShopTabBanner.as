package net.wg.gui.lobby.eventStylesShopTab.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventStylesShopTab.data.BannerDataVO;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventStylesShopTab.events.StylesShopTabEvent;

    public class ShopTabBanner extends SoundButtonEx
    {

        private static const OFFSET:int = 5;

        private static const LINE_OFFSET:int = 6;

        private static const UP:String = "up";

        public var discount:AnimatedTextContainer = null;

        public var header:AnimatedTextContainer = null;

        public var description:BannerDescription = null;

        public var textPrice:TextField = null;

        public var textOldPrice:TextField = null;

        public var textDone:TextField = null;

        public var tokenReward:TextField = null;

        public var iconGold:MovieClip = null;

        public var line:MovieClip = null;

        public var icon:MovieClip = null;

        public var emptyFocusIndicator:MovieClip;

        private var _bannerData:BannerDataVO = null;

        private var _index:int = 0;

        public function ShopTabBanner()
        {
            super();
            preventAutosizing = true;
        }

        override protected function configUI() : void
        {
            super.configUI();
            focusIndicator = this.emptyFocusIndicator;
        }

        override protected function draw() : void
        {
            super.draw();
            if(this._bannerData != null && isInvalid(InvalidationType.DATA))
            {
                this.discount.text = this._bannerData.discount;
                this.header.text = this._bannerData.title;
                this.description.setData(this._bannerData.rewards);
                this.tokenReward.text = this._bannerData.tokenReward;
                enabled = this._bannerData.canBuy;
                this.textPrice.visible = this.iconGold.visible = this.line.visible = this.textOldPrice.visible = this._bannerData.canBuy;
                this.textDone.visible = !this._bannerData.canBuy;
                if(this._bannerData.canBuy)
                {
                    this.textPrice.text = App.utils.locale.integer(this._bannerData.price);
                    this.textOldPrice.text = App.utils.locale.integer(this._bannerData.oldPrice);
                    App.utils.commons.updateTextFieldSize(this.textPrice,true,false);
                    App.utils.commons.updateTextFieldSize(this.textOldPrice,true,false);
                    this.textPrice.x = this.textOldPrice.x + this.textOldPrice.width + OFFSET >> 0;
                    this.iconGold.x = this.textPrice.x + this.textPrice.width >> 0;
                    this.line.x = this.textOldPrice.x + (LINE_OFFSET >> 1);
                    this.line.width = this.textOldPrice.width - LINE_OFFSET;
                }
                else
                {
                    this.textDone.text = EVENT.STYLESSHOP_DONE;
                }
                this.icon.gotoAndStop(this._index + 1);
            }
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            dispatchEvent(new StylesShopTabEvent(StylesShopTabEvent.BANNER_CLICK,this._index));
        }

        public function setData(param1:BannerDataVO, param2:int) : void
        {
            this._bannerData = param1;
            this._index = param2;
            invalidateData();
            if(!this._bannerData.canBuy)
            {
                setState(UP);
            }
        }

        override protected function onDispose() : void
        {
            this.discount.dispose();
            this.discount = null;
            this.header.dispose();
            this.header = null;
            this.description.dispose();
            this.description = null;
            this.textPrice = null;
            this.iconGold = null;
            this.icon = null;
            this.line = null;
            this.emptyFocusIndicator = null;
            this.textOldPrice = null;
            this.textDone = null;
            this.tokenReward = null;
            this._bannerData = null;
            super.onDispose();
        }
    }
}
