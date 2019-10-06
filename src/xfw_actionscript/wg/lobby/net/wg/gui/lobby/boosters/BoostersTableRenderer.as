package net.wg.gui.lobby.boosters
{
    import net.wg.gui.components.controls.TableRenderer;
    import flash.text.TextField;
    import net.wg.gui.components.controls.SoundButtonEx;
    import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
    import net.wg.gui.components.controls.ActionPrice;
    import net.wg.gui.components.controls.IconText;
    import net.wg.gui.lobby.boosters.data.BoostersTableRendererVO;
    import net.wg.infrastructure.managers.ITooltipMgr;
    import scaleform.clik.events.ButtonEvent;
    import flash.events.MouseEvent;
    import scaleform.clik.constants.InvalidationType;
    import net.wg.data.constants.generated.BOOSTER_CONSTANTS;
    import net.wg.data.constants.Currencies;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import org.idmedia.as3commons.util.StringUtils;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.lobby.components.data.BoosterSlotVO;
    import net.wg.data.constants.Values;
    import net.wg.gui.lobby.boosters.events.BoostersWindowEvent;

    public class BoostersTableRenderer extends TableRenderer
    {

        private static const ACTION_BUTTON_TOP_SHOP:int = 58;

        private static const ACTION_BUTTON_TOP_DEFAULT:int = 47;

        private static const GOLD_ACTION_PRICE_PADDING_RIGHT:int = -6;

        public var headerTF:TextField = null;

        public var descriptionTF:TextField = null;

        public var addDescriptionTF:TextField = null;

        public var priceTF:TextField = null;

        public var actionBtn:SoundButtonEx = null;

        public var boosterSlot:IBoosterSlot = null;

        public var creditsActionPrice:ActionPrice = null;

        public var creditsPrice:IconText = null;

        public var goldActionPrice:ActionPrice = null;

        public var goldPrice:IconText = null;

        private var _model:BoostersTableRendererVO = null;

        private var _toolTipMgr:ITooltipMgr;

        public function BoostersTableRenderer()
        {
            this._toolTipMgr = App.toolTipMgr;
            super();
        }

        override public function setData(param1:Object) : void
        {
            this._model = BoostersTableRendererVO(param1);
            this._toolTipMgr.hide();
            invalidateData();
        }

        override protected function configUI() : void
        {
            super.configUI();
            this.actionBtn.mouseEnabledOnDisabled = true;
            this.actionBtn.addEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.boosterSlot.addEventListener(MouseEvent.ROLL_OVER,this.onBoosterSlotRollOverHandler);
            this.boosterSlot.addEventListener(MouseEvent.ROLL_OUT,this.onBoosterSlotRollOutHandler);
        }

        override protected function onDispose() : void
        {
            this.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onActionBtnClickHandler);
            this.boosterSlot.removeEventListener(MouseEvent.ROLL_OVER,this.onBoosterSlotRollOverHandler);
            this.boosterSlot.removeEventListener(MouseEvent.ROLL_OUT,this.onBoosterSlotRollOutHandler);
            this.headerTF = null;
            this.descriptionTF = null;
            this.addDescriptionTF = null;
            this.priceTF = null;
            this.actionBtn.dispose();
            this.actionBtn = null;
            this.boosterSlot.dispose();
            this.boosterSlot = null;
            this.creditsActionPrice.dispose();
            this.creditsActionPrice = null;
            this.goldActionPrice.dispose();
            this.goldActionPrice = null;
            this.creditsPrice.dispose();
            this.creditsPrice = null;
            this.goldPrice.dispose();
            this.goldPrice = null;
            this._model = null;
            this._toolTipMgr = null;
            super.onDispose();
        }

        override protected function draw() : void
        {
            var _loc1_:String = null;
            isPassive = true;
            super.draw();
            mouseEnabled = mouseChildren = true;
            if(isInvalid(InvalidationType.DATA))
            {
                this.showElements(this._model != null);
                this.hidePrice();
                if(this._model != null)
                {
                    this.setSlotData(this._model.boosterSlotVO);
                    this.headerTF.htmlText = this._model.headerText;
                    this.descriptionTF.htmlText = this._model.descriptionText;
                    this.addDescriptionTF.htmlText = this._model.addDescriptionText;
                    this.actionBtn.label = this._model.actionBtnLabel;
                    this.actionBtn.enabled = this._model.actionBtnEnabled;
                    this.actionBtn.tooltip = this._model.actionBtnTooltip;
                    _loc1_ = this._model.rendererState;
                    App.utils.asserter.assert(BOOSTER_CONSTANTS.RENDERER_STATES.indexOf(_loc1_) > -1,"Unknown rendererState: " + _loc1_);
                    if(_loc1_ == BOOSTER_CONSTANTS.RENDERER_STATE_SHOP)
                    {
                        this.setShopState();
                    }
                    else
                    {
                        this.actionBtn.y = ACTION_BUTTON_TOP_DEFAULT;
                    }
                    this.actionBtn.validateNow();
                }
            }
        }

        private function showPrice(param1:IconText, param2:int, param3:String, param4:String) : void
        {
            param1.icon = param3;
            param1.text = String(param2);
            param1.textColor = Currencies.TEXT_COLORS[param4];
            param1.visible = true;
        }

        private function showActionPrice(param1:ActionPrice, param2:ActionPriceVO, param3:String, param4:String) : void
        {
            param1.setData(param2);
            param1.ico = param3;
            param1.state = this._model.actionStyle;
            param1.textColorType = param4;
            param1.visible = true;
            param1.validateNow();
        }

        private function setShopState() : void
        {
            App.utils.asserter.assertNotNull(this._model.price,"Price" + Errors.CANT_NULL);
            this.actionBtn.y = ACTION_BUTTON_TOP_SHOP;
            var _loc1_:int = this.actionBtn.x + this.actionBtn.width;
            var _loc2_:int = this._model.price.newPrices[CURRENCIES_CONSTANTS.CREDITS_INDEX];
            var _loc3_:int = this._model.price.newPrices[CURRENCIES_CONSTANTS.GOLD_INDEX];
            var _loc4_:* = this._model.actionPriceData != null;
            var _loc5_:ActionPriceVO = _loc4_?this._model.actionPriceData:this._model.price;
            if(_loc3_ > 0)
            {
                _loc1_ = this.showGoldPrice(_loc1_,_loc4_,_loc5_,_loc3_);
            }
            if(_loc2_ > 0)
            {
                if(_loc3_ > 0)
                {
                    _loc1_ = this.showPriceOrText(_loc1_);
                }
                this.showCreditsPrice(_loc1_,_loc4_,_loc5_,_loc2_);
            }
        }

        private function showPriceOrText(param1:int) : int
        {
            if(StringUtils.isNotEmpty(this._model.priceText))
            {
                this.priceTF.htmlText = this._model.priceText;
                var param1:int = param1 - this.priceTF.width;
                this.priceTF.x = param1;
                this.priceTF.visible = true;
            }
            return param1;
        }

        private function showCreditsPrice(param1:int, param2:Boolean, param3:ActionPriceVO, param4:int) : void
        {
            if(param2)
            {
                this.showActionPrice(this.creditsActionPrice,param3,IconsTypes.CREDITS,this._model.creditsPriceState);
                this.creditsActionPrice.x = param1;
            }
            else
            {
                this.showPrice(this.creditsPrice,param4,IconsTypes.CREDITS,this._model.creditsPriceState);
                var param1:int = param1 - this.creditsPrice.width;
                this.creditsPrice.x = param1;
            }
        }

        private function showGoldPrice(param1:int, param2:Boolean, param3:ActionPriceVO, param4:int) : int
        {
            if(param2)
            {
                this.showActionPrice(this.goldActionPrice,param3,IconsTypes.GOLD,this._model.goldPriceState);
                this.goldActionPrice.x = param1;
                var param1:int = param1 - (this.goldActionPrice.width + GOLD_ACTION_PRICE_PADDING_RIGHT);
            }
            else
            {
                this.showPrice(this.goldPrice,param4,IconsTypes.GOLD,this._model.goldPriceState);
                param1 = param1 - this.goldPrice.width;
                this.goldPrice.x = param1;
            }
            return param1;
        }

        private function setSlotData(param1:BoosterSlotVO) : void
        {
            this.boosterSlot.icon = param1.icon;
            this.boosterSlot.update(param1);
            this.boosterSlot.enabled = false;
        }

        private function hidePrice() : void
        {
            this.creditsPrice.visible = false;
            this.creditsActionPrice.visible = false;
            this.goldPrice.visible = false;
            this.goldActionPrice.visible = false;
            this.priceTF.visible = false;
        }

        private function showElements(param1:Boolean) : void
        {
            this.headerTF.visible = param1;
            this.descriptionTF.visible = param1;
            this.addDescriptionTF.visible = param1;
            this.actionBtn.visible = param1;
            rendererBg.visible = param1;
            this.boosterSlot.visible = param1;
        }

        private function onBoosterSlotRollOutHandler(param1:MouseEvent) : void
        {
            this._toolTipMgr.hide();
        }

        private function onBoosterSlotRollOverHandler(param1:MouseEvent) : void
        {
            var _loc2_:Number = IBoosterSlot(this.boosterSlot).boosterId;
            if(this._model != null && _loc2_ != Values.DEFAULT_INT)
            {
                this._toolTipMgr.showSpecial(this._model.tooltip,null,_loc2_);
            }
        }

        private function onActionBtnClickHandler(param1:ButtonEvent) : void
        {
            dispatchEvent(new BoostersWindowEvent(BoostersWindowEvent.BOOSTER_ACTION_BTN_CLICK,this._model.id,this._model.questID));
        }
    }
}
