package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class VehicleSelectorFilterVO extends DAAPIDataClass
   {
          
      public function VehicleSelectorFilterVO(param1:Object) {
         super(param1);
      }

      private var _nation:int = -1;

      private var _vehicleType:String = "";

      private var _isMain:Boolean = false;

      private var _vehicleTypesDP:Array = null;

      public function get vehicleTypesDP() : Array {
         return this._vehicleTypesDP;
      }

      public function set vehicleTypesDP(param1:Array) : void {
         this._vehicleTypesDP = param1;
      }

      public function get nation() : int {
         return this._nation;
      }

      public function set nation(param1:int) : void {
         this._nation = param1;
      }

      public function get vehicleType() : String {
         return this._vehicleType;
      }

      public function set vehicleType(param1:String) : void {
         this._vehicleType = param1;
      }

      public function get isMain() : Boolean {
         return this._isMain;
      }

      public function set isMain(param1:Boolean) : void {
         this._isMain = param1;
      }
   }

}