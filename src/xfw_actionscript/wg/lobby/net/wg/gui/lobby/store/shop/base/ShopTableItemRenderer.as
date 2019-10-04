package net.wg.gui.lobby.store.shop.base
{
    import net.wg.gui.lobby.store.StoreListItemRenderer;
    import flash.events.MouseEvent;
    import net.wg.data.VO.StoreTableData;
    import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.generated.FITTING_TYPES;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.utils.ILocale;
    import net.wg.data.constants.SoundManagerStatesLobby;

    public class ShopTableItemRenderer extends StoreListItemRenderer
    {

        private var _isUseGoldAndCredits:Boolean = false;

        public function ShopTableItemRenderer()
        {
            super();
            soundId = SoundManagerStatesLobby.RENDERER_SHOP;
        }

        override protected function configUI() : void
        {
            super.configUI();
            addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
        }

        override protected function onDispose() : void
        {
            removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
            super.onDispose();
        }

        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            if(App.instance && param1)
            {
                App.utils.asserter.assert(param1 is StoreTableData,"data must extends a StoreTableData class.");
            }
            invalidateData();
        }

        override protected function getTooltipMapping() : StoreTooltipMapVO
        {
            return new StoreTooltipMapVO(TOOLTIPS_CONSTANTS.SHOP_VEHICLE,TOOLTIPS_CONSTANTS.SHOP_SHELL,TOOLTIPS_CONSTANTS.SHOP_MODULE,TOOLTIPS_CONSTANTS.SHOP_BATTLE_BOOSTER);
        }

        override protected function updateText() : void
        {
        }

        override protected function updateTexts(param1:StoreTableData) : void
        {
            var _loc2_:String = param1.currency;
            var _loc3_:int = Currencies.INDEX_FROM_NAME[_loc2_];
            var _loc4_:int = param1.price[_loc3_];
            if(_loc4_ == 0 && param1.requestType != FITTING_TYPES.VEHICLE)
            {
                param1.disabled = true;
            }
            this.updateCreditPriceForAction(param1);
            if(!this._isUseGoldAndCredits)
            {
                this.updateCredits(param1);
            }
            updateErrorText(param1);
            enabled = !param1.disabled;
        }

        override protected function onPricesCalculated(param1:StoreTableData) : void
        {
            var _loc2_:int = param1.price[CURRENCIES_CONSTANTS.CREDITS_INDEX];
            var _loc3_:int = param1.price[CURRENCIES_CONSTANTS.GOLD_INDEX];
            var _loc4_:String = param1.itemTypeName;
            var _loc5_:Boolean = _loc3_ > 0 && _loc2_ > 0 && param1.goldShellsForCredits && _loc4_ == FITTING_TYPES.SHELL;
            var _loc6_:Boolean = _loc3_ > 0 && _loc2_ > 0 && param1.goldEqsForCredits && _loc4_ == FITTING_TYPES.EQUIPMENT;
            this._isUseGoldAndCredits = _loc5_ || _loc6_;
        }

        override protected function onLeftButtonClick(param1:Object) : void
        {
            var _loc2_:StoreTableData = null;
            var _loc3_:* = false;
            var _loc4_:* = false;
            var _loc5_:* = false;
            var _loc6_:* = false;
            var _loc7_:* = false;
            if(enabled)
            {
                _loc2_ = StoreTableData(data);
                if(_loc2_.disabled)
                {
                    return;
                }
                _loc3_ = _loc2_.itemTypeName == FITTING_TYPES.SHELL && _loc2_.goldShellsForCredits;
                _loc4_ = _loc2_.itemTypeName == FITTING_TYPES.EQUIPMENT && _loc2_.goldEqsForCredits;
                _loc5_ = _loc2_.gold >= _loc2_.gold;
                _loc6_ = _loc2_.credits >= _loc2_.credits;
                _loc7_ = _loc3_ || _loc4_?_loc5_ || _loc6_:_loc5_ && _loc6_;
                if(_loc7_)
                {
                    this.buyItem();
                }
            }
        }

        protected function updateCreditPriceForAction(param1:StoreTableData) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:ActionPriceVO = null;
            if(App.instance)
            {
                _loc2_ = this._isUseGoldAndCredits?CURRENCIES_CONSTANTS.CREDITS:param1.currency;
                _loc3_ = Currencies.INDEX_FROM_NAME[_loc2_];
                _loc4_ = param1.price[_loc3_];
                if(_loc4_ > param1[_loc2_])
                {
                    credits.gotoAndStop(Currencies.getErrorState(_loc2_));
                }
                else
                {
                    credits.gotoAndStop(_loc2_);
                }
                credits.price.text = App.utils.locale.integer(_loc4_);
                _loc5_ = param1.actionPriceDataVo;
                actionPrice.visible = discountBg.visible = _loc5_ != null;
                if(actionPrice.visible)
                {
                    actionPrice.htmlText = param1.actionPercent[_loc3_];
                }
            }
        }

        protected function buyItem() : void
        {
            dispatchEvent(new StoreEvent(StoreEvent.BUY,StoreTableData(data).id));
        }

        private function updateCredits(param1:StoreTableData) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:* = false;
            var _loc6_:ILocale = null;
            var _loc7_:Function = null;
            var _loc8_:ActionPriceVO = null;
            var _loc9_:* = false;
            if(App.instance)
            {
                _loc2_ = param1.currency;
                _loc3_ = Currencies.INDEX_FROM_NAME[_loc2_];
                _loc4_ = param1.price[_loc3_];
                _loc5_ = _loc4_ > param1[_loc2_];
                credits.gotoAndStop(_loc5_?Currencies.getErrorState(_loc2_):_loc2_);
                _loc6_ = App.utils.locale;
                _loc7_ = CURRENCIES_CONSTANTS.GOLD?_loc6_.gold:_loc6_.integer;
                credits.price.text = _loc7_(_loc4_);
                _loc8_ = param1.actionPriceDataVo;
                if(_loc8_)
                {
                    _loc9_ = param1.currency == CURRENCIES_CONSTANTS.CREDITS;
                    _loc8_.forCredits = _loc9_;
                    actionPrice.htmlText = param1.actionPercent[_loc3_];
                }
            }
        }

        protected function get isUseGoldAndCredits() : Boolean
        {
            return this._isUseGoldAndCredits;
        }

        private function onMouseOverHandler(param1:MouseEvent) : void
        {
            _scheduler.cancelTask(showTooltip);
            _scheduler.scheduleTask(showTooltip,100);
        }
    }
}
