package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.data.VO.SellDialogElement;
   import __AS3__.vec.Vector;
   import net.wg.infrastructure.interfaces.ISaleItemBlockRenderer;


   public class SellDevicesComponent extends UIComponent
   {
          
      public function SellDevicesComponent() {
         this._sellData = [];
         super();
      }

      private static const PADDING_FOR_NEXT_ELEMENT:uint = 5;

      public var complexDevice:SellDialogListItemRenderer;

      public var complDevBg:MovieClip;

      private var devHeight:Number = 0;

      private var complexDevicesArr:SellDialogItem;

      private var _removePrice:Number = 0;

      private var _defRemovePrice:Number = 0;

      private var _actionPrc:Number = 0;

      private var _removeActionPrc:Number = 0;

      private var _sellData:Array;

      override public function dispose() : void {
         super.dispose();
         this.complexDevice.dispose();
         this.complexDevicesArr.dispose();
      }

      override protected function configUI() : void {
         super.configUI();
         this.complexDevice.scrollingRenderrBg.visible = false;
      }

      public function get removePrice() : Number {
         return this._removePrice;
      }

      public function set removePrice(param1:Number) : void {
         this._removePrice = param1;
      }

      public function get defRemovePrice() : Number {
         return this._defRemovePrice;
      }

      public function set defRemovePrice(param1:Number) : void {
         this._defRemovePrice = param1;
      }

      public function get actionPrc() : Number {
         return this._actionPrc;
      }

      public function set actionPrc(param1:Number) : void {
         this._actionPrc = param1;
      }

      public function get removeActionPrc() : Number {
         return this._removeActionPrc;
      }

      public function set removeActionPrc(param1:Number) : void {
         this._removeActionPrc = param1;
      }

      public function get sellData() : Array {
         return this._sellData;
      }

      public function setData(param1:Object) : void {
         var _loc4_:SellDialogElement = null;
         var _loc5_:* = NaN;
         this.complexDevicesArr = new SellDialogItem();
         var _loc2_:SellDialogItem = new SellDialogItem();
         var _loc3_:Number = 0;
         while(_loc3_ < param1.optDevices.length)
         {
            if(param1.optDevices[_loc3_] != undefined)
            {
               _loc4_ = new SellDialogElement();
               _loc4_.id = param1.optDevices[_loc3_].userName;
               _loc4_.type = SaleItemBlockRenderer.ITEM_TYPE_OPTIONAL_DEVICE;
               _loc4_.data = param1.optDevices[_loc3_];
               _loc4_.moneyValue = param1.optDevices[_loc3_].sellPrice[0];
               _loc4_.defMoneyValue = param1.optDevices[_loc3_].defSellPrice[0];
               _loc4_.actionPrc = param1.optDevices[_loc3_].sellActionPrc;
               if(param1.optDevices[_loc3_].isRemovable)
               {
                  _loc4_.isRemovable = true;
                  _loc4_.inInventory = true;
                  _loc2_.elements.push(_loc4_);
               }
               else
               {
                  _loc4_.removePrice = this._removePrice;
                  _loc4_.defRemovePrice = this._defRemovePrice;
                  _loc4_.removeActionPrc = this._removeActionPrc;
                  _loc4_.isRemovable = false;
                  _loc4_.inInventory = true;
                  this.complexDevicesArr.elements.push(_loc4_);
               }
            }
            _loc3_++;
         }
         if(_loc2_.elements.length != 0)
         {
            _loc2_.header = DIALOGS.VEHICLESELLDIALOG_OPTIONALDEVICE;
            this._sellData.push(_loc2_);
         }
         if(this.complexDevicesArr.elements.length != 0)
         {
            this.complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_COMPLEXOPTIONALDEVICE;
            this.complexDevice.setData(this.complexDevicesArr);
            this.complexDevice.visible = true;
            this.complDevBg.visible = true;
            this.complexDevice.validateNow();
            this.complexDevicesArr.header = DIALOGS.VEHICLESELLDIALOG_COMPLEXOPTIONALDEVICE;
            _loc5_ = 14;
            this.devHeight = this.complexDevice.height + _loc5_;
            this.complexDevice.setSize(477,this.complexDevice.height);
         }
         else
         {
            this.complexDevice.visible = false;
            this.complDevBg.visible = false;
            visible = false;
         }
      }

      public function get deviceItemRenderer() : Vector.<ISaleItemBlockRenderer> {
         return this.complexDevice.getRenderers();
      }

      public function getNextPosition() : int {
         return this.complexDevice.y + this.complexDevice.height + PADDING_FOR_NEXT_ELEMENT;
      }
   }

}