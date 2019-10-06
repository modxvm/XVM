package net.wg.gui.lobby.store.shop
{
    import net.wg.gui.lobby.store.shop.base.ShopTableItemRenderer;
    import net.wg.gui.components.advanced.ExtraModuleIcon;
    import net.wg.gui.components.controls.Money;
    import flash.text.TextField;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import scaleform.clik.utils.Constraints;
    import net.wg.data.VO.StoreTableData;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
    import net.wg.data.constants.Currencies;
    import net.wg.utils.IAssertable;
    import flash.display.DisplayObject;
    import net.wg.data.constants.Errors;
    import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;

    public class ShopModuleListItemRenderer extends ShopTableItemRenderer
    {

        private static const CREDITS_OFFSET_Y:int = 19;

        private static const ACTION_PRICE_OFFSET_Y:int = 23;

        private static const DISCOUNT_BG_OFFSET_Y:int = 1;

        public var moduleIcon:ExtraModuleIcon = null;

        public var secondMoney:Money = null;

        public var vehCount:TextField = null;

        public var count:TextField = null;

        public var icoBg:Sprite = null;

        public var icoDisabled:Sprite = null;

        public var actionPriceLeft:TextField = null;

        public var discountBgLeft:MovieClip = null;

        private var _constraintsAdded:Boolean = false;

        public function ShopModuleListItemRenderer()
        {
            super();
        }

        override protected function onDispose() : void
        {
            if(this.moduleIcon != null)
            {
                this.moduleIcon.dispose();
                this.moduleIcon = null;
            }
            if(this.secondMoney != null)
            {
                this.secondMoney.dispose();
                this.secondMoney = null;
            }
            this.discountBgLeft = null;
            this.vehCount = null;
            this.count = null;
            this.icoBg = null;
            this.icoDisabled = null;
            this.actionPriceLeft = null;
            super.onDispose();
        }

        override protected function configUI() : void
        {
            super.configUI();
            constraints.addElement(this.moduleIcon.name,this.moduleIcon,Constraints.LEFT);
            constraints.addElement(this.count.name,this.count,Constraints.RIGHT);
            constraints.addElement(this.icoBg.name,this.icoBg,Constraints.LEFT);
            constraints.addElement(this.secondMoney.name,this.secondMoney,Constraints.LEFT);
            constraints.addElement(this.actionPriceLeft.name,this.actionPriceLeft,Constraints.LEFT);
            constraints.addElement(this.discountBgLeft.name,this.discountBgLeft,Constraints.LEFT);
            this.actionPriceLeft.mouseEnabled = false;
        }

        override protected function update() : void
        {
            var _loc1_:StoreTableData = null;
            super.update();
            if(data)
            {
                _loc1_ = StoreTableData(data);
                this.updateModuleIcon(_loc1_);
                getHelper().updateCountFields(this.count,this.vehCount,_loc1_);
            }
            else
            {
                getHelper().initModuleIconAsDefault(this.moduleIcon);
            }
        }

        override protected function updateCreditPriceForAction(param1:StoreTableData) : void
        {
            var _loc2_:String = null;
            var _loc3_:* = 0;
            var _loc4_:ActionPriceVO = null;
            if(App.instance)
            {
                _loc2_ = CURRENCIES_CONSTANTS.GOLD;
                super.updateCreditPriceForAction(param1);
                _loc3_ = param1.price[CURRENCIES_CONSTANTS.GOLD_INDEX];
                if(_loc3_ > param1.gold)
                {
                    this.secondMoney.gotoAndStop(Currencies.getErrorState(_loc2_));
                }
                else
                {
                    this.secondMoney.gotoAndStop(_loc2_);
                }
                this.secondMoney.price.text = App.utils.locale.gold(_loc3_);
                _loc4_ = param1.alternativePriceDataVo;
                this.actionPriceLeft.visible = this.discountBgLeft.visible = _loc4_ != null && isUseGoldAndCredits && param1.showActionGoldAndCredits;
                this.secondMoney.visible = isUseGoldAndCredits;
                if(this.actionPriceLeft.visible)
                {
                    _loc4_.forCredits = false;
                    this.actionPriceLeft.htmlText = param1.actionPercent[CURRENCIES_CONSTANTS.GOLD_INDEX];
                    actionPrice.y = height - actionPrice.height - ACTION_PRICE_OFFSET_Y;
                }
                else
                {
                    actionPrice.y = height - actionPrice.height >> 1;
                }
                discountBg.y = actionPrice.y - DISCOUNT_BG_OFFSET_Y;
                credits.y = isUseGoldAndCredits?height - credits.height - CREDITS_OFFSET_Y:height - credits.height >> 1;
            }
        }

        override protected function showTooltip() : void
        {
            if(this.discountBgLeft.visible && this.discountBgLeft.hitTestPoint(App.stage.mouseX,App.stage.mouseY,true))
            {
                this.showActionPriceLeftTooltip();
            }
            else
            {
                super.showTooltip();
            }
        }

        override protected function changedState() : void
        {
            super.changedState();
            this.discountBgLeft.buttonMode = discountBg.buttonMode;
            if(this.icoDisabled != null && !this._constraintsAdded)
            {
                constraints.addElement(this.icoDisabled.name,this.icoDisabled,Constraints.LEFT);
                this._constraintsAdded = true;
            }
        }

        private function updateModuleIcon(param1:StoreTableData) : void
        {
            var _loc3_:IAssertable = null;
            var _loc4_:Array = null;
            var _loc5_:DisplayObject = null;
            if(App.instance)
            {
                _loc3_ = App.utils.asserter;
                _loc4_ = [this.moduleIcon,this.moduleIcon.moduleType,this.moduleIcon.moduleLevel];
                for each(_loc5_ in _loc4_)
                {
                    _loc3_.assertNotNull(_loc5_,_loc5_.name + Errors.CANT_NULL);
                }
            }
            this.moduleIcon.setValuesWithType(param1.requestType,param1.moduleLabel,param1.level);
            this.moduleIcon.extraIconSource = param1.extraModuleInfo;
            var _loc2_:String = param1.highlightType;
            this.moduleIcon.setHighlightType(_loc2_);
            this.moduleIcon.setOverlayType(_loc2_);
        }

        private function showActionPriceLeftTooltip() : void
        {
            var _loc1_:ActionPriceVO = StoreTableData(data).alternativePriceDataVo;
            if(_loc1_)
            {
                App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,_loc1_.type,_loc1_.key,_loc1_.newPrices,_loc1_.oldPrices,_loc1_.isBuying,_loc1_.forCredits,_loc1_.rentPackage);
            }
        }
    }
}
