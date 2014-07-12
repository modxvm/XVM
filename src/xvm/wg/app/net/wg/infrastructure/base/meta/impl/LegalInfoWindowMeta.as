package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class LegalInfoWindowMeta extends AbstractWindowView
   {
      
      public function LegalInfoWindowMeta() {
         super();
      }
      
      public var getLegalInfo:Function = null;
      
      public var onCancelClick:Function = null;
      
      public function getLegalInfoS() : void {
         App.utils.asserter.assertNotNull(this.getLegalInfo,"getLegalInfo" + Errors.CANT_NULL);
         this.getLegalInfo();
      }
      
      public function onCancelClickS() : void {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
   }
}
