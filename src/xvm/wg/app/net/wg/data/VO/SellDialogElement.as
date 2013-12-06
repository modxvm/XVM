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

      private var _itemInInventory:Boolean = false;

      private var _inInventory:Boolean;

      private var _moneyValue:Number;

      private var _defMoneyValue:Number;

      private var _removePrice:Number;

      private var _defRemovePrice:Number;

      private var _actionPrc:Number = 0;

      private var _removeActionPrc:Number = 0;

      public function get removeActionPrc() : Number {
         return this._removeActionPrc;
      }

      public function set removeActionPrc(param1:Number) : void {
         this._removeActionPrc = param1;
      }

      public function get actionPrc() : Number {
         return this._actionPrc;
      }

      public function set actionPrc(param1:Number) : void {
         this._actionPrc = param1;
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

      public function get moneyValue() : Number {
         return this._moneyValue;
      }

      public function set moneyValue(param1:Number) : void {
         this._moneyValue = param1;
      }

      public function get defMoneyValue() : Number {
         return this._defMoneyValue;
      }

      public function set defMoneyValue(param1:Number) : void {
         this._defMoneyValue = param1;
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

      public function get itemInInventory() : Boolean {
         return this._itemInInventory;
      }

      public function set itemInInventory(param1:Boolean) : void {
         this._itemInInventory = param1;
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