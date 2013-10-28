package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.data.constants.Errors;


   public class WindowViewMeta extends AbstractView
   {
          
      public function WindowViewMeta() {
         super();
      }

      public var onWindowClose:Function = null;

      public var onWindowMinimize:Function = null;

      public function onWindowCloseS() : void {
         App.utils.asserter.assertNotNull(this.onWindowClose,"onWindowClose" + Errors.CANT_NULL);
         this.onWindowClose();
      }

      public function onWindowMinimizeS() : void {
         App.utils.asserter.assertNotNull(this.onWindowMinimize,"onWindowMinimize" + Errors.CANT_NULL);
         this.onWindowMinimize();
      }
   }

}