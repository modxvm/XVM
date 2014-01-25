package net.wg.infrastructure.base.meta.impl
{
   import net.wg.infrastructure.base.AbstractWrapperView;
   import net.wg.data.constants.Errors;


   public class WindowViewMeta extends AbstractWrapperView
   {
          
      public function WindowViewMeta() {
         super();
      }

      public var onWindowMinimize:Function = null;

      public var onSourceLoaded:Function = null;

      public function onWindowMinimizeS() : void {
         App.utils.asserter.assertNotNull(this.onWindowMinimize,"onWindowMinimize" + Errors.CANT_NULL);
         this.onWindowMinimize();
      }

      public function onSourceLoadedS() : void {
         App.utils.asserter.assertNotNull(this.onSourceLoaded,"onSourceLoaded" + Errors.CANT_NULL);
         this.onSourceLoaded();
      }
   }

}