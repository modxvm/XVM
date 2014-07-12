package net.wg.data.components
{
   import net.wg.data.constants.Errors;
   
   public class StoreMenuViewData extends AccordionRendererData
   {
      
      public function StoreMenuViewData(param1:Object) {
         super(param1);
      }
      
      private var _fittingType:String = "";
      
      public function get fittingType() : String {
         return this._fittingType;
      }
      
      public function set fittingType(param1:String) : void {
         App.utils.asserter.assertNotNull(param1,"fittingType" + Errors.CANT_NULL);
         this._fittingType = param1;
      }
   }
}
