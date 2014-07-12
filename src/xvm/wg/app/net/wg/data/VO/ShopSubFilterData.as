package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   import net.wg.data.constants.Errors;
   
   public class ShopSubFilterData extends DAAPIDataClass
   {
      
      public function ShopSubFilterData(param1:Object) {
         super(param1);
      }
      
      private var _current:String = "";
      
      private var _dataProvider:DataProvider = null;
      
      private var _nation:int = -1;
      
      private var _kind:String = "";
      
      private var _requestTypes:Array = null;
      
      private var _fitsType:String = "";
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Object = null;
         if(param1 == "dataProvider")
         {
            if(App.instance)
            {
               App.utils.asserter.assert(param2 is Array,"value must extends an Array class.");
            }
            if(this._dataProvider)
            {
               this._dataProvider.cleanUp();
            }
            else
            {
               this._dataProvider = new DataProvider();
            }
            for each(_loc3_ in param2)
            {
               this._dataProvider.push(new ShopVehicleFilterElementData(_loc3_));
            }
            return false;
         }
         return true;
      }
      
      public function get dataProvider() : DataProvider {
         return this._dataProvider;
      }
      
      public function get current() : String {
         return this._current;
      }
      
      public function set current(param1:String) : void {
         var _loc2_:String = null;
         if(App.instance)
         {
            _loc2_ = "invalid current value for filter data: " + param1;
            if(param1 == null)
            {
               DebugUtils.LOG_WARNING("value \"current\" for filter data" + Errors.CANT_NULL);
            }
            App.utils.asserter.assert(!(param1 == "0"),_loc2_);
         }
         this._current = param1;
      }
      
      public function get nation() : int {
         return this._nation;
      }
      
      public function set nation(param1:int) : void {
         this._nation = param1;
      }
      
      public function get requestTypes() : Array {
         return this._requestTypes;
      }
      
      public function set requestTypes(param1:Array) : void {
         this._requestTypes = param1;
      }
      
      public function get kind() : String {
         return this._kind;
      }
      
      public function set kind(param1:String) : void {
         this._kind = param1;
      }
      
      public function get fitsType() : String {
         return this._fitsType;
      }
      
      public function set fitsType(param1:String) : void {
         this._fitsType = param1;
      }
   }
}
