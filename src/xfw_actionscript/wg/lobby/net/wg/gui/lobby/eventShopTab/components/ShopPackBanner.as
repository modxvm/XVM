package net.wg.gui.lobby.eventShopTab.components
{
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.gui.lobby.eventStylesShopTab.components.BannerDescription;
    import net.wg.gui.lobby.eventShopTab.data.EventPackVO;
    import net.wg.utils.ILocale;
    import net.wg.utils.ICommons;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.gui.lobby.eventShopTab.events.ShopTabEvent;

    public class ShopPackBanner extends SoundButtonEx
    {

        private static const LINE_OFFSET:int = 6;

        private static const OFFSET:int = 5;

        public var titleTF:AnimatedTextContainer = null;

        public var descriptionTF:AnimatedTextContainer = null;

        public var buyQuantityTF:TextField = null;

        public var priceTF:TextField = null;

        public var oldPriceTF:TextField = null;

        public var discountTF:TextField = null;

        public var iconGold:MovieClip = null;

        public var emptyFocusIndicator:MovieClip = null;

        public var description:BannerDescription = null;

        public var line:MovieClip = null;

        public var packImage:MovieClip = null;

        private var _bannerData:EventPackVO = null;

        private var _id:int = 0;

        private var _locale:ILocale;

        private var _commons:ICommons;

        public function ShopPackBanner()
        {
            this._locale = App.utils.locale;
            this._commons = App.utils.commons;
            super();
            preventAutosizing = true;
        }

        public function setData(param1:EventPackVO) : void
        {
            this._bannerData = param1;
            this._id = param1.id;
            invalidateData();
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
                this.priceTF.visible = this.iconGold.visible = this.line.visible = this.oldPriceTF.visible = this._bannerData.canBuy;
                this.description.setData(this._bannerData.rewards);
                this.titleTF.text = this._bannerData.title;
                this.descriptionTF.htmlText = this._bannerData.description;
                this.buyQuantityTF.htmlText = this._bannerData.buyQuantity;
                this.priceTF.text = this._locale.integer(this._bannerData.price);
                this.oldPriceTF.text = this._locale.integer(this._bannerData.oldPrice);
                this.discountTF.text = this._bannerData.discount;
                this._commons.updateTextFieldSize(this.priceTF,true,false);
                this._commons.updateTextFieldSize(this.oldPriceTF,true,false);
                this.priceTF.x = this.oldPriceTF.x + this.oldPriceTF.width + OFFSET >> 0;
                this.iconGold.x = this.priceTF.x + this.priceTF.width >> 0;
                this.line.x = this.oldPriceTF.x + (LINE_OFFSET >> 1);
                this.line.width = this.oldPriceTF.width - LINE_OFFSET;
                this.packImage.gotoAndStop(this._id + 1);
            }
        }

        override protected function onDispose() : void
        {
            this.description.dispose();
            this.description = null;
            this.titleTF.dispose();
            this.titleTF = null;
            this.descriptionTF.dispose();
            this.descriptionTF = null;
            this.line = null;
            this.packImage = null;
            this.buyQuantityTF = null;
            this.priceTF = null;
            this.oldPriceTF = null;
            this.discountTF = null;
            this.iconGold = null;
            this.emptyFocusIndicator = null;
            this._bannerData = null;
            this._locale = null;
            this._commons = null;
            super.onDispose();
        }

        override protected function handleClick(param1:uint = 0) : void
        {
            super.handleClick(param1);
            dispatchEvent(new ShopTabEvent(ShopTabEvent.PACKBANNER_CLICK,this._id));
        }
    }
}
