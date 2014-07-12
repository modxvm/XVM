package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class VehicleBuyWindowMeta extends AbstractWindowView
   {
      
      public function VehicleBuyWindowMeta() {
         super();
      }
      
      public var submit:Function = null;
      
      public var storeSettings:Function = null;
      
      public function submitS(param1:Object) : void {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }
      
      public function storeSettingsS(param1:Boolean) : void {
         App.utils.asserter.assertNotNull(this.storeSettings,"storeSettings" + Errors.CANT_NULL);
         this.storeSettings(param1);
      }
   }
}
