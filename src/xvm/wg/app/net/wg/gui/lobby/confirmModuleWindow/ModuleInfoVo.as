package net.wg.gui.lobby.confirmModuleWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ModuleInfoVo extends DAAPIDataClass
   {
          
      public function ModuleInfoVo(param1:Object) {
         super(param1);
      }

      private var _id:int;

      private var _type:String = "";

      private var _icon:String = "";

      private var _name:String = "";

      private var _descr:String = "";

      private var _currency:String = "";

      private var _price:Array = null;

      private var _actionPriceData:Object;

      private var _maxAvailableCount:Array;

      private var _isActionNow:Boolean;

      private var _defaultValue:Number = -1;

      public var extraModuleInfo:String = "";

      public function get isActionNow() : Boolean {
         return this._isActionNow;
      }

      public function set isActionNow(param1:Boolean) : void {
         this._isActionNow = param1;
      }

      public function get maxAvailableCount() : Array {
         return this._maxAvailableCount;
      }

      public function set maxAvailableCount(param1:Array) : void {
         this._maxAvailableCount = param1;
      }

      public function get id() : int {
         return this._id;
      }

      public function set id(param1:int) : void {
         this._id = param1;
      }

      public function get type() : String {
         return this._type;
      }

      public function set type(param1:String) : void {
         this._type = param1;
      }

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
      }

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name = param1;
      }

      public function get descr() : String {
         return this._descr;
      }

      public function set descr(param1:String) : void {
         this._descr = param1;
      }

      public function get currency() : String {
         return this._currency;
      }

      public function set currency(param1:String) : void {
         this._currency = param1;
      }

      public function get price() : Array {
         return this._price;
      }

      public function set price(param1:Array) : void {
         this._price = param1;
      }

      public function get actionPriceData() : Object {
         return this._actionPriceData;
      }

      public function set actionPriceData(param1:Object) : void {
         this._actionPriceData = param1;
      }

      public function get defaultValue() : Number {
         return this._defaultValue;
      }

      public function set defaultValue(param1:Number) : void {
         this._defaultValue = param1;
      }
   }

}