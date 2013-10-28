package net.wg.data.VO
{


   public class SellDialogElement extends Object
   {
          
      public function SellDialogElement() {
         super();
      }

      private var _id:String;

      private var _isRemovable:Boolean;

      private var _data:Object;

      private var _type:String;

      private var _inInventory:Boolean;

      private var _moneyValue:Number;

      private var _removePrice:Number;

      public function get removePrice() : Number {
         return this._removePrice;
      }

      public function set removePrice(param1:Number) : void {
         this._removePrice = param1;
      }

      public function get moneyValue() : Number {
         return this._moneyValue;
      }

      public function set moneyValue(param1:Number) : void {
         this._moneyValue = param1;
      }

      public function get inInventory() : Boolean {
         return this._inInventory;
      }

      public function set inInventory(param1:Boolean) : void {
         this._inInventory = param1;
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
      }

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         this._data = param1;
      }

      public function get isRemovable() : Boolean {
         return this._isRemovable;
      }

      public function set isRemovable(param1:Boolean) : void {
         this._isRemovable = param1;
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }
   }

}