package net.wg.gui.tutorial.meta.impl
{
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.data.constants.Errors;
   
   public class TutorialDialogMeta extends AbstractWindowView
   {
      
      public function TutorialDialogMeta() {
         super();
      }
      
      public var submit:Function = null;
      
      public var cancel:Function = null;
      
      public function submitS() : void {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit();
      }
      
      public function cancelS() : void {
         App.utils.asserter.assertNotNull(this.cancel,"cancel" + Errors.CANT_NULL);
         this.cancel();
      }
   }
}
