package net.wg.gui.lobby.store.shop.base 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.utils.*;
    
    public class ShopTableItemRenderer extends net.wg.gui.lobby.store.StoreListItemRenderer
    {
        public function ShopTableItemRenderer()
        {
            super();
            soundId = net.wg.data.constants.SoundManagerStates.RENDERER_SHOP;
            return;
        }

        protected override function getTooltipMapping():net.wg.gui.lobby.store.StoreTooltipMapVO
        {
            return new net.wg.gui.lobby.store.StoreTooltipMapVO(net.wg.data.constants.Tooltips.SHOP_VEHICLE, net.wg.data.constants.Tooltips.SHOP_SHELL, net.wg.data.constants.Tooltips.SHOP_MODULE);
        }

        public override function setData(arg1:Object):void
        {
            super.setData(arg1);
            if (App.instance && arg1) 
            {
                App.utils.asserter.assert(arg1 is net.wg.data.VO.StoreTableData, "data must extends a StoreTableData class.");
            }
            invalidateData();
            return;
        }

        protected override function updateText():void
        {
            return;
        }

        protected override function updateTexts(arg1:net.wg.data.VO.StoreTableData, arg2:Number, arg3:Number):void
        {
            var loc1:*=arg2;
            var loc2:*=arg1.tableVO.gold;
            if (arg1.currency == net.wg.data.constants.Currencies.CREDITS) 
            {
                loc1 = arg3;
                loc2 = arg1.tableVO.credits;
            }
            if (0 == loc1 && !(arg1.requestType == net.wg.data.constants.FittingTypes.VEHICLE)) 
            {
                arg1.disabled = " ";
            }
            var loc3:*=false;
            if (this._isUseAction) 
            {
                this.updateCreditPriceForAction(arg3, arg2, arg1);
                if (arg2 > arg1.tableVO.gold && arg3 > arg1.tableVO.credits) 
                {
                    loc3 = true;
                }
            }
            else 
            {
                if (loc1 > loc2) 
                {
                    loc3 = true;
                }
                this.updateCredits(arg2, arg1, arg3, loc3);
            }
            if (errorField) 
            {
                errorField.text = arg1.disabled;
                if (arg1.statusLevel) 
                {
                    errorField.textColor = net.wg.gui.lobby.store.STORE_STATUS_COLOR.getColor(arg1.statusLevel);
                }
                else 
                {
                    errorField.textColor = net.wg.gui.lobby.store.STORE_STATUS_COLOR.INFO;
                }
            }
            enabled = !(arg1.disabled || loc3);
            return;
        }

        protected override function onPricesCalculated(arg1:Number, arg2:Number, arg3:net.wg.data.VO.StoreTableData):void
        {
            var loc1:*=arg1 > 0 && arg2 > 0 && arg3.goldShellsForCredits && arg3.itemTypeName == net.wg.data.constants.FittingTypes.SHELL;
            var loc2:*=arg1 > 0 && arg2 > 0 && arg3.goldEqsForCredits && arg3.itemTypeName == net.wg.data.constants.FittingTypes.EQUIPMENT;
            this._isUseAction = loc1 || loc2;
            return;
        }

        protected override function onLeftButtonClick():void
        {
            var loc1:*=net.wg.data.VO.StoreTableData(data);
            if (loc1.disabled) 
            {
                return;
            }
            var loc2:*=loc1.itemTypeName == net.wg.data.constants.FittingTypes.SHELL && loc1.goldShellsForCredits;
            var loc3:*=loc1.itemTypeName == net.wg.data.constants.FittingTypes.EQUIPMENT && loc1.goldEqsForCredits;
            var loc4:*=loc1.tableVO.gold >= loc1.gold;
            var loc5:*=loc1.tableVO.credits >= loc1.credits;
            var loc6:*;
            if (loc6 = loc2 || loc3 ? loc4 || loc5 : loc4 && loc5) 
            {
                this.buyItem();
            }
            return;
        }

        protected function updateCreditPriceForAction(arg1:Number, arg2:Number, arg3:net.wg.data.VO.StoreTableData):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.locale;
                if (arg1 > arg3.tableVO.credits) 
                {
                    credits.gotoAndStop(net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES.ERROR);
                    credits.price.text = loc1.integer(arg1);
                }
                else 
                {
                    credits.gotoAndStop(net.wg.gui.lobby.store.shop.base.ACTION_CREDITS_STATES.ACTION);
                    credits.price.text = loc1.integer(arg1);
                }
            }
            return;
        }

        protected function get isUseAction():Boolean
        {
            return this._isUseAction;
        }

        internal function updateCredits(arg1:Number, arg2:net.wg.data.VO.StoreTableData, arg3:Number, arg4:Boolean):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.locale;
                if (arg4) 
                {
                    credits.gotoAndStop(arg2.currency + "Error");
                }
                else 
                {
                    credits.gotoAndStop(arg2.currency);
                }
                if (arg2.currency != net.wg.data.constants.Currencies.GOLD) 
                {
                    credits.price.text = loc1.integer(arg3);
                }
                else 
                {
                    credits.price.text = loc1.gold(arg1);
                }
            }
            return;
        }

        internal function buyItem():void
        {
            dispatchEvent(new net.wg.gui.lobby.store.StoreEvent(net.wg.gui.lobby.store.StoreEvent.BUY, net.wg.data.VO.StoreTableData(data)));
            return;
        }

        internal var _isUseAction:Boolean=false;
    }
}
