package net.wg.gui.lobby.store.inventory.base 
{
    import net.wg.data.VO.*;
    import net.wg.data.constants.*;
    import net.wg.gui.lobby.store.*;
    import net.wg.utils.*;
    
    public class InventoryListItemRenderer extends net.wg.gui.lobby.store.StoreListItemRenderer
    {
        public function InventoryListItemRenderer()
        {
            super();
            soundType = net.wg.data.constants.SoundTypes.RNDR_NORMAL;
            soundId = net.wg.data.constants.SoundManagerStates.RENDERER_INVENTORY;
            return;
        }

        protected override function onLeftButtonClick():void
        {
            this.sellItem();
            return;
        }

        protected override function updateTexts(arg1:net.wg.data.VO.StoreTableData, arg2:Number, arg3:Number):void
        {
            var loc1:*=null;
            if (App.instance) 
            {
                loc1 = App.utils.locale;
                credits.gotoAndStop(arg1.currency);
                if (arg1.currency != net.wg.data.constants.Currencies.GOLD) 
                {
                    credits.price.text = loc1.integer(arg3);
                }
                else 
                {
                    credits.price.text = loc1.gold(arg2);
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
            }
            enabled = !arg1.disabled;
            return;
        }

        public function sellItem():void
        {
            dispatchEvent(new net.wg.gui.lobby.store.StoreEvent(net.wg.gui.lobby.store.StoreEvent.SELL, net.wg.data.VO.StoreTableData(data)));
            return;
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

        protected override function getTooltipMapping():net.wg.gui.lobby.store.StoreTooltipMapVO
        {
            return new net.wg.gui.lobby.store.StoreTooltipMapVO(net.wg.data.constants.Tooltips.INVENTORY_VEHICLE, net.wg.data.constants.Tooltips.INVENTORY_SHELL, net.wg.data.constants.Tooltips.INVENTORY_MODULE);
        }
    }
}
