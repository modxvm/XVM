package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;


   public class CAPTCHAMeta extends AbstractWindowView
   {
          
      public function CAPTCHAMeta() {
         super();
      }

      public var submit:Function = null;

      public var reload:Function = null;

      public function submitS(param1:String) : void {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }

      public function reloadS() : void {
         App.utils.asserter.assertNotNull(this.reload,"reload" + Errors.CANT_NULL);
         this.reload();
      }
   }

}