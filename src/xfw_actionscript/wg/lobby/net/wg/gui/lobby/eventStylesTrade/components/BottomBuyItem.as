package net.wg.gui.lobby.eventStylesTrade.components
{
    import net.wg.infrastructure.base.UIComponentEx;
    import net.wg.gui.interfaces.ISoundButtonEx;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import net.wg.gui.components.controls.UILoaderAlt;
    import net.wg.utils.ILocale;
    import net.wg.utils.ICommons;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import net.wg.gui.lobby.eventStylesTrade.data.SkinVO;
    import net.wg.gui.components.paginator.vo.ToolTipVO;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import net.wg.infrastructure.events.ColorSchemeEvent;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.gui.lobby.eventStylesTrade.events.StylesTradeEvent;
    import net.wg.infrastructure.interfaces.IColorScheme;
    import net.wg.data.constants.ColorSchemeNames;

    public class BottomBuyItem extends UIComponentEx
    {

        private static const OFFSET:int = 10;

        private static const ICON_DONE_OFFSET:int = 3;

        private static const ERROR:String = "Error";

        private static const BUNDLE_ERROR:String = "BundleError";

        private static const EVENT_COINS_ERROR:String = "eventCoinsError";

        public var useBtn:ISoundButtonEx = null;

        public var buyBtn:ISoundButtonEx = null;

        public var icon:MovieClip = null;

        public var priceTxt:TextField = null;

        public var textOr:TextField = null;

        public var orSprite:MovieClip = null;

        public var textBundleDescription:TextField = null;

        public var priceBundleTxt:TextField = null;

        public var iconBundle:MovieClip = null;

        public var textDone:TextField = null;

        public var iconDone:MovieClip = null;

        public var buyBundleBtn:ISoundButtonEx = null;

        public var tooltipBuyShape:MovieClip = null;

        public var tooltipBuyBundleShape:MovieClip = null;

        public var textReward:TextField = null;

        public var iconReward:UILoaderAlt = null;

        private var _locale:ILocale;

        private var _commons:ICommons;

        private var _tooltipMgr:ITooltipMgr;

        private var _skinData:SkinVO = null;

        private var _bundleTooltip:ToolTipVO = null;

        private var _bundleNotEnough:Boolean = false;

        private var _priceState:String = "";

        public function BottomBuyItem()
        {
            this._locale = App.utils.locale;
            this._commons = App.utils.commons;
            this._tooltipMgr = App.toolTipMgr;
            super();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.buyBundleBtn.label = EVENT.TRADESTYLES_BUYSTYLES;
            this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.useBtn.addEventListener(ButtonEvent.CLICK,this.onUseBtnClickHandler);
            this.buyBundleBtn.addEventListener(ButtonEvent.CLICK,this.onBuyBundleBtnClickHandler);
            this.buyBtn.addEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
            this.buyBtn.addEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.tooltipBuyShape.addEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
            this.tooltipBuyShape.addEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.tooltipBuyBundleShape.addEventListener(MouseEvent.ROLL_OVER,this.onBuyBundleBtnRollOverHandler);
            this.tooltipBuyBundleShape.addEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.buyBundleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onBuyBundleBtnRollOverHandler);
            this.buyBundleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.iconReward.addEventListener(MouseEvent.ROLL_OVER,this.onIconRewardRollOverHandler);
            this.iconReward.addEventListener(MouseEvent.ROLL_OUT,this.onIconRewardRollOutHandler);
            App.colorSchemeMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
        }

        override protected function onBeforeDispose() : void
        {
            App.colorSchemeMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
            this.iconReward.removeEventListener(MouseEvent.ROLL_OVER,this.onIconRewardRollOverHandler);
            this.iconReward.removeEventListener(MouseEvent.ROLL_OUT,this.onIconRewardRollOutHandler);
            this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
            this.useBtn.removeEventListener(ButtonEvent.CLICK,this.onUseBtnClickHandler);
            this.buyBundleBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyBundleBtnClickHandler);
            this.buyBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
            this.buyBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.tooltipBuyShape.removeEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
            this.tooltipBuyShape.removeEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.tooltipBuyBundleShape.removeEventListener(MouseEvent.ROLL_OVER,this.onBuyBundleBtnRollOverHandler);
            this.tooltipBuyBundleShape.removeEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            this.buyBundleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onBuyBundleBtnRollOverHandler);
            this.buyBundleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
            super.onBeforeDispose();
        }

        override protected function onDispose() : void
        {
            this.iconReward.dispose();
            this.iconReward = null;
            this.textReward = null;
            this.useBtn.dispose();
            this.useBtn = null;
            this.buyBtn.dispose();
            this.buyBtn = null;
            this.iconDone = null;
            this.textDone = null;
            this.icon = null;
            this.priceTxt = null;
            this.textOr = null;
            this.orSprite = null;
            this.textBundleDescription = null;
            this.priceBundleTxt = null;
            this.iconBundle = null;
            this.buyBundleBtn.dispose();
            this.buyBundleBtn = null;
            this.tooltipBuyShape = null;
            this.tooltipBuyBundleShape = null;
            this._locale = null;
            this._commons = null;
            this._skinData = null;
            this._tooltipMgr = null;
            this._bundleTooltip = null;
            super.onDispose();
        }

        public function setData(param1:SkinVO, param2:Boolean, param3:String, param4:ToolTipVO, param5:Boolean) : void
        {
            var _loc6_:* = 0;
            this._skinData = param1;
            this._bundleTooltip = param4;
            this._bundleNotEnough = param5;
            this.textBundleDescription.visible = this.orSprite.visible = this.textOr.visible = this.priceBundleTxt.visible = this.iconBundle.visible = this.buyBundleBtn.visible = param2;
            this.priceTxt.visible = this.icon.visible = this.buyBtn.visible = !param1.haveInStorage;
            this.textDone.visible = this.iconDone.visible = this.useBtn.visible = param1.haveInStorage;
            this.tooltipBuyShape.visible = !param1.haveInStorage && param1.notEnoughCount > 0 && !param1.buyButtonEnabled;
            this.tooltipBuyBundleShape.visible = param2 && param5 && !param1.buyButtonEnabled;
            this.iconReward.visible = this.textReward.visible = param1.hasReward && !param1.haveInStorage;
            if(!param1.haveInStorage)
            {
                this._priceState = param1.currency;
                if(param1.notEnoughCount > 0)
                {
                    this._priceState = this._priceState + ERROR;
                }
                else if(param5)
                {
                    this._priceState = this._priceState + BUNDLE_ERROR;
                }
                gotoAndStop(this._priceState);
                if(_baseDisposed)
                {
                    return;
                }
                this.updatePriceColor();
                this.priceTxt.text = this._locale.integer(param1.price);
                this._commons.updateTextFieldSize(this.priceTxt,true,false);
                this.buyBtn.label = EVENT.TRADESTYLES_BUYSTYLE;
                this.iconReward.source = this._skinData.rewardIcon;
                _loc6_ = 0;
                if(param2)
                {
                    this.textBundleDescription.text = EVENT.TRADESTYLES_BUNDLE;
                    this.priceBundleTxt.text = param3;
                    this.textOr.text = EVENT.TANKPANEL_OR;
                    this._commons.updateTextFieldSize(this.textOr,true,false);
                    this._commons.updateTextFieldSize(this.textBundleDescription,true,false);
                    this._commons.updateTextFieldSize(this.priceBundleTxt,true,false);
                    _loc6_ = OFFSET + this.orSprite.width + OFFSET + this.textBundleDescription.width + OFFSET + this.priceBundleTxt.width + this.iconBundle.width + OFFSET + this.buyBundleBtn.width;
                }
                else if(this.textReward.visible)
                {
                    this.textReward.text = EVENT.TRADESTYLES_REWARD;
                    _loc6_ = OFFSET + this.textReward.textWidth + OFFSET + this.iconReward.originalWidth;
                }
                this._commons.updateTextFieldSize(this.textReward,true,false);
                this.priceTxt.x = -this.priceTxt.width - this.icon.width - this.buyBtn.width - OFFSET - _loc6_ >> 1;
                this.icon.x = this.priceTxt.x + this.priceTxt.width >> 0;
                this.buyBtn.x = this.icon.x + this.icon.width + OFFSET >> 0;
                if(param2)
                {
                    this.orSprite.x = this.buyBtn.x + this.buyBtn.width + OFFSET >> 0;
                    this.textOr.x = this.orSprite.x + (this.orSprite.width - this.textOr.width >> 1);
                    this.textBundleDescription.x = this.orSprite.x + this.orSprite.width + OFFSET >> 0;
                    this.priceBundleTxt.x = this.textBundleDescription.x + this.textBundleDescription.width + OFFSET >> 0;
                    this.iconBundle.x = this.priceBundleTxt.x + this.priceBundleTxt.width >> 0;
                    this.buyBundleBtn.x = this.iconBundle.x + this.iconBundle.width + OFFSET >> 0;
                    this.tooltipBuyBundleShape.x = this.priceBundleTxt.x;
                    this.tooltipBuyBundleShape.width = this.buyBundleBtn.x + this.buyBundleBtn.width - this.priceBundleTxt.x >> 0;
                }
                else
                {
                    this.textReward.x = this.buyBtn.x + this.buyBtn.width + OFFSET >> 0;
                    this.iconReward.x = this.textReward.x + this.textReward.width + OFFSET >> 0;
                }
                this.tooltipBuyShape.x = this.priceTxt.x;
                this.tooltipBuyShape.width = this.buyBtn.x + this.buyBtn.width - this.priceTxt.x >> 0;
                this.buyBundleBtn.enabled = this.buyBtn.enabled = param1.buyButtonEnabled;
            }
            else
            {
                this.textDone.text = EVENT.TRADESTYLES_SKINDONE;
                this._commons.updateTextFieldSize(this.textDone,true,false);
                this.useBtn.label = param1.haveTank?EVENT.TRADESTYLES_BUTTONCUSTOMIZATION:EVENT.TRADESTYLES_BUTTONSTORAGE;
                this.iconDone.x = -this.iconDone.width - ICON_DONE_OFFSET - this.textDone.width - OFFSET - this.useBtn.width >> 1;
                this.textDone.x = this.iconDone.x + this.iconDone.width + ICON_DONE_OFFSET >> 0;
                this.useBtn.x = this.textDone.x + this.textDone.width + OFFSET >> 0;
            }
        }

        private function showTooltip(param1:ToolTipVO) : void
        {
            if(param1 != null)
            {
                if(StringUtils.isNotEmpty(param1.tooltip))
                {
                    this._tooltipMgr.showComplex(param1.tooltip);
                }
                else
                {
                    this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[param1.specialAlias,null].concat(param1.specialArgs));
                }
            }
        }

        private function onBuyBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUY_CLICK));
        }

        private function onUseBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.USE_CLICK));
        }

        private function onBuyBundleBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new StylesTradeEvent(StylesTradeEvent.BUNDLE_CLICK));
        }

        private function onBuyBtnRollOverHandler(param1:MouseEvent) : void
        {
            if(this._skinData.notEnoughCount > 0)
            {
                this.showTooltip(this._skinData);
            }
        }

        private function onBuyBundleBtnRollOverHandler(param1:MouseEvent) : void
        {
            if(this._bundleNotEnough)
            {
                this.showTooltip(this._bundleTooltip);
            }
        }

        private function onBuyBtnRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function onIconRewardRollOverHandler(param1:MouseEvent) : void
        {
            this.showTooltip(this._skinData.rewardTooltip);
        }

        private function onIconRewardRollOutHandler(param1:MouseEvent) : void
        {
            this._tooltipMgr.hide();
        }

        private function updatePriceColor() : void
        {
            var _loc1_:IColorScheme = null;
            if(this._priceState == EVENT_COINS_ERROR)
            {
                _loc1_ = App.colorSchemeMgr.getScheme(ColorSchemeNames.RED_PURPLE_SCHEMA);
                this.priceTxt.textColor = _loc1_.rgb;
            }
        }

        private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
        {
            this.updatePriceColor();
        }
    }
}
