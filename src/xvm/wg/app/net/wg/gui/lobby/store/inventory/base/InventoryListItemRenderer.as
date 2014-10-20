package net.wg.gui.lobby.store.inventory.base
{
    import net.wg.gui.lobby.store.StoreListItemRenderer;
    import net.wg.data.VO.StoreTableData;
    import net.wg.gui.lobby.store.StoreEvent;
    import net.wg.utils.ILocale;
    import net.wg.gui.components.controls.VO.ActionPriceVO;
    import net.wg.data.constants.Currencies;
    import net.wg.data.constants.IconsTypes;
    import net.wg.gui.lobby.store.STORE_STATUS_COLOR;
    import net.wg.gui.lobby.store.StoreTooltipMapVO;
    import net.wg.data.constants.Tooltips;
    import net.wg.data.constants.SoundTypes;
    import net.wg.data.constants.SoundManagerStates;
    
    public class InventoryListItemRenderer extends StoreListItemRenderer
    {
        
        public function InventoryListItemRenderer()
        {
            super();
            soundType = SoundTypes.RNDR_NORMAL;
            soundId = SoundManagerStates.RENDERER_INVENTORY;
        }
        
        override public function setData(param1:Object) : void
        {
            super.setData(param1);
            if((App.instance) && (param1))
            {
                App.utils.asserter.assert(param1 is StoreTableData,"data must extends a StoreTableData class.");
            }
            invalidateData();
        }
        
        public function sellItem() : void
        {
            dispatchEvent(new StoreEvent(StoreEvent.SELL,StoreTableData(data)));
        }
        
        override protected function onLeftButtonClick() : void
        {
            this.sellItem();
        }
        
        override protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number) : void
        {
            var _loc4_:ILocale = null;
            var _loc5_:String = null;
            var _loc6_:* = NaN;
            var _loc7_:ActionPriceVO = null;
            if(App.instance)
            {
                _loc4_ = App.utils.locale;
                credits.gotoAndStop(param1.currency);
                _loc5_ = "";
                _loc6_ = 0;
                if(param1.currency == Currencies.GOLD)
                {
                    credits.price.text = _loc4_.gold(param2);
                    _loc6_ = param2;
                    _loc5_ = IconsTypes.GOLD;
                }
                else
                {
                    credits.price.text = _loc4_.integer(param3);
                    _loc5_ = IconsTypes.CREDITS;
                    _loc6_ = param3;
                }
                _loc7_ = param1.actionPriceDataVo;
                if(_loc7_)
                {
                    _loc7_.forCredits = param1.currency == Currencies.CREDITS;
                }
                actionPrice.setData(_loc7_);
                credits.visible = !actionPrice.visible;
                if(errorField)
                {
                    errorField.text = param1.statusMessage;
                    if(param1.statusLevel)
                    {
                        errorField.textColor = STORE_STATUS_COLOR.getColor(param1.statusLevel);
                    }
                    else
                    {
                        errorField.textColor = STORE_STATUS_COLOR.INFO;
                    }
                }
            }
            enabled = !param1.disabled;
        }
        
        override protected function updateText() : void
        {
        }
        
        override protected function getTooltipMapping() : StoreTooltipMapVO
        {
            return new StoreTooltipMapVO(Tooltips.INVENTORY_VEHICLE,Tooltips.INVENTORY_SHELL,Tooltips.INVENTORY_MODULE);
        }
    }
}
