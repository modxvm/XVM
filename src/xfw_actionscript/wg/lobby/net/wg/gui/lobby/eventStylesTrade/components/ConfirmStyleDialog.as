package net.wg.gui.lobby.eventStylesTrade.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.text.TextField;
    import flash.display.MovieClip;
    import net.wg.utils.ILocale;
    import net.wg.utils.ICommons;
    import net.wg.gui.lobby.eventStylesTrade.data.EventStylesTradeDataVO;
    import scaleform.clik.events.ButtonEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.gui.lobby.eventStylesTrade.events.StylesTradeEvent;

    public class ConfirmStyleDialog extends UIComponentEx
    {

        private static const TITLE_BOTTOM:int = 50;

        public var buyBtn:ISoundButtonEx = null;

        public var cancelBtn:ISoundButtonEx = null;

        public var textHeader:TextField = null;

        public var textDescription:TextField = null;

        public var iconDisable:MovieClip = null;

        public var iconGold:MovieClip = null;

        public var priceTF:TextField = null;

        public var priceTitleTF:TextField = null;

        private var _locale:ILocale;

        private var _commons:ICommons;

        private var _isBundle:Boolean = false;

        private var _data:EventStylesTradeDataVO = null;

        private var _index:int = -1;

        public function ConfirmStyleDialog()
        {
            this._locale = App.utils.locale;
            this._commons = App.utils.commons;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.buyBtn.label = EVENT.TRADESTYLES_BUY;
            this.cancelBtn.label = EVENT.TRADESTYLES_CANCEL;
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelClickHandler);
            this.priceTitleTF.text = EVENT.TRADESTYLES_CONFIRMATIONCOST;
            this._commons.updateTextFieldSize(this.priceTitleTF,true,false);
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            super.draw();
            if(this._data != null && isInvalid(InvalidationType.DATA))
            {
                _loc1_ = this._isBundle?CURRENCIES_CONSTANTS.GOLD:this._data.skins[this._index].currency;
                gotoAndStop(_loc1_);
                if(this._isBundle)
                {
                    this.textHeader.text = this._data.header;
                    this.textDescription.text = this._data.description;
                }
                else
                {
                    this.textHeader.text = this._data.skins[this._index].header;
                    this.textDescription.text = this._data.skins[this._index].description;
                }
                this._commons.updateTextFieldSize(this.textHeader,false,true);
                this._commons.updateTextFieldSize(this.textDescription,true,false);
                this.textHeader.y = TITLE_BOTTOM - this.textHeader.height >> 0;
                this.priceTF.text = this._isBundle?this._data.bundlePrice:this._locale.integer(this._data.skins[this._index].price);
                this._commons.updateTextFieldSize(this.priceTF,true,false);
                this.priceTitleTF.x = -(this.priceTitleTF.width + this.priceTF.width + this.iconGold.width >> 1);
                this.priceTF.x = this.priceTitleTF.x + this.priceTitleTF.width >> 0;
                this.iconGold.x = this.priceTF.x + this.priceTF.width >> 0;
                this.iconDisable.x = -(this.iconDisable.width + this.textDescription.width >> 1);
                this.textDescription.x = this.iconDisable.x + this.iconDisable.width >> 0;
            }
        }

        public function setData(param1:EventStylesTradeDataVO, param2:int, param3:Boolean) : void
        {
            this._isBundle = param3;
            this._data = param1;
            this._index = param2;
            invalidateData();
        }

        override protected function onBeforeDispose() : void
        {
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelClickHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.cancelBtn.dispose();
            this.cancelBtn = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.textHeader = null;
            this.textDescription = null;
            this.iconDisable = null;
            this.iconGold = null;
            this.priceTF = null;
            this.priceTitleTF = null;
            this._data = null;
            this._locale = null;
            this._commons = null;
            super.onDispose();
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            if(this._isBundle)
            {
                dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUNDLE_CONFIRM_CLICK));
            }
            else
            {
                dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUY_CONFIRM_CLICK));
            }
        }

        private function onCancelClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUY_CANCEL_CLICK));
        }
    }
}
