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
          
      public function InventoryListItemRenderer() {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         soundId = SoundManagerStates.RENDERER_INVENTORY;
      }

      override public function setData(param1:Object) : void {
         super.setData(param1);
         if((App.instance) && (param1))
         {
            App.utils.asserter.assert(param1  is  StoreTableData,"data must extends a StoreTableData class.");
         }
         invalidateData();
      }

      public function sellItem() : void {
         dispatchEvent(new StoreEvent(StoreEvent.SELL,StoreTableData(data)));
      }

      override protected function onLeftButtonClick() : void {
         this.sellItem();
      }

      override protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         var _loc6_:ILocale = null;
         var _loc7_:String = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:ActionPriceVO = null;
         if(App.instance)
         {
            _loc6_ = App.utils.locale;
            credits.gotoAndStop(param1.currency);
            _loc7_ = "";
            _loc8_ = 0;
            _loc9_ = 0;
            if(param1.currency == Currencies.GOLD)
            {
               credits.price.text = _loc6_.gold(param2);
               _loc8_ = param2;
               _loc9_ = param5;
               _loc7_ = IconsTypes.GOLD;
            }
            else
            {
               credits.price.text = _loc6_.integer(param3);
               _loc7_ = IconsTypes.CREDITS;
               _loc8_ = param3;
               _loc9_ = param4;
            }
            _loc10_ = new ActionPriceVO(param1.actionPrc,_loc8_,_loc9_,_loc7_,false,param1.requestType);
            actionPrice.setData(_loc10_);
            credits.visible = !actionPrice.visible;
            if(errorField)
            {
               errorField.text = param1.disabled;
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

      override protected function updateText() : void {
          
      }

      override protected function getTooltipMapping() : StoreTooltipMapVO {
         return new StoreTooltipMapVO(Tooltips.INVENTORY_VEHICLE,Tooltips.INVENTORY_SHELL,Tooltips.INVENTORY_MODULE);
      }
   }

}