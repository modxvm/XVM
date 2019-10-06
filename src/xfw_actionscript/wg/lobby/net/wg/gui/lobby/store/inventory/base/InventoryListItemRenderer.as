package net.wg.gui.lobby.store.inventory.base
{
    import net.wg.gui.lobby.store.StoreListItemRenderer;
    import net.wg.gui.components.controls.AlertIco;
    import net.wg.data.VO.StoreTableData;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.gui.lobby.store.data.StoreTooltipMapVO;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
    import scaleform.clik.utils.Constraints;
    import flash.events.MouseEvent;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.SoundManagerStatesLobby;

    public class InventoryListItemRenderer extends StoreListItemRenderer
    {

        public var alertDiscount:AlertIco = null;

        public function InventoryListItemRenderer()
        {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
            soundId = SoundManagerStatesLobby.RENDERER_INVENTORY;
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

        override protected function onLeftButtonClick(param1:Object) : void
        {
            if(enabled)
            {
                this.sellItem();
            }
        }

        override protected function updateTexts(param1:StoreTableData) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = 0;
            var _loc4_:* = 0;
            var _loc5_:ILocale = null;
            var _loc6_:Function = null;
            var _loc7_:ActionPriceVO = null;
            var _loc8_:* = false;
            if(App.instance)
            {
                _loc2_ = param1.currency;
                _loc3_ = Currencies.INDEX_FROM_NAME[_loc2_];
                _loc4_ = param1.price[_loc3_];
                _loc5_ = App.utils.locale;
                _loc6_ = _loc2_ == CURRENCIES_CONSTANTS.GOLD?_loc5_.gold:_loc5_.integer;
                credits.gotoAndStop(param1.currency);
                credits.price.text = _loc6_(_loc4_);
                _loc7_ = param1.actionPriceDataVo;
                this.alertDiscount.visible = _loc7_ != null;
                if(this.alertDiscount.visible)
                {
                    _loc8_ = param1.currency == CURRENCIES_CONSTANTS.CREDITS;
                    _loc7_.forCredits = _loc8_;
                }
                updateErrorText(param1);
            }
            enabled = !param1.disabled;
        }

        override protected function updateText() : void
        {
        }

        override protected function getTooltipMapping() : StoreTooltipMapVO
        {
            return new StoreTooltipMapVO(TOOLTIPS_CONSTANTS.INVENTORY_VEHICLE,TOOLTIPS_CONSTANTS.INVENTORY_SHELL,TOOLTIPS_CONSTANTS.INVENTORY_MODULE,TOOLTIPS_CONSTANTS.INVENTORY_BATTLE_BOOSTER);
        }

        override protected function configUI() : void
        {
            super.configUI();
            actionPrice.visible = discountBg.visible = false;
            constraints.addElement(this.alertDiscount.name,this.alertDiscount,Constraints.LEFT);
            this.alertDiscount.addEventListener(MouseEvent.MOUSE_OVER,this.onAlertDiscountMouseOverHandler);
        }

        override protected function onDispose() : void
        {
            this.alertDiscount.removeEventListener(MouseEvent.MOUSE_OVER,this.onAlertDiscountMouseOverHandler);
            this.alertDiscount.dispose();
            this.alertDiscount = null;
            super.onDispose();
        }

        public function sellItem() : void
        {
            dispatchEvent(new StoreEvent(StoreEvent.SELL,StoreTableData(data).id));
        }

        private function onAlertDiscountMouseOverHandler(param1:MouseEvent) : void
        {
            showActionPriceTooltip();
        }
    }
}
