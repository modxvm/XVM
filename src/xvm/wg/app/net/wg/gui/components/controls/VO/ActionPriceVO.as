package net.wg.gui.components.controls.VO
{
   import net.wg.data.constants.FittingTypes;


   public class ActionPriceVO extends Object
   {
          
      public function ActionPriceVO(param1:Number=undefined, param2:Number=undefined, param3:Number=undefined, param4:String=undefined, param5:Boolean=false, param6:String=undefined, param7:String=undefined) {
         super();
         this.actionPrc = param1;
         this.price = param2;
         this.defPrice = param3;
         this.ico = param4;
         this.useSign = param5;
         this.itemType = param6;
         this.externalSign = param7;
      }

      private var _actionPrc:Number = 0;

      private var _price:Number = 0;

      private var _defPrice:Number = 0;

      private var _ico:String = "credits";

      private var _useSign:Boolean = false;

      private var _itemType:String = "";

      private var _externalSign:String = "";

      private var allowTypes:Array = null;

      public function get actionPrc() : Number {
         return this._actionPrc;
      }

      public function set actionPrc(param1:Number) : void {
         if(param1 == this._actionPrc)
         {
            return;
         }
         this._actionPrc = param1;
      }

      public function get price() : Number {
         return this._price;
      }

      public function set price(param1:Number) : void {
         if(param1 == this._price)
         {
            return;
         }
         this._price = param1;
      }

      public function get defPrice() : Number {
         return this._defPrice;
      }

      public function set defPrice(param1:Number) : void {
         if(param1 == this._defPrice)
         {
            return;
         }
         this._defPrice = param1;
      }

      public function get ico() : String {
         return this._ico;
      }

      public function set ico(param1:String) : void {
         if(param1 == this._ico)
         {
            return;
         }
         this._ico = param1;
      }

      public function get useSign() : Boolean {
         return this._useSign;
      }

      public function set useSign(param1:Boolean) : void {
         if(param1 == this._useSign)
         {
            return;
         }
         this._useSign = param1;
      }

      public function get itemType() : String {
         return this._itemType;
      }

      public function set itemType(param1:String) : void {
         if(param1 == this._itemType)
         {
            return;
         }
         this.allowTypes = [FittingTypes.VEHICLE,FittingTypes.MODULE,FittingTypes.EQUIPMENT,FittingTypes.SHELL,FittingTypes.OPTIONAL_DEVICE];
         if(this.allowTypes.indexOf(param1) == -1)
         {
            return;
         }
         this._itemType = param1;
      }

      public function get externalSign() : String {
         return this._externalSign;
      }

      public function set externalSign(param1:String) : void {
         if(param1 == this._externalSign)
         {
            return;
         }
         this._externalSign = param1;
      }
   }

}