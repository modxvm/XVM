package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractConfirmItemDialog;
   import net.wg.data.constants.Errors;


   public class FortOrderConfirmationWindowMeta extends AbstractConfirmItemDialog
   {
          
      public function FortOrderConfirmationWindowMeta() {
         super();
      }

      public var submit:Function = null;

      public var getTimeStr:Function = null;

      public function submitS(param1:Number) : void {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }

      public function getTimeStrS(param1:Number) : String {
         App.utils.asserter.assertNotNull(this.getTimeStr,"getTimeStr" + Errors.CANT_NULL);
         return this.getTimeStr(param1);
      }
   }

}