package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class ModuleInfoMeta extends AbstractWindowView
   {
      
      public function ModuleInfoMeta() {
         super();
      }
      
      public var onCancelClick:Function = null;
      
      public function onCancelClickS() : void {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
   }
}
