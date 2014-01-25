package net.wg.gui.lobby.store.shop.base
{
   import net.wg.gui.lobby.store.StoreListItemRenderer;
   import net.wg.data.VO.StoreTableData;
   import net.wg.gui.lobby.store.StoreTooltipMapVO;
   import net.wg.data.constants.Tooltips;
   import net.wg.data.constants.Currencies;
   import net.wg.data.constants.FittingTypes;
   import net.wg.gui.lobby.store.STORE_STATUS_COLOR;
   import net.wg.utils.ILocale;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.data.constants.IconsTypes;
   import net.wg.gui.lobby.store.StoreEvent;
   import net.wg.data.constants.SoundManagerStates;


   public class ShopTableItemRenderer extends StoreListItemRenderer
   {
          
      public function ShopTableItemRenderer() {
         super();
         soundId = SoundManagerStates.RENDERER_SHOP;
         configUI();
      }

      private var _isUseGoldAndCredits:Boolean = false;

      override public function setData(param1:Object) : void {
         super.setData(param1);
         if((App.instance) && (param1))
         {
            App.utils.asserter.assert(param1  is  StoreTableData,"data must extends a StoreTableData class.");
         }
         invalidateData();
      }

      override protected function getTooltipMapping() : StoreTooltipMapVO {
         return new StoreTooltipMapVO(Tooltips.SHOP_VEHICLE,Tooltips.SHOP_SHELL,Tooltips.SHOP_MODULE);
      }

      override protected function updateText() : void {
          
      }

      override protected function updateTexts(param1:StoreTableData, param2:Number, param3:Number, param4:Number, param5:Number) : void {
         var _loc6_:int = param2;
         var _loc7_:Number = param1.tableVO.gold;
         if(param1.currency == Currencies.CREDITS)
         {
            _loc6_ = param3;
            _loc7_ = param1.tableVO.credits;
         }
         if(0 == _loc6_ && !(param1.requestType == FittingTypes.VEHICLE))
         {
            param1.disabled = " ";
         }
         var _loc8_:* = false;
         if(this._isUseGoldAndCredits)
         {
            this.updateCreditPriceForAction(param3,param4,param2,param5,param1);
            if(param2 > param1.tableVO.gold && param3 > param1.tableVO.credits)
            {
               _loc8_ = true;
            }
         }
         else
         {
            if(_loc6_ > _loc7_)
            {
               _loc8_ = true;
            }
            this.updateCredits(param2,param1,param3,_loc8_,param4,param5);
         }
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
         enabled = !((param1.disabled) || (_loc8_));
      }

      override protected function onPricesCalculated(param1:Number, param2:Number, param3:StoreTableData) : void {
         var _loc4_:Boolean = param1 > 0 && param2 > 0 && (param3.goldShellsForCredits) && param3.itemTypeName == FittingTypes.SHELL;
         var _loc5_:Boolean = param1 > 0 && param2 > 0 && (param3.goldEqsForCredits) && param3.itemTypeName == FittingTypes.EQUIPMENT;
         this._isUseGoldAndCredits = (_loc4_) || (_loc5_);
      }

      override protected function onLeftButtonClick() : void {
         var _loc1_:StoreTableData = StoreTableData(data);
         if(_loc1_.disabled)
         {
            return;
         }
         var _loc2_:Boolean = _loc1_.itemTypeName == FittingTypes.SHELL && (_loc1_.goldShellsForCredits);
         var _loc3_:Boolean = _loc1_.itemTypeName == FittingTypes.EQUIPMENT && (_loc1_.goldEqsForCredits);
         var _loc4_:* = _loc1_.tableVO.gold >= _loc1_.gold;
         var _loc5_:* = _loc1_.tableVO.credits >= _loc1_.credits;
         var _loc6_:Boolean = (_loc2_) || (_loc3_)?(_loc4_) || (_loc5_):(_loc4_) && (_loc5_);
         if(_loc6_)
         {
            this.buyItem();
         }
      }

      protected function updateCreditPriceForAction(param1:Number, param2:Number, param3:Number, param4:Number, param5:StoreTableData) : void {
         var _loc6_:ILocale = null;
         var _loc7_:ActionPriceVO = null;
         if(App.instance)
         {
            _loc6_ = App.utils.locale;
            if(param1 > param5.tableVO.credits)
            {
               credits.gotoAndStop(ACTION_CREDITS_STATES.ERROR);
               credits.price.text = _loc6_.integer(param1);
               actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ERROR;
            }
            else
            {
               credits.gotoAndStop(ACTION_CREDITS_STATES.CREDITS);
               credits.price.text = _loc6_.integer(param1);
               actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
            }
            if(actionPrice)
            {
               _loc7_ = new ActionPriceVO(param5.actionPrc,param1,param2,IconsTypes.CREDITS);
               actionPrice.setData(_loc7_);
               credits.visible = !actionPrice.visible;
            }
         }
      }

      protected function get isUseGoldAndCredits() : Boolean {
         return this._isUseGoldAndCredits;
      }

      private function updateCredits(param1:Number, param2:StoreTableData, param3:Number, param4:Boolean, param5:Number, param6:Number) : void {
         var _loc7_:ILocale = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:String = null;
         var _loc11_:ActionPriceVO = null;
         if(App.instance)
         {
            _loc7_ = App.utils.locale;
            if(param4)
            {
               credits.gotoAndStop(param2.currency + "Error");
            }
            else
            {
               credits.gotoAndStop(param2.currency);
            }
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = "";
            if(param2.currency == Currencies.GOLD)
            {
               credits.price.text = _loc7_.gold(param1);
               _loc10_ = IconsTypes.GOLD;
               _loc8_ = param1;
               _loc9_ = param6;
            }
            else
            {
               credits.price.text = _loc7_.integer(param3);
               _loc10_ = IconsTypes.CREDITS;
               _loc8_ = param3;
               _loc9_ = param5;
            }
            _loc11_ = new ActionPriceVO(param2.actionPrc,_loc8_,_loc9_,_loc10_);
            actionPrice.setData(_loc11_);
            credits.visible = !actionPrice.visible;
         }
      }

      private function buyItem() : void {
         dispatchEvent(new StoreEvent(StoreEvent.BUY,StoreTableData(data)));
      }
   }

}