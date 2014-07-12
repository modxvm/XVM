package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractConfirmItemDialog;
   import net.wg.data.constants.Errors;
   
   public class ConfirmModuleWindowMeta extends AbstractConfirmItemDialog
   {
      
      public function ConfirmModuleWindowMeta() {
         super();
      }
      
      public var submit:Function = null;
      
      public function submitS(param1:Number, param2:String) : void {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1,param2);
      }
   }
}
