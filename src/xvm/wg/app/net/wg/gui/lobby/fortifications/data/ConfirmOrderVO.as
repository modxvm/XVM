package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ConfirmOrderVO extends DAAPIDataClass
   {
          
      public function ConfirmOrderVO(param1:Object) {
         super(param1);
      }

      private var _orderIcon:String = "";

      private var _name:String = "";

      private var _description:String = "";

      private var _productionTime:int = -1;

      private var _productionCost:int = -1;

      private var _level:int = -1;

      private var _defaultValue:Number = -1;

      private var _maxAvailableCount:Number = -1;

      public function get orderIcon() : String {
         return this._orderIcon;
      }

      public function set orderIcon(param1:String) : void {
         this._orderIcon = param1;
      }

      public function get level() : int {
         return this._level;
      }

      public function set level(param1:int) : void {
         this._level = param1;
      }

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name = param1;
      }

      public function get description() : String {
         return this._description;
      }

      public function set description(param1:String) : void {
         this._description = param1;
      }

      public function get productionTime() : int {
         return this._productionTime;
      }

      public function set productionTime(param1:int) : void {
         this._productionTime = param1;
      }

      public function get productionCost() : int {
         return this._productionCost;
      }

      public function set productionCost(param1:int) : void {
         this._productionCost = param1;
      }

      public function get defaultValue() : Number {
         return this._defaultValue;
      }

      public function set defaultValue(param1:Number) : void {
         this._defaultValue = param1;
      }

      public function get maxAvailableCount() : Number {
         return this._maxAvailableCount;
      }

      public function set maxAvailableCount(param1:Number) : void {
         this._maxAvailableCount = param1;
      }
   }

}