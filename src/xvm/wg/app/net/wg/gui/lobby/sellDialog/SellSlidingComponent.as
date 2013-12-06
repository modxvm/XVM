package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.data.VO.SellDialogElement;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.utils.ILocale;
   import scaleform.clik.data.DataProvider;
   import flash.geom.Rectangle;


   public class SellSlidingComponent extends UIComponent
   {
          
      public function SellSlidingComponent() {
         this.sellData = [];
         super();
         scrollRect = new Rectangle(0,0,480,270);
      }

      private static const PADDING_FOR_NEXT_ELEMENT:uint = 10;

      public var settingsBtn:SettingsButton;

      public var mask_mc:MovieClip;

      public var slidingScrList:SlidingScrollingList;

      public var expandBg:MovieClip;

      public var sellData:Array;

      public var resultExpand:int = 0;

      private var _isOpened:Boolean = false;

      private var listHeight:int = 0;

      public function getNextPosition() : int {
         return this.expandBg.y + this.expandBg.height + PADDING_FOR_NEXT_ELEMENT;
      }

      public function get isOpened() : Boolean {
         return this._isOpened;
      }

      public function set isOpened(param1:Boolean) : void {
         this._isOpened = param1;
         this.settingsBtn.setingsDropBtn.selected = this.isOpened;
      }

      override protected function configUI() : void {
         super.configUI();
         this.settingsBtn.visible = false;
         this.expandBg.visible = false;
         this.slidingScrList.addEventListener(VehicleSellDialogEvent.LIST_WAS_DRAWN,this.wasDrawnHandler,false,5);
      }

      private function wasDrawnHandler(param1:VehicleSellDialogEvent) : void {
         this.listHeight = param1.listVisibleHight;
         this.updateElements();
      }

      public function setShells(param1:Object) : void {
         var _loc5_:SellDialogElement = null;
         var _loc2_:SellDialogItem = new SellDialogItem();
         var _loc3_:ILocale = App.utils.locale;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.shells.length)
         {
            if(param1.shells[_loc4_] != undefined)
            {
               if(param1.shells[_loc4_].count != 0)
               {
                  _loc5_ = new SellDialogElement();
                  _loc5_.id = param1.shells[_loc4_].userName + " (" + param1.shells[_loc4_].count + " " + _loc3_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                  _loc5_.isRemovable = true;
                  _loc5_.type = SaleItemBlockRenderer.ITEM_TYPE_SHELL;
                  _loc5_.data = param1.shells[_loc4_];
                  if(param1.shells[_loc4_].buyPrice[1] > 0)
                  {
                     _loc5_.inInventory = true;
                  }
                  else
                  {
                     _loc5_.inInventory = false;
                  }
                  _loc5_.moneyValue = param1.shells[_loc4_].sellPrice[0] * param1.shells[_loc4_].count;
                  _loc5_.defMoneyValue = param1.shells[_loc4_].defSellPrice[0] * param1.shells[_loc4_].count;
                  _loc5_.actionPrc = param1.shells[_loc4_].sellActionPrc;
                  _loc2_.elements.push(_loc5_);
               }
            }
            _loc4_++;
         }
         if(_loc2_.elements.length != 0)
         {
            _loc2_.header = DIALOGS.VEHICLESELLDIALOG_AMMO_LABEL;
            this.sellData.push(_loc2_);
         }
      }

      public function setEquipment(param1:Object) : void {
         var _loc4_:SellDialogElement = null;
         var _loc2_:SellDialogItem = new SellDialogItem();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.eqs.length)
         {
            if(param1.eqs[_loc3_] != undefined)
            {
               _loc4_ = new SellDialogElement();
               _loc4_.id = param1.eqs[_loc3_].userName;
               _loc4_.type = SaleItemBlockRenderer.ITEM_TYPE_EQUIPMENT;
               _loc4_.moneyValue = param1.eqs[_loc3_].sellPrice[0];
               _loc4_.defMoneyValue = param1.eqs[_loc3_].defSellPrice[0];
               _loc4_.actionPrc = param1.eqs[_loc3_].sellActionPrc;
               _loc4_.inInventory = true;
               _loc4_.data = param1.eqs[_loc3_];
               _loc4_.isRemovable = true;
               _loc2_.elements.push(_loc4_);
            }
            _loc3_++;
         }
         if(_loc2_.elements.length != 0)
         {
            _loc2_.header = DIALOGS.VEHICLESELLDIALOG_EQUIPMENT;
            this.sellData.push(_loc2_);
         }
      }

      public function calculateOpenedState() : void {
         this.settingsBtn.y = 0;
         this.slidingScrList.y = this.settingsBtn.y + this.settingsBtn.height;
         this.slidingScrList.height = this.listHeight;
         this.expandBg.height = this.slidingScrList.y + this.listHeight-1;
         this.mask_mc.y = this.slidingScrList.y;
         this.mask_mc.height = this.listHeight;
      }

      public function calculateClosedState() : void {
         this.settingsBtn.y = 0;
         this.slidingScrList.height = this.listHeight;
         this.slidingScrList.y = this.slidingScrList.height * -1 + this.settingsBtn.y + this.settingsBtn.height;
         this.mask_mc.y = this.settingsBtn.y + this.settingsBtn.height;
         this.mask_mc.height = 0;
      }

      public function setInventory(param1:Object, param2:Object) : void {
         var _loc11_:SellDialogElement = null;
         var _loc3_:SellDialogItem = new SellDialogItem();
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:SellDialogElement = new SellDialogElement();
         _loc6_.inInventory = true;
         var _loc7_:Number = 0;
         var _loc8_:uint = 0;
         while(_loc8_ < param1.length)
         {
            _loc4_ = _loc4_ + param1[_loc8_][0].sellPrice[0] * param1[_loc8_][0].inventoryCount;
            _loc5_ = _loc5_ + param1[_loc8_][0].defSellPrice[0] * param1[_loc8_][0].inventoryCount;
            _loc7_ = _loc7_ + param1[_loc8_][0].inventoryCount;
            if(param1[_loc8_][1])
            {
               _loc6_.inInventory = true;
            }
            _loc8_++;
         }
         var _loc9_:ILocale = App.utils.locale;
         if(param1.length > 0)
         {
            _loc6_.moneyValue = _loc4_;
            _loc6_.defMoneyValue = _loc5_;
            _loc6_.actionPrc = 0;
            _loc6_.id = _loc9_.makeString(DIALOGS.VEHICLESELLDIALOG_NOTINSTALLED_MODULES) + " (" + _loc7_ + " " + _loc9_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
            _loc6_.isRemovable = true;
            _loc6_.type = SaleItemBlockRenderer.ITEM_TYPE_MODULE;
            _loc6_.data = param1;
            _loc3_.elements.push(_loc6_);
         }
         var _loc10_:uint = 0;
         while(_loc10_ < param2.length)
         {
            if(param2[_loc10_][0] != undefined)
            {
               if(param2[_loc10_][0].inventoryCount != 0)
               {
                  _loc11_ = new SellDialogElement();
                  _loc11_.id = param2[_loc10_][0].userName + " (" + param2[_loc10_][0].inventoryCount + " " + _loc9_.makeString(DIALOGS.VEHICLESELLDIALOG_COUNT) + ")";
                  _loc11_.isRemovable = true;
                  _loc11_.data = param2[_loc10_][0];
                  _loc11_.type = SaleItemBlockRenderer.ITEM_TYPE_SHELL;
                  _loc11_.itemInInventory = true;
                  if(param2[_loc10_][0].buyPrice[1] > 0 || (param2[_loc10_][1]))
                  {
                     _loc11_.inInventory = true;
                  }
                  else
                  {
                     _loc11_.inInventory = false;
                  }
                  _loc11_.moneyValue = param2[_loc10_][0].sellPrice[0] * param2[_loc10_][0].inventoryCount;
                  _loc11_.defMoneyValue = param2[_loc10_][0].defSellPrice[0] * param2[_loc10_][0].inventoryCount;
                  _loc11_.actionPrc = param2[_loc10_][0].sellActionPrc;
                  _loc3_.elements.push(_loc11_);
               }
            }
            _loc10_++;
         }
         if(_loc3_.elements.length != 0)
         {
            _loc3_.header = DIALOGS.VEHICLESELLDIALOG_INVENTORY;
            this.sellData.push(_loc3_);
         }
         this.slidingScrList.dataProvider = new DataProvider(this.sellData);
      }

      private function updateElements() : void {
         this.preInitStates();
         if(this.isOpened)
         {
            this.calculateOpenedState();
            this.mask_mc.visible = true;
            this.slidingScrList.visible = true;
            this.settingsBtn.creditsIT.alpha = 0;
            this.settingsBtn.ddLine.alpha = 1;
         }
         else
         {
            this.calculateClosedState();
            this.mask_mc.visible = false;
            this.slidingScrList.visible = false;
            this.settingsBtn.creditsIT.alpha = 1;
            this.settingsBtn.ddLine.alpha = 0;
         }
      }

      public function preInitStates() : void {
         this.resultExpand = this.settingsBtn.height + this.listHeight-1 - this.expandBg.height;
      }
   }

}