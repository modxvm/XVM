package net.wg.data.VO.generated
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ShopNationFilterData extends DAAPIDataClass
   {
      
      public function ShopNationFilterData(param1:Object) {
         super(param1);
      }
      
      private var _language:Number = -1;
      
      private var _type:String = "";
      
      public function get language() : Number {
         return this._language;
      }
      
      public function set language(param1:Number) : void {
         this._language = param1;
      }
      
      public function get type() : String {
         return this._type;
      }
      
      public function set type(param1:String) : void {
         this._type = param1;
      }
   }
}
