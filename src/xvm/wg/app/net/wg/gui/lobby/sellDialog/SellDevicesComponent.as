package net.wg.gui.lobby.sellDialog
{
   import scaleform.clik.core.UIComponent;
   import flash.display.MovieClip;
   import net.wg.data.VO.SellDialogItem;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import __AS3__.vec.Vector;
   import net.wg.gui.lobby.sellDialog.VO.SellOnVehicleOptionalDeviceVo;
   import net.wg.data.VO.SellDialogElement;
   import net.wg.data.constants.FittingTypes;
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

      private var _removePrices:Array = null;

      private var _removePrice:Number = 0;

      private var _removeActionPriceData:Object = null;

      public var removeActionPriceDataVo:ActionPriceVO = null;

      private var _sellData:Array;

      override protected function onDispose() : void {
         super.onDispose();
         this.complexDevice.dispose();
         this.complexDevicesArr.dispose();
      }

      public function setData(param1:Vector.<SellOnVehicleOptionalDeviceVo>) : void {
         var _loc6_:SellDialogElement = null;
         var _loc7_:* = NaN;
         this.complexDevicesArr = new SellDialogItem();
         var _loc2_:SellDialogItem = new SellDialogItem();
         var _loc3_:Number = param1.length;
         var _loc4_:SellOnVehicleOptionalDeviceVo = null;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1[_loc5_];
            _loc6_ = new SellDialogElement();
            _loc6_.id = _loc4_.userName;
            _loc6_.type = FittingTypes.OPTIONAL_DEVICE;
            _loc6_.intCD = _loc4_.intCD;
            _loc6_.count = _loc4_.count;
            _loc6_.moneyValue = _loc4_.sellPrice[0];
            _loc6_.sellActionPriceVo = _loc4_.actionVo;
            _loc6_.removeActionPriceVo = this.removeActionPriceDataVo;
            _loc6_.isRemovable = _loc4_.isRemovable;
            _loc6_.toInventory = _loc4_.toInventory;
            if(_loc4_.isRemovable)
            {
               _loc2_.elements.push(_loc6_);
            }
            else
            {
               _loc6_.removePrice = this.removePrice;
               this.complexDevicesArr.elements.push(_loc6_);
            }
            _loc5_++;
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
            _loc7_ = 14;
            this.devHeight = this.complexDevice.height + _loc7_;
            this.complexDevice.setSize(477,this.complexDevice.height);
         }
         else
         {
            this.complexDevice.visible = false;
            this.complDevBg.visible = false;
            visible = false;
         }
      }

      public function getNextPosition() : int {
         return this.complexDevice.y + this.complexDevice.height + PADDING_FOR_NEXT_ELEMENT;
      }

      public function get removePrices() : Array {
         return this._removePrices;
      }

      public function set removePrices(param1:Array) : void {
         this._removePrices = param1;
         if((this._removePrices) && this._removePrices.length >= 2)
         {
            this.removePrice = this._removePrices[0] > 0?this._removePrices[0]:this._removePrices[1];
         }
      }

      public function get removePrice() : Number {
         return this._removePrice;
      }

      public function set removePrice(param1:Number) : void {
         this._removePrice = param1;
      }

      public function set removeActionPriceData(param1:Object) : void {
         this._removeActionPriceData = param1;
         if(this._removeActionPriceData)
         {
            this.removeActionPriceDataVo = new ActionPriceVO(this._removeActionPriceData);
         }
      }

      public function get removeActionPriceData() : Object {
         return this._removeActionPriceData;
      }

      public function get sellData() : Array {
         return this._sellData;
      }

      public function get deviceItemRenderer() : Vector.<ISaleItemBlockRenderer> {
         return this.complexDevice.getRenderers();
      }

      override protected function configUI() : void {
         super.configUI();
         this.complexDevice.scrollingRenderrBg.visible = false;
      }
   }

}